From: afaerber@suse.de (=?ISO-8859-15?Q?Andreas_F=E4rber?=)
Date: Thu, 29 May 2014 20:00:11 +0200
Subject: [PATCH v11 0/3] Exynos 5410 support
In-Reply-To: <53874862.5080809@samsung.com>
References: <1401074613-29227-1-git-send-email-t.dakhran@samsung.com>
 <7hr43f9mmn.fsf@paris.lan> <538737CA.4070709@suse.de>
 <53874862.5080809@samsung.com>
Message-ID: <538775AB.3000604@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tarek,

[shortening the CC list a bit]

Am 29.05.2014 16:46, schrieb Tarek Dakhran:
> On 05/29/2014 05:36 PM, Andreas F?rber wrote:
>> Am 27.05.2014 19:06, schrieb Kevin Hilman:
>>> Tarek Dakhran <t.dakhran@samsung.com> writes:
>>>
>>>> Has been tested on: 1) Exynos 5410 reference board (exynos_defconfig)
>>>>             2) Exynos 5410 reference board (multi_v7_defconfig)
>>>>             3) Odroid-XU board (exynos_defconfig)
>>>>             4) Odroid-XU board (multi_v7_defconfig)
>>> Tested-by: Kevin Hilman <khilman@linaro.org>
>>>
>>> FYI, I boot tested this on an odroid-xu (exynos_defconfig and
>>> multi_v7_defconfig.)
>> Could you clarify: Are you using exynos5410-smdk5410.dts with the
>> ODROID-XU or do you have some upcoming exynos5410-odroidxu.dts based on
>> exynos5410.dtsi?
> We use exynos5410-smdk5410.dts for booting ODROID-XU.

Thanks a lot for your work!

I've successfully booted for-next on ODROID-XU using that .dts and
exynos_defconfig plus some systemd and KVM options.

Once I got the following panic:

[    7.579120] Freeing unused kernel memory: 260K (c04f5000 - c0536000)
[    7.647496] Unhandled fault: asynchronous external abort (0x1211) at
0x00000000
[    7.659656] Kernel panic - not syncing: Attempted to kill init!
exitcode=0x00000007
[    7.659656]
[    7.667345] CPU: 0 PID: 1 Comm: init Not tainted
3.15.0-rc4-00074-gca610da #1
[    7.674465] [<c00218b4>] (unwind_backtrace) from [<c001eaa4>]
(show_stack+0x10/0x14)
[    7.682174] [<c001eaa4>] (show_stack) from [<c03a316c>]
(dump_stack+0x80/0xc0)
[    7.689371] [<c03a316c>] (dump_stack) from [<c03a0618>]
(panic+0xa4/0x200)
[    7.696222] [<c03a0618>] (panic) from [<c002c79c>]
(complete_and_exit+0x0/0x1c)
[    7.703503] [<c002c79c>] (complete_and_exit) from [<00000001>] (0x1)
[    7.709844] ---[ end Kernel panic - not syncing: Attempted to kill
init! exitcode=0x00000007
[    7.709844]

And I reproducibly get failures for CPUs 1-3, resulting in only one CPU
in /proc/cpuinfo (compared to 4 on downstream 3.14):

[    0.045778] CPU: Testing write buffer coherency: ok
[    0.045968] /cpus/cpu at 0 missing clock-frequency property
[    0.045993] /cpus/cpu at 1 missing clock-frequency property
[    0.046016] /cpus/cpu at 2 missing clock-frequency property
[    0.046040] /cpus/cpu at 3 missing clock-frequency property
[    0.046059] CPU0: thread -1, cpu 0, socket 0, mpidr 80000000
[    0.046135] Setting up static identity map for 0x403a8920 - 0x403a8978
[    2.075052] CPU1: failed to come online
[    4.085095] CPU2: failed to come online
[    6.095142] CPU3: failed to come online
[    6.095237] Brought up 1 CPUs
[    6.095269] SMP: Total of 1 processors activated.
[    6.095303] CPU: All CPU(s) started in HYP mode.
[    6.095336] CPU: Virtualization extensions available.

I also notice another apparent device tree issue:

[    7.341814] of_get_named_gpiod_flags: can't parse gpios property of
node '/soc/mmc at 12220000/slot at 0[0]'
[    7.341850] of_get_named_gpiod_flags: can't parse gpios property of
node '/soc/mmc at 12220000/slot at 0[0]'

Are any of those known issues and being worked on?
(The CPU failures affected 5420 Arndale Octa as well iirc.)

Some of the low-hanging fruit like no heartbeat/SD LEDs, no RTC, no
usb3503 and thus no network I'm already looking into myself. For now I'm
putting everything into the SMDK .dts, but I guess we'll need to split
off -odroidxu.dts and -pinctrl.dtsi at some point.

What about graphics? The 5410 is an oddball in using PowerVR rather than
Mali GPU - should a framebuffer on HDMI or DisplayPort work if we add DT
nodes, or will the GPU require larger code changes?

Cheers,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
