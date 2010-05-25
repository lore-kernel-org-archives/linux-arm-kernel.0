From: rumjantsev@papillon.ru (237 Rumjantsev Egor (PROG))
Date: Tue, 25 May 2010 19:26:54 +0600
Subject: vpack270 and sleep mode
In-Reply-To: <201005251439.50508.marek.vasut@gmail.com>
References: <1272311167-576-1-git-send-email-marek.vasut@gmail.com>
	<4BFBBECD.70803@papillon.ru>
	<201005251438.09494.marek.vasut@gmail.com>
	<201005251439.50508.marek.vasut@gmail.com>
Message-ID: <4BFBD01E.8010101@papillon.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

25.05.2010 18:39, Marek Vasut ?????:
> Dne ?t 25. kv?tna 2010 14:38:09 Marek Vasut napsal(a):
>> Dne ?t 25. kv?tna 2010 14:13:01 237 Rumjantsev Egor (PROG) napsal(a):
>>> Hello, Marek
>>
>> Hi,
>>
>>> Could you help to solve the following problem:
>>> I try to move my board based on Voipac PXA270 module to sleep state.
>>> I'm running kernel 2.6.28.10 on it.
>>
>> CCed Voipac and linux-arm-kernel. Btw. that's not Voipac official kernel,
>> is it?

Yes it isn't. I patched vanilla kernel to get basic Voipac module 
support and add some my code for our board.


>
> My bad, CCed wrong linux-arm-kernel, fixed now :)
>>
>>> When i try echo mem>  /sys/power/state i see messages that system goes
>>> to sleep state but after pushing wake-up button (GPIO0) i don't see that
>>> a bootloader is running (i set up some GPIOs as flags in bootloader and
>>> see on them whith oscilloscope).
>>
>> The bootloader checks RCSR once you wake it up and it sets-up SDRAM. If
>> there's a sleep-wakeup bit, it branches to location in PSPR and there's
>> linux kernel already.
>>
i know that as i have to use U-boot 1.3.0 for my board. It's also not 
Voipac's u-boot version.
I set or clear some of GPIO depending of reason we enter on bootloader.
And after pushing wake-up button my flags state doen't change.


>>> This is a part of kernel output when the system goes to sleep mode:
>>>
>>> dm9000 dm9000.0: LATE suspend
>>> platform pxa27x-pwm.1: LATE suspend
>>> platform pxa27x-pwm.0: LATE suspend
>>> platform pxa27x-ssp.2: LATE suspend
>>> platform pxa27x-ssp.1: LATE suspend
>>> platform pxa27x-ssp.0: LATE suspend
>>> pxa2xx-i2c pxa2xx-i2c.1: LATE suspend
>>> platform sa1100-rtc: LATE suspend
>>> platform pxa2xx-i2s: LATE suspend
>>> pxa2xx-uart pxa2xx-uart.2: LATE suspend
>>> pxa2xx-uart pxa2xx-uart.1: LATE suspend
>>> pxa2xx-uart pxa2xx-uart.0: LATE suspend
>>> platform pxa27x-udc: LATE suspend
>>> pxa_pm_enter(): RCSR value: 0x00000000
>>> pxa_pm_enter(): state: 3
>>> pxa_pm_enter(): Power regs:
>>> pxa_pm_enter(): GPDR0: 0x0070E200
>>> pxa_pm_enter(): PWER: 0x00000001
>>> pxa_pm_enter(): PFER: 0x00000000
>>> pxa_pm_enter(): PRER: 0x00000001
>>> pxa_pm_enter(): PGSR0: 0x00010000
>>> pxa_pm_enter(): PGSR1: 0x000F2000
>>> pxa_pm_enter(): PGSR2: 0x0404C000
>>> pxa_pm_enter(): PGSR3: 0x00000020
>>> pxa27x_cpu_pm_enter(): go to suspend : 3
>>> pxa27x_cpu_pm_enter(): PCFR : 0x61
>>> pxa27x_cpu_pm_enter(): PSSR : 0x0
>>> pxa27x_cpu_pm_enter(): PSLR : 0xCC100004
>>> pxa27x_cpu_pm_enter(): OSCC : 0x3
>>>
>>> but if i type command echo standby>  /sys/power/state
>>> the system reacts on wake-up button but hangs after some messages about
>>> null dereferencing pointers.
>>>
>>> is there any possibility to trace such problem?
>>
>> Try CONFIG_PM_ADVANCED_DEBUG.

i've looked through kernel sources and didn't such identifer


  Enable that and check if the tests work, one
>> by one. What are the messages you get once the kernel crashes?
>>

i've tryied to run tests.
echo devices > /sys/power/pm_test works fine
echo core > /sys/power/pm_test hangs with:

suspend debug: Waiting for 5 seconds.
platform pxa27x-udc: EARLY resume
pxa2xx-uart pxa2xx-uart.0: EARLY resume
pxa2xx-uart pxa2xx-uart.1: EARLY resume
pxa2xx-uart pxa2xx-uart.2: EARLY resume
platform pxa2xx-i2s: EARLY resume
platform sa1100-rtc: EARLY resume
platform pxa2xx-i2c.1: EARLY resume
platform pxa27x-ssp.0: EARLY resume
platform pxa27x-ssp.1: EARLY resume
platform pxa27x-ssp.2: EARLY resume
platform pxa27x-pwm.0: EARLY resume
platform pxa27x-pwm.1: EARLY resume
dm9000 dm9000.0: EARLY resume
vpac270-ssp vpac270-ssp.0: EARLY resume
platform vpac270-pm.0: EARLY resume
platform pxa_g64_driver.0: EARLY resume
platform pxa2xx_dir_keypad.0: EARLY resume
platform pxa_capture.0: EARLY resume
platform pxa2xx-ac97: EARLY resume
platform mfrc531-ssp.0: EARLY resume
pxa2xx-flash pxa2xx-flash.0: EARLY resume
Unable to handle kernel paging request at virtual address a03ab26f
pgd = c7b10000
[a03ab26f] *pgd=8020040e(bad)
Internal error: Oops: 803 [#1] PREEMPT
Modules linked in: ipv6 pxa_reg
Unable to handle kernel paging request at virtual address a03ab26f
pgd = c7b10000
[a03ab26f] *pgd=8020040e(bad)
Internal error: Oops: 803 [#1] PREEMPT
Modules linked in: ipv6 pxa_reg
CPU: 0    Not tainted  (2.6.28.10-vpac3-splash #90)
PC is at bad_channel+0x80166/0x91f28
LR is at platform_pm_resume_noirq+0x48/0x54
pc : [<a03ab23e>]    lr : [<a01cb758>]    psr: a00000b3
sp : c6b3be64  ip : c6b3be74  fp : c6b3be70
r10: 00000004  r9 : c79711b4  r8 : c7a1e000
r7 : 00000005  r6 : a03da1b0  r5 : a03f22e4  r4 : a03dd328
r3 : a03ab23b  r2 : 00000000  r1 : a03f22e4  r0 : a03dd320
Flags: NzCv  IRQs off  FIQs on  Mode SVC_32  ISA Thumb  Segment user
Control: 0000397f  Table: a7b10000  DAC: 00000015
Process sh (pid: 309, stack limit = 0xc6b3a268)
Stack: (0xc6b3be64 to 0xc6b3c000)
be60:          c6b3be88 c6b3be74 a01cd9b0 a01cb71c a03dd328 00000010 
c6b3bea8
be80: c6b3be8c a01ce248 a01cd968 00000010 00000000 00000003 a030d660 
c6b3bebc
bea0: c6b3beac a01ce8c8 a01ce1e4 00000000 c6b3bed8 c6b3bec0 a006fd10 
a01ce8b8
bec0: 0000db96 a038c7db 00000003 c6b3bef4 c6b3bedc a006ff20 a006fc10 
a038c7db
bee0: 00000003 00000003 c6b3bf1c c6b3bef8 a0070040 a006fdfc c780dc14 
00000004
bf00: c79711a0 c781ada0 a03eeea4 c6b3bf80 c6b3bf2c c6b3bf20 a018afe8 
a006ffb0
bf20: c6b3bf58 c6b3bf30 a00e1da8 a018afd0 c7ab1b20 4001d000 c6b3bf80 
00000004
bf40: a00300a4 c6b3a000 00000000 c6b3bf7c c6b3bf5c a0099b58 a00e1ca8 
c6b3bf80
bf60: 00000000 00000000 c7ab1b20 00000004 c6b3bfa4 c6b3bf80 a0099cb8 
a0099ab0
bf80: 00000000 00000000 00000000 00000004 4001d000 401565f8 00000000 
c6b3bfa8
bfa0: a002ff00 a0099c78 00000004 4001d000 00000001 4001d000 00000004 
00000000
bfc0: 00000004 4001d000 401565f8 00000004 00000001 9ef94b58 00000000 
9ef94a44
bfe0: 00000000 9ef9498c 4008df64 400e28b4 60000010 00000001 80936021 
80936421
Backtrace:
[<a01cb710>] (platform_pm_resume_noirq+0x0/0x54) from [<a01cd9b0>] 
(pm_noirq_op+0x54/0x88)
[<a01cd95c>] (pm_noirq_op+0x0/0x88) from [<a01ce248>] 
(dpm_power_up+0x70/0xec)
  r5:00000010 r4:a03dd328
[<a01ce1d8>] (dpm_power_up+0x0/0xec) from [<a01ce8c8>] 
(device_power_up+0x1c/0x20)
  r7:a030d660 r6:00000003 r5:00000000 r4:00000010
[<a01ce8ac>] (device_power_up+0x0/0x20) from [<a006fd10>] 
(suspend_devices_and_enter+0x10c/0x1b4)
  r4:00000000
[<a006fc04>] (suspend_devices_and_enter+0x0/0x1b4) from [<a006ff20>] 
(enter_state+0x130/0x1b4)
  r6:00000003 r5:a038c7db r4:0000db96
[<a006fdf0>] (enter_state+0x0/0x1b4) from [<a0070040>] 
(state_store+0x9c/0xc4)
  r6:00000003 r5:00000003 r4:a038c7db
[<a006ffa4>] (state_store+0x0/0xc4) from [<a018afe8>] 
(kobj_attr_store+0x24/0x28)
[<a018afc4>] (kobj_attr_store+0x0/0x28) from [<a00e1da8>] 
(sysfs_write_file+0x10c/0x144)
[<a00e1c9c>] (sysfs_write_file+0x0/0x144) from [<a0099b58>] 
(vfs_write+0xb4/0x140)
[<a0099aa4>] (vfs_write+0x0/0x140) from [<a0099cb8>] (sys_write+0x4c/0x80)
  r7:00000004 r6:c7ab1b20 r5:00000000 r4:00000000
[<a0099c6c>] (sys_write+0x0/0x80) from [<a002ff00>] 
(ret_fast_syscall+0x0/0x2c)
  r6:401565f8 r5:4001d000 r4:00000004
Code: 74732820 20657461 0a296425 69666300 (646d635f)
---[ end trace 213b55b29148afbf ]---
eth0: link down

>> There was also a way to keep the console enabled until the kernel didn't
>> totally suspend, but I can't find that option now, maybe someone will be
>> more successful. And maybe I'm mistaking this with an option to don't
>> blank consoles until then, it's been some time since I needed that.
>>
>>> P.S.: sorry if i disturb you, but you the only man in ARM linux mailing
>>> list who posted messages about Voipac modules.
>>
>> You're welcome.
>>
>>> Best regards !!!
>


-- 
Rumjantsev Egor
