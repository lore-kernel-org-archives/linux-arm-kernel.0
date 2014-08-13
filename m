From: achandran@mvista.com (Arun Chandran)
Date: Wed, 13 Aug 2014 16:39:28 +0530
Subject: Kexec on arm64
In-Reply-To: <CAFdej01msBA8Ry=Ek3NpYPUBgvw_4G6w+68oRvGC6_AVRvudjQ@mail.gmail.com>
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
 <CAFdej02gA7mpkdarjZ+66C252K+grhCa4uXm8PTV4ioKXZKqjQ@mail.gmail.com>
 <CAFdej01msBA8Ry=Ek3NpYPUBgvw_4G6w+68oRvGC6_AVRvudjQ@mail.gmail.com>
Message-ID: <CAFdej03fgXQz1Pey4HtCBy5ePxMgJwkBGHWd7f8=jWBx1WvDgA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Geoff,

On Tue, Aug 12, 2014 at 11:12 AM, Arun Chandran <achandran@mvista.com> wrote:
> Hi Geoff, Mark,
>
>
> Sorry for top posting. I hope we have solved almost all the problems
> with kexec in uni-processor scenario except converting soft_restart()
> to assembly (I will give try to do this).
>

I have one more concern regarding flushing of D-cache area corresponding
to the kexec_list entrees.

Currently kexec_list_walk() is doing

1) flush_dcache_area of the kexec_list[0] till PAGE_SIZE

2) continue accessing entries in kexec_list[0] to PAGE_SIZE

3) switch to next kexec_list depending upon kexec_list[entry] & flag
==  IND_INDIRECTION

4) goto 1

Shouldn't that be doing flush_dcache_area() after completely using the list??

Like given below?
######################
diff --git a/arch/arm64/kernel/machine_kexec.c
b/arch/arm64/kernel/machine_kexec.c
index 5b15a00..ffb3b54 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -155,6 +155,7 @@ static void kexec_list_walk(void *ctx, unsigned
long kimage_head,
 {
        void *dest;
        unsigned long *entry;
+       void *last_accessed_dir = NULL;

        for (entry = &kimage_head, dest = NULL; ; entry++) {
                unsigned int flag = *entry & IND_FLAGS;
@@ -163,7 +164,10 @@ static void kexec_list_walk(void *ctx, unsigned
long kimage_head,
                switch (flag) {
                case IND_INDIRECTION:
                        entry = (unsigned long *)addr - 1;
-                       cb(ctx, flag, addr, NULL);
+                       if (last_accessed_dir != addr) {
+                               cb(ctx, flag, last_accessed_dir, NULL);
+                               last_accessed_dir = addr;
+                       }
                        break;
                case IND_DESTINATION:
                        dest = addr;
@@ -174,7 +178,7 @@ static void kexec_list_walk(void *ctx, unsigned
long kimage_head,
                        dest += PAGE_SIZE;
                        break;
                case IND_DONE:
-                       cb(ctx, flag , NULL, NULL);
+                       cb(ctx, flag , last_accessed_dir, NULL);
                        return;
                default:
                        pr_devel("%s:%d unknown flag %xh\n", __func__, __LINE__,
@@ -617,6 +621,9 @@ on_exit:
 static void kexec_list_flush_cb(void *ctx , unsigned int flag,
        void *addr, void *dest)
 {
+       if (addr == NULL)
+               return;
+
        switch (flag) {
        case IND_INDIRECTION:
                __flush_dcache_area(addr, PAGE_SIZE);
@@ -624,6 +631,9 @@ static void kexec_list_flush_cb(void *ctx ,
unsigned int flag,
        case IND_SOURCE:
                __flush_dcache_area(addr, PAGE_SIZE);
                break;
+       case IND_DONE:
+               __flush_dcache_area(addr, PAGE_SIZE);
+               break;
        default:
                break;
        }

########################

--Arun
