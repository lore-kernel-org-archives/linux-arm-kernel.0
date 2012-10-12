From: dietmar.eggemann@arm.com (Dietmar Eggemann)
Date: Fri, 12 Oct 2012 12:26:12 +0100
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN
 on ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
 <20120918100438.GC32204@mudshark.cambridge.arm.com>
 <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
Message-ID: <5077FE54.7030103@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/10/12 18:05, Valentin Pistol wrote:
> Will,
>
> On Tue, Sep 18, 2012 at 3:04 AM, Will Deacon <will.deacon@arm.com> wrote:
>>
>> On Fri, Sep 14, 2012 at 09:08:24AM +0100, Valentin Pistol wrote:
>>> Is there a reliable way to determine that they are locked down?
>>> Any particular register/bit I can check to confirm?
>>
>> You can take a look at the DBGAUTHSTATUS register and try to determine the
>> signal values for SPNIDEN, DBGEN and NIDEN.
>
> DBGAUTHSTATUS=0xaa confirming DBGEN is LOW. Since then I found out
> that there are two types of OMAP devices:
> GP (General Purpose) and HS (High Security) and supposedly Debug
> Capabilities are only available on GP devices.
> Thus, I ordered a Pandaboard ES with OMAP4460 and tested it with a
> prebuilt Ubuntu 12.04 image.
> After boot monitor mode is still not set, the DSCR reads the same
> 0x01030002 just as with the previous Galaxy Nexus.
>
> I contacted TI and they seem to say hw breakpoints/watchpoints are
> available on Pandaboard but they are confused about monitor mode,
> saying it's not available on Pandaboard GP.
> See http://e2e.ti.com/support/omap/f/849/p/216276/770995.aspx for the
> discussion.
> Isn't monitor mode and DBGEN on HIGH required for access to
> breakpoints/watchpoints?
> Maybe they are thinking about Secure Monitor Mode and TrustZone which
> is not related?
>
> Have you used a Pandaboard and can comment on how to enable the
> breakpoints/watchpoints?
> Could you also mention a specific development board that you are using
> and recommend for access to these features?

I'm running Linaro 12.08 on Pandaboard (Rev A1) and on this board 
DBGAUTHSTATUS.NSNE and DBGAUTHSTATUS.NSE are set.

With additional logs in enable_monitor_mode() 
[arch/arm/kernel/hw_breakpoint.c]:

root at linaro-nano:~# dmesg | grep hw-break
[    0.321380] hw-breakpoint: arch_hw_breakpoint_init cpu0 debug_arch=3
[    0.321441] hw-breakpoint: enable_monitor_mode cpu1 
DBGDSCR=03070002
[    0.321441] hw-breakpoint: enable_monitor_mode cpu1 
DBGAUTHSTATUS=000000af
[    0.321502] hw-breakpoint: enable_monitor_mode cpu0 
DBGDSCR=03070002
[    0.321533] hw-breakpoint: enable_monitor_mode cpu0 
DBGAUTHSTATUS=000000af
[    0.321533] hw-breakpoint: found 5 (+1 reserved) breakpoint and 1 
watchpoint registers.
[    0.321563] hw-breakpoint: maximum watchpoint size is 4 bytes.

-- Dietmar

>
>>
>>>> Completely untested patch below, please let me know how you get on...
>>>
>>> Looks good, I'll give it a try.
>>
>> Great. Let me know if it helps and, if so, I'll merge it.
>
> Sorry I wasn't able to directly apply your patch to the specific
> Android kernel version I was using.
> Manually merging the code seems to perform as expected.
>
> Thanks a lot for your help,
> Valentin
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
