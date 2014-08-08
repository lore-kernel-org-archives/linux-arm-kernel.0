From: achandran@mvista.com (Arun Chandran)
Date: Fri, 8 Aug 2014 15:33:45 +0530
Subject: Kexec on arm64
In-Reply-To: <CAFdej03udSLMEneKM4YGiNe-HTQwZrGQ5J6DfB6qaq8X8A27CQ@mail.gmail.com>
References: <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
 <20140724093603.GC4079@leverpostej>
 <1406247468.4062.59.camel@smoke>
 <CAFdej01w_pE6vv+13cCCyfDs4Rbdkzx4CMUj9q97HBKV0B53ow@mail.gmail.com>
 <1406333901.4062.69.camel@smoke>
 <CAFdej014ohCFYvoUAXWiYGb4_4UmSY2G1MH-NEE_cF1cC-6Mow@mail.gmail.com>
 <20140728153812.GA2576@leverpostej>
 <1406592548.28348.49.camel@smoke>
 <CAFdej00is0kC-1q5uMNJL5APL1WezdNBg0jASgwYamsg5NO_Tg@mail.gmail.com>
 <20140729133557.GQ2576@leverpostej>
 <1406668741.28348.75.camel@smoke>
 <CAFdej02sTBsjHz+FCqjKkY9pF5sPF6n6QUtEadHi0hK3MxRxGA@mail.gmail.com>
 <CAFdej01ZHkTVZuN_0RrGbFmoG4_NTnwm6KDAPM_sf=zHBHSRwg@mail.gmail.com>
 <1407172869.8971.54.camel@smoke>
 <CAFdej02ZsLuxd84fb-n9Q2yuhzqRba5cmx6G8pHk3QeqzpTLaQ@mail.gmail.com>
 <1407442058.8971.106.camel@smoke>
 <CAFdej03udSLMEneKM4YGiNe-HTQwZrGQ5J6DfB6qaq8X8A27CQ@mail.gmail.com>
Message-ID: <CAFdej02gA7mpkdarjZ+66C252K+grhCa4uXm8PTV4ioKXZKqjQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 8, 2014 at 11:16 AM, Arun Chandran <achandran@mvista.com> wrote:
> Hi,
>
> On Fri, Aug 8, 2014 at 1:37 AM, Geoff Levand <geoff@infradead.org> wrote:
>> Hi Arun,
>>
>> On Wed, 2014-08-06 at 19:24 +0530, Arun Chandran wrote:
>>
>>> I have managed to run this test till 72 times with the
>>> below changes.
>>>
>>> ############################
>>> diff --git a/arch/arm64/kernel/machine_kexec.c
>>> b/arch/arm64/kernel/machine_kexec.c
>>> index 363a246..7de11ee 100644
>>> --- a/arch/arm64/kernel/machine_kexec.c
>>> +++ b/arch/arm64/kernel/machine_kexec.c
>>> @@ -623,7 +623,6 @@ static void kexec_list_flush_cb(void *ctx ,
>>> unsigned int flag,
>>>   break;
>>>   case IND_SOURCE:
>>>   __flush_dcache_area(addr, PAGE_SIZE);
>>> - __flush_dcache_area(dest, PAGE_SIZE);
>>>   break;
>>>   default:
>>>   break;
>>> @@ -641,6 +640,8 @@ void machine_kexec(struct kimage *image)
>>>   phys_addr_t reboot_code_buffer_phys;
>>>   void *reboot_code_buffer;
>>>   struct kexec_ctx *ctx = kexec_image_to_ctx(image);
>>> + unsigned long start, end;
>>> + int i;
>>>
>>>   BUG_ON(relocate_new_kernel_size > KEXEC_CONTROL_PAGE_SIZE);
>>>   BUG_ON(num_online_cpus() > 1);
>>> @@ -698,6 +699,20 @@ void machine_kexec(struct kimage *image)
>>>
>>>   kexec_list_walk(NULL, image->head, kexec_list_flush_cb);
>>>
>>> + start = image->segment[0].mem;
>>> + end = image->segment[0].mem + image->segment[0].memsz;
>>> + for (i = 0; i < image->nr_segments; i++) {
>>> + if (image->segment[i].mem > end)
>>> + end = image->segment[i].mem + image->segment[i].memsz;
>>> + }
>>> +
>>> + start = (unsigned long)phys_to_virt(start);
>>> + end = (unsigned long)phys_to_virt(end);
>>> + pr_info("flushing from %lx to %lx size = %lx\n", start, end, end - start);
>>> + __flush_dcache_area((void *)start, end - start);
>>> + //flush_icache_range(start, end);
>>> + //mdelay(10);
>>> +
>>>   soft_restart(reboot_code_buffer_phys);
>>>  }
>>
>> Doing the flush in kexec_list_flush_cb() is almost the same
>> as using the image->segment to flush.  Did you see a
>> difference on your system?
>>
>
> Yes I can see the difference. Let me explain it in detail.
>
> I am doing a stress test of "kexec -e" with the below reboot
> script.
>
> ################################
> #!/bin/sh
>
> sleep 5
> i=$RANDOM
> j=$(( $i % 2))
>
> mount /dev/mmcblk0p1 /mnt
> count=`cat /mnt/cnt`
>
> if [ $j -eq 0 ] ; then
>     echo "KEXEC rebootng to BE count = $count"
>     echo $RANDOM > /mnt/"$count""_BE"
>     kexec -l /mnt/vmlinux_BE.strip
> --command-line="console=ttyS0,115200 earlyprintk=uart8
> 250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=4M"
> else
>    echo "KEXEC rebooting to LE count = $count"
>    echo $RANDOM > /mnt/"$count""_LE"
>     kexec -l /mnt/vmlinux_LE.strip
> --command-line="console=ttyS0,115200 earlyprintk=uart8
> 250-32bit,0x1c020000 debug swiotlb=65536 log_buf_len=4M"
> fi
>
> count=$(( $count + 1 ))
> echo "$count">/mnt/cnt
> umount /mnt
> kexec -e
> exit $?
> ###############################
>
> Observations with the default code
> @https://git.linaro.org/people/geoff.levand/linux-kexec.git
> Changed last on "Mon, 4 Aug 2014 23:24:10 +0000 (16:24 -0700)"
>
> a) LE to LE worked without L3 cache on
> b) BE to BE worked without L3 cache on
> c) Random endian switching does not work in any case (with L3, No L3)
>     It breaks very early and unstable.
>
> Now with the below modifications
>

I think the more cleaner approach is to invalidate
the cache lines from arch/arm64/kernel/relocate_kernel.S
As this code is already aware of the destination it has
to copy the 2nd stage kernel.


########################
diff --git a/arch/arm64/kernel/relocate_kernel.S
b/arch/arm64/kernel/relocate_kernel.S
index 4b077e1..6880c1a 100644
--- a/arch/arm64/kernel/relocate_kernel.S
+++ b/arch/arm64/kernel/relocate_kernel.S
@@ -31,6 +31,13 @@

 .align 3

+.macro dcache_line_size, reg, tmp
+mrs    \tmp, ctr_el0                   // read CTR
+ubfm   \tmp, \tmp, #16, #19            // cache line size encoding
+mov    \reg, #4                        // bytes per word
+lsl    \reg, \reg, \tmp                // actual cache line size
+.endm
+
 .globl relocate_new_kernel
 relocate_new_kernel:

@@ -58,23 +65,46 @@ relocate_new_kernel:

        /* source: copy_page(x20 = dest, x21 = addr) */

+       mov     x0, x13
+       add     x1, x13, #PAGE_SIZE
+
+       /* Invalidate the destination cache area */
+__inval_cache_range:
+       dcache_line_size x2, x3
+       sub     x3, x2, #1
+       tst     x1, x3                          // end cache line aligned?
+       bic     x1, x1, x3
+       b.eq    1f
+       dc      civac, x1                       // clean & invalidate D / U line
+1:     tst     x0, x3                          // start cache line aligned?
+       bic     x0, x0, x3
+       b.eq    2f
+       dc      civac, x0                       // clean & invalidate D / U line
+       b       3f
+2:     dc      ivac, x0                        // invalidate D / U line
+3:     add     x0, x0, x2
+       cmp     x0, x1
+       b.lo    2b
+       dsb     sy
+
        mov x20, x13
        mov x21, x14

-       prfm    pldl1strm, [x21, #64]
-1:     ldp     x22, x23, [x21]
+       /*prfm  pldl1strm, [x21, #64] */
+.Lcopy_data:
+       ldp     x22, x23, [x21]
        ldp     x24, x25, [x21, #16]
        ldp     x26, x27, [x21, #32]
        ldp     x28, x29, [x21, #48]
        add     x21, x21, #64
-       prfm    pldl1strm, [x21, #64]
+       /*prfm  pldl1strm, [x21, #64]*/
        stnp    x22, x23, [x20]
        stnp    x24, x25, [x20, #16]
        stnp    x26, x27, [x20, #32]
        stnp    x28, x29, [x20, #48]
        add     x20, x20, #64
        tst     x21, #(PAGE_SIZE - 1)
-       b.ne    1b
+       b.ne    .Lcopy_data

        /* dest += PAGE_SIZE */

@@ -115,6 +145,8 @@ relocate_new_kernel:
        mov     x3, xzr

        ldr     x4, kexec_kimage_start
+       dsb     sy
+       isb
        br      x4

 .align 3
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index f1619c0..c62cba7 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -52,6 +52,13 @@
  */
 ENTRY(cpu_cache_off)
        mrs     x0, sctlr_el1
+       /* Turn off I-Cache */
+       bic     x0, x0, #1 << 12                // clear SCTLR.C
+       msr     sctlr_el1, x0
+       isb
+       dsb     sy
+
+       mrs     x0, sctlr_el1
        bic     x0, x0, #1 << 2                 // clear SCTLR.C
        msr     sctlr_el1, x0
        isb

#############################

--Arun
