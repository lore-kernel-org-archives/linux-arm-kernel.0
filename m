From: achandran@mvista.com (Arun Chandran)
Date: Thu, 24 Jul 2014 17:20:04 +0530
Subject: Kexec on arm64
In-Reply-To: <1406162287.4062.39.camel@smoke>
References: <CAFdej006OSyhgDcJ2iZdbjt+PtysN=i_+9Dr4GTmr=+t5yg4Kw@mail.gmail.com>
 <1405443898.22585.7.camel@smoke>
 <CAL85gmC9LLcN_uxMY1bM5kLx=N7rZGdGO3bmGHeUVo=Rqgk8uw@mail.gmail.com>
 <1405551861.7262.26.camel@smoke>
 <CAFdej03nixSU=3h+HYk2E3Onb2P3--Di0GM+wCwLS6ZNH7UjEQ@mail.gmail.com>
 <CAFdej00J2mJwcg2Cy6CHVuuQZ4uQ2zZg8oErGPi0uPejievB+Q@mail.gmail.com>
 <1406162287.4062.39.camel@smoke>
Message-ID: <CAFdej02+1z64Cx6M4hayE0ZBtVhLm8NW30umFUJZ91E2CYOjeg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jul 24, 2014 at 6:08 AM, Geoff Levand <geoff@infradead.org> wrote:
> Hi Arun,
>
> On Tue, 2014-07-22 at 18:55 +0530, Arun Chandran wrote:
>
>> I tried the same dtb with UP configuration. For UP kernel to compile
>> did the below modifications
>
> I'll test and fixup the kexec UP build in the next few days.
>

Ok.

> ...
>
>> With the default target configuration "kexec -e" failed to execute
>> in UP scenario also.
>>
>> But I had some luck when I did the same steps with L3 cache
>> disabled. According to http://www.spinics.net/lists/arm-kernel/msg329541.html
>> it has an L3 cache. Luckily I was able to disable it in u-boot.
>>
>> With the L3 cache disabled configuration I am able to
>> do "kexec -e". Please see the log attached.
>
> All memory management for the main cpu is done by the arch code.  Kexec
> and cpu hot plug only work with the secondary cpus, so the problem would
> be in the arch memory code, either in setup_restart() for shutdown, or
> in the startup code.
>
> I guess setup_restart() is not doing something it needs to do for your
> platform.
>
I have done different experiments with L3 enabled in UP(uni processor) scenario.
Please note that in all the experiments first stage and second stage kernels
are same.

-- Experiment 1--
Kernel is modified to loop before jumping to the kexec "relocate_new_kernel"
code + other modification (disable Dcache turning off)
###############
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 3f7b0a2..e4ea22f 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -73,6 +73,8 @@ ENTRY(cpu_reset)
        bic     x1, x1, #1
        msr     sctlr_el1, x1                   // disable the MMU
        isb
+loop:
+       b       loop

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 31cba91..888fe3f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -70,10 +70,10 @@ static void setup_restart(void)
        flush_cache_all();

        /* Turn D-cache off */
-       cpu_cache_off();
+       //cpu_cache_off();

        /* Push out any further dirty data, and ensure cache is empty */
-       flush_cache_all();
+       //flush_cache_all();
 }
################

a) Load the second kernel "kexec -l"
b) Execute kexec -e; now it is looping @loop
c) Break into target using BDI3000
d) Flush L3 cache from BDI3000
c) Jump to relocate_new_kernel

CPU#0>rd
GPR00: 00000043eae0f000 0000000034d5d91c 0000004000000000 0000000000000004

CPU#0>go 0x00000043eae0f000

e) Kexeced kernel is booted without any issue.

--Experiment2--
Now revert only the Dcache disabling change
############
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 888fe3f..6bc85f78 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -70,10 +70,10 @@ static void setup_restart(void)
        flush_cache_all();

        /* Turn D-cache off */
-       //cpu_cache_off();
+       cpu_cache_off();

        /* Push out any further dirty data, and ensure cache is empty */
-       //flush_cache_all();
+       flush_cache_all();
 }
###############

Do the above steps a, b and c.

d)
>From BDI3000 I see strange value for x0
CPU#0>rd
GPR00: 000000000000003f 0000000034d5d918 0000004000000000 0000000000000004
e) Flush L3 cache from BDI3000
f) Jump to relocate_new_kernel (kexec -e prints this address)

machine_kexec:584: reboot_code_buffer_phys:  00000043f0381000

CPU#0>go 0x00000043f0381000

g) Kexeced kernel fails to boot

CPU#0>h
    Core number       : 0
    Core state        : debug (AArch64 EL1)
    Debug entry cause : External Debug Request
    Current PC        : 0xffffffc000083200
    Current CPSR      : 0x000003c5 (EL1h)

So If i don't turn off the dcache and flush L3 using
BDI3000 things are working.

--Experiment3--
Added L3 flush code to kernel +  other modification (disable Dcache turning off)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 0faa45a..5c546bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -233,6 +233,20 @@ section_table:

 ENTRY(stext)
        mov     x21, x0                         // x21=FDT
+flush_l3:
+       mov     x2, #0x10
+       mov     w1, #0x1f00
+       movk    x2, #0x7e60, lsl #16
+       movk    w1, #0x1600, lsl #16
+       str     w1, [x2]
+       mov     x4, #0
+wait_flush:
+       ldr     w1, [x2]
+       add     x4, x4 ,#1
+       tbz     w1, #31, wait_done
+       b       wait_flush
+wait_done:
+
        bl      el2_setup                       // Drop to EL1,
w20=cpu_boot_mode
        bl      __calc_phys_offset              // x24=PHYS_OFFSET,
x28=PHYS_OFFSET-PAGE_OFFSET
        bl      set_cpu_boot_mode_flag

diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
index 31cba91..888fe3f 100644
--- a/arch/arm64/kernel/process.c
+++ b/arch/arm64/kernel/process.c
@@ -70,10 +70,10 @@ static void setup_restart(void)
        flush_cache_all();

        /* Turn D-cache off */
-       cpu_cache_off();
+       //cpu_cache_off();

        /* Push out any further dirty data, and ensure cache is empty */
-       flush_cache_all();
+       //flush_cache_all();
 }

 /*
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c29dde1..3f7b0a2 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -73,7 +73,22 @@ ENTRY(cpu_reset)
        bic     x1, x1, #1
        msr     sctlr_el1, x1                   // disable the MMU
        isb
-       bl      secondary_shutdown
+
+flush_l3:
+       mov     x2, #0x10
+       mov     w1, #0x1f00
+       movk    x2, #0x7e60, lsl #16
+       movk    w1, #0x1600, lsl #16
+       str     w1, [x2]
+       mov     x4, #0
+wait_flush:
+       ldr     w1, [x2]
+       add     x4, x4 ,#1
+       tbz     w1, #31, wait_done
+       b       wait_flush
+wait_done:
+
+#      bl      secondary_shutdown
        ret     x0
 ENDPROC(cpu_reset)

Now also kexeced kernel boots fine.
If i do the same with "Dcache turning off enabled"
booting of kexeced kernel fails.

--Arun
