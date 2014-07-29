From: achandran@mvista.com (Arun Chandran)
Date: Tue, 29 Jul 2014 18:02:23 +0530
Subject: Kexec on arm64
In-Reply-To: <1406592548.28348.49.camel@smoke>
References: <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
Message-ID: <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Jul 29, 2014 at 5:39 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi,
>
> On Mon, 2014-07-28 at 16:38 +0100, Mark Rutland wrote:
>> On Mon, Jul 28, 2014 at 04:00:18PM +0100, Arun Chandran wrote:
>> > I have these changes to the code.
>> >         flush_icache_range((unsigned long)reboot_code_buffer,
>> > -               relocate_new_kernel_size);
>> > +               (unsigned long)(reboot_code_buffer + relocate_new_kernel_size));
>
> Thanks, I introduced this in my last version in an attempt to clean up
> the code, but on studying setup_restart(), I wonder if we even need to
> do this icache flush here (see below).
>
>> >         /*
>> >          * Flush any data used by relocate_new_kernel in preparation for
>> > #########
>> > Passing of second variable to flush_icache_range() is wrong
>> > it expects an address not length.
>>
>> A simpler option would be to nuke the entire icache before branching to
>> the new image.
>
> flush_cache_all(), which is called by setup_restart(), does a 'ic
> ialluis'.  The ARM says that this will invalidate all instruction caches
> for the inner shareable domain.  Do we need something more?
>
>> > 2)
>> >
>> > #######
>> > diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
>> > index 9ed7327..e3fc8d6 100644
>> > --- a/arch/arm64/kernel/process.c
>> > +++ b/arch/arm64/kernel/process.c
>> >
>> > @@ -84,12 +91,17 @@ void soft_restart(unsigned long addr)
>> >  {
>> >         typedef void (*phys_reset_t)(unsigned long);
>> >         phys_reset_t phys_reset;
>> > +       unsigned long jump_addr = addr;
>> > +
>> > +       phys_reset = (phys_reset_t)virt_to_phys(cpu_reset);
>> > +
>> > +       __flush_dcache_area(&jump_addr, 8);
>> > +       __flush_dcache_area(&phys_reset, 8);
>>
>> Are these values really not getting stashed in registers?
>
> Looking at the disassembled code of soft_restart() from my compiler,
> addr is being saved on the stack over the call to setup_restart(), which
> I would expect it to do.
>
Yes my compiler also saves this in stack

>> If the compiler is spilling, then we have absolutely no guarantee about
>> any part of the stack. If that's the case, then we can't use the stack
>> at all. These need to be rewritten in asm if the compiler is spilling.
>
> I think we just need to put the restart addr in a variable and flush
> that to the PoC.
>
> Arun, I pushed out a fixed version of soft_restart(), so please try
> another UP + L3 boot.
>

The default code did not work.

It is working with the change below

###############
diff --git a/arch/arm64/kernel/machine_kexec.c
b/arch/arm64/kernel/machine_kexec.c
index 5632473..7c5f859 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -147,12 +147,17 @@ static bool kexec_is_dtb_user(const dtb_t *dtb)
 /**
  * kexec_list_walk - Helper to walk the kimage page list.
  */
-
+static int kexec_kernel_size;
+#define IMG_SIZE_NONE  0
+#define KERN_SIZE_FLAG 1
+#define DTB_SIZE_FLAG  2
 static void kexec_list_walk(void *ctx, unsigned long kimage_head,
        void (*cb)(void *ctx, unsigned int flag, void *addr, void *dest))
 {
        void *dest;
        unsigned long *entry;
+       int imgsize_flag = IMG_SIZE_NONE;
+

        for (entry = &kimage_head, dest = NULL; ; entry++) {
                unsigned int flag = *entry & IND_FLAGS;
@@ -164,10 +169,18 @@ static void kexec_list_walk(void *ctx, unsigned
long kimage_head,
                        cb(ctx, flag, addr, NULL);
                        break;
                case IND_DESTINATION:
+                       if (imgsize_flag == IMG_SIZE_NONE) {
+                               kexec_kernel_size = 0;
+                               imgsize_flag = KERN_SIZE_FLAG;
+                       } else if (imgsize_flag == KERN_SIZE_FLAG) {
+                               imgsize_flag = DTB_SIZE_FLAG;
+                       }
                        dest = addr;
                        cb(ctx, flag, addr, NULL);
                        break;
                case IND_SOURCE:
+                       if (imgsize_flag == KERN_SIZE_FLAG)
+                               kexec_kernel_size++;
                        cb(ctx, flag, addr, dest);
                        dest += PAGE_SIZE;
                        break;
@@ -693,5 +706,20 @@ void machine_kexec(struct kimage *image)

        kexec_list_walk(NULL, image->head, kexec_list_flush_cb);

+       /*
+        * Make sure virtual addresses of new kernel are flushed
+        * SZ_512K = TEXT_OFFSET
+        * kexec_kernel = kexec_kernel_size * PAGE_SIZE
+        * Don't know = (SZ_4M + SZ_1M)
+        * SZ_4M = not working
+        * SZ_6M = working
+        * SZ_8M = working
+        *
+        * so chose SZ_4M + SZ_1M; Don't know why this is required
+        * BSS, stack ??
+        *
+        */
+       __flush_dcache_area((void *)PAGE_OFFSET, SZ_512K +
(kexec_kernel_size * PAGE_SIZE) + SZ_4M + SZ_1M);
+
        soft_restart(reboot_code_buffer_phys);
 }


--Arun
