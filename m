From: pistol@cs.duke.edu (Valentin Pistol)
Date: Tue, 16 Oct 2012 00:26:29 -0400
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmK+zLLR59FtuxdV82AhcoVV8tNTqGdL2bCh1Nn7YSpLHjg@mail.gmail.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
 <20120918100438.GC32204@mudshark.cambridge.arm.com>
 <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
 <20121009210802.GA31615@mudshark.cambridge.arm.com>
 <CAPfQmK+zLLR59FtuxdV82AhcoVV8tNTqGdL2bCh1Nn7YSpLHjg@mail.gmail.com>
Message-ID: <CAPfQmK+XnndKPsAeo3M1V75hhNnkMT9Bp1dtuyTuYvRz1pmi+g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> On Fri, Oct 12, 2012 at 7:26 AM, Dietmar Eggemann
> <dietmar.eggemann@arm.com> wrote:
>> I'm running Linaro 12.08 on Pandaboard (Rev A1) and on this board
>> DBGAUTHSTATUS.NSNE and DBGAUTHSTATUS.NSE are set.
>>
>> With additional logs in enable_monitor_mode()
>> [arch/arm/kernel/hw_breakpoint.c]:
>>
>> root at linaro-nano:~# dmesg | grep hw-break
>> [    0.321380] hw-breakpoint: arch_hw_breakpoint_init cpu0 debug_arch=3
>> [    0.321441] hw-breakpoint: enable_monitor_mode cpu1 DBGDSCR=03070002
>> [    0.321441] hw-breakpoint: enable_monitor_mode cpu1
>> DBGAUTHSTATUS=000000af
>> [    0.321502] hw-breakpoint: enable_monitor_mode cpu0 DBGDSCR=03070002
>> [    0.321533] hw-breakpoint: enable_monitor_mode cpu0
>> DBGAUTHSTATUS=000000af
>> [    0.321533] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1
>> watchpoint registers.
>> [    0.321563] hw-breakpoint: maximum watchpoint size is 4 bytes.
>
> Dietmar,
>
> That looks great! Did you flash the prebuilt images from Linaro 12.08
> and replaced the kernel with those extra debug messages on top of
> kernel at git://android.git.linaro.org/kernel/panda? Or are you using
> Will's branch?
> I am using a newer Pandaboard ES (Rev B1) and hope this is not the problem.
> Could you please provide a few instructions to reproduce your setup?
>

I just tried the kernel over at
git://android.git.linaro.org/kernel/panda and used the same branch in
the prebuilt Linaro 12.08:
linaro-tilt-android-tracking e78449e OMAPFB: Asynchronous vsync notification
I used android_omap4_defconfig but CONFIG_HW_HAVE_BREAKPOINT were not
persistent in the .config so I had to manually add HW_HAVE_BREAKPOINT
to arch/arm/Kconfig under ARCH_OMAP and also add PERF_EVENTS
dependency.
Similar to Dietmar I added additional info to
arch/arm/kernel/hw_breakpoint.c and now I can confirm I see the proper
value of DSCR = 0x3078002 and DBGAUTHSTATUS = 0xaf !
Flashing this 3.2 Kernel works without a problem but I am still
interested in getting Will's branch and 3.7 Kernel working.
I tried the above on Will's branch (copy over the
android_omap4_defconfig and edit Kconfig) but the kernel is still
stuck at trying to boot.

I am wondering if I can use all 4 watchpoints available in OMAP4460.
Normally the kernel just reports 1 watchpoint available due to what I
believe is a lack of information on what watchpoint triggered. Would
it be possible to enable all 4 and have a workaround to determine
which WP triggers?

Valentin
