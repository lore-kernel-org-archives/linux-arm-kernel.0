From: vijay.kilari@gmail.com (Vijay Kilari)
Date: Wed, 22 Jan 2014 10:01:53 +0530
Subject: [PATCH v6 0/3] AArch64: KGDB support
In-Reply-To: <20140121183604.GQ30706@mudshark.cambridge.arm.com>
References: <1387453851-19341-1-git-send-email-vijay.kilari@gmail.com>
 <20140116134550.GA7496@arm.com>
 <CALicx6tQu2O8o4pr-N8Xc=D-Y9kOMsFNsn6BLVDqRo0Pbay00Q@mail.gmail.com>
 <20140120102302.GC16496@mudshark.cambridge.arm.com>
 <CALicx6v-pxOxdx4Q+a_Rx4XdHPXvgbVoYuouJoBxRdENMzCvAA@mail.gmail.com>
 <20140121183604.GQ30706@mudshark.cambridge.arm.com>
Message-ID: <CALicx6tx9aLmXpai5SFzZeR6cfu7NKF7WipZWY1nrKGBcA-oGA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 12:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Jan 21, 2014 at 02:10:14PM +0000, Vijay Kilari wrote:
>> Hi Will,
>
> Hello Vijay,
>
>> On Mon, Jan 20, 2014 at 3:53 PM, Will Deacon <will.deacon@arm.com> wrote:
>> > Well, the warnings are one thing but the 100 miles of backtrace output that
>> > appear on every boot (and I think end in an oops) are probably more
>> > important to fix. Please enable CONFIG_KGDB_TESTS and
>> > CONFIG_KGDB_TESTS_ON_BOOT and take a look.
>> >
>>
>> I could manage to run KGDB boot tests if I run from sysfs after complete boot
>>
>> echo V1F1000 > /sys/module/kgdbts/parameters/kgdbts
>>
>> Here the value of PSTATE is 80000145, which means PSTATE.D is unmasked
>> hence it works fine.
>>
>> If I run during boot by enabling CONFIG_KGDB_TESTS_ON_BOOT,
>> the step debug test fail because value of PSTATE is 80000345.
>> If I force PSTATE.D to 0, it works fine
>>
>> In debug_monitors.c file, only PSTATE.SS & MDSCR.KDE/MDE is managed
>> but not PSTATE.D
>>
>> Can you please let me know if where PSTATE.D is managed in arm64?
>
> That's a good point: I think we wait until our first exception before they
> are unmasked. Perhaps we should:
>
>  (1) Move local_dbg_{save,restore} from debug-monitors.h into irqflags.h
>  (2) Add local_dbg_enable/local_dbg_disable macros
>  (3) Add a call to local_dbg_enable in the clear_os_lock function after the
>      isb().
>
> Does that work for you?

Yes, only after first exception occurs the PSTATE.D is unmasked.

I have patched (temp) as below and now KGDB boot tests pass

diff --git a/arch/arm64/include/asm/debug-monitors.h
b/arch/arm64/include/asm/debug-monitors.h
index aff3a76..ea2bc46 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -64,6 +111,24 @@ struct task_struct;

 #define DBG_ARCH_ID_RESERVED   0       /* In case of ptrace ABI updates. */

+#define local_dbg_enable()
         \
+       do {
         \
+               asm volatile(
         \
+               "msr    daifclr, #9             //
arch_local_irq_disable"      \
+               :
         \
+               :
         \
+               : "memory");
         \
+       } while (0)
+
+#define local_dbg_disable()
         \
+       do {
         \
+               asm volatile(
         \
+               "msr    daifset, #9             //
arch_local_irq_disable"      \
+               :
         \
+               :
         \
+               : "memory");
         \
+       } while (0)
+
 struct step_hook {
        struct list_head node;
        int (*fn)(struct pt_regs *regs, unsigned int insn, unsigned long addr);

diff --git a/arch/arm64/kernel/debug-monitors.c
b/arch/arm64/kernel/debug-monitors.c
index f8b90c0..d0e55f7 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -139,6 +142,7 @@ static void clear_os_lock(void *unused)
 {
        asm volatile("msr oslar_el1, %0" : : "r" (0));
        isb();
+       local_dbg_enable();
 }


boot test:

[32927.161317] msgmni has been set to 1870
[32927.212747] alg: No test for stdrng (krng)
[32927.213953] Key type asymmetric registered
[32927.214899] Asymmetric key parser 'x509' registered
[32927.220029] Block layer SCSI generic (bsg) driver version 0.4
loaded (major 253)
[32927.225824] io scheduler noop registered
[32927.226764] io scheduler deadline registered
[32927.230714] io scheduler cfq registered (default)
[32927.237895] Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
[32927.266066] kgdb: Registered I/O driver kgdbts.
[32927.266419] kgdb: Waiting for connection from remote gdb...
[32927.268598] kgdbts:RUN plant and detach test
[32927.270683] kgdbts:RUN sw breakpoint test
[32927.287659] kgdbts:RUN bad memory access test
[32927.290322] kgdbts:RUN singlestep test 1000 iterations
[32927.330342] kgdbts:RUN singlestep [0/1000]
[32931.286356] kgdbts:RUN singlestep [100/1000]
[32935.242536] kgdbts:RUN singlestep [200/1000]
[32939.205392] kgdbts:RUN singlestep [300/1000]
[32943.169522] kgdbts:RUN singlestep [400/1000]
[32947.231868] kgdbts:RUN singlestep [500/1000]
[32951.188008] kgdbts:RUN singlestep [600/1000]
[32955.332243] kgdbts:RUN singlestep [700/1000]
[32959.467109] kgdbts:RUN singlestep [800/1000]
[32963.430888] kgdbts:RUN singlestep [900/1000]
[32967.346992] kgdbts:RUN do_fork for 100 breakpoints

kgdb test using sysfs:

~ # echo V1F1000 > /sys/module/kgdbts/parameters/kgdbts
[33231.554237] kgdb: Registered I/O driver kgdbts.
[33231.554677] kgdbts:RUN plant and detach test
[33231.557072] kgdbts:RUN sw breakpoint test
[33231.576980] kgdbts:RUN bad memory access test
[33231.580022] kgdbts:RUN singlestep test 1000 iterations
[33231.627056] kgdbts:RUN singlestep [0/1000]
[33235.954027] kgdbts:RUN singlestep [100/1000]
[33240.429086] kgdbts:RUN singlestep [200/1000]
[33244.687118] kgdbts:RUN singlestep [300/1000]
[33248.945191] kgdbts:RUN singlestep [400/1000]
[33253.203751] kgdbts:RUN singlestep [500/1000]
[33257.462019] kgdbts:RUN singlestep [600/1000]
[33261.817809] kgdbts:RUN singlestep [700/1000]
[33266.081268] kgdbts:RUN singlestep [800/1000]
[33270.339813] kgdbts:RUN singlestep [900/1000]
[33274.712404] kgdbts:RUN do_fork for 1000 breakpoints
~ #

This works for me. Should I patch it or will you send a patch for this?

PS: cc to mailing list missed
>
> Will
