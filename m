From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Sun, 07 Sep 2014 11:06:54 +0200
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
References: <20140905115704.GO13515@arm.com>	<20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
Message-ID: <540C202E.2060009@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[adding Mark Brown to cc since regulators are involved]

Hello Will,

On 09/05/2014 10:25 PM, Doug Anderson wrote:
> Will,
> 
> On Fri, Sep 5, 2014 at 5:22 AM, Will Deacon <will.deacon@arm.com> wrote:
>> [Looks like it's not just Rutland that can't spell the address of the
>>  mailing list today. Fixed here, so please use this post in any replies].
>>
>> On Fri, Sep 05, 2014 at 12:57:04PM +0100, Will Deacon wrote:
>>> Hi all,
>>>
>>> I'm one of the few, foolish people to try running mainline on my 5250-based
>>> Samsung Chromebook (snow). I can live without wireless, usb3 and video
>>> acceleration, so actually it makes a reasonable development platform for
>>> doing A15-based (micro)-architectural work.
>>>
>>> However, since 3.15 I've not been able to boot *any* mainline kernels on
>>> this board. I did mean to report this earlier, but I have other machines
>>> that can run mainline so this has fallen by the wayside.
>>>
>>> The problems started with 3.16, where simple-fb would fail to initialise
>>> and I lost my display. Note that I don't have a serial console on this
>>> machine (I looked at the PCB and there's no way I can solder one of those
>>> myself :) I bisected the issue at the time, and I could get my display back
>>> by removing some of the new regulator and hdmi properties from the DT. At
>>> that point, I could boot, but DMA didn't initialise for the MMC controller
>>> so I couldn't mount my root filesystem.
>>>
>>> With 3.17-rc3, it seems a lot worse -- I don't get any output after nv-uboot
>>> (i.e. the nv-uboot screen just remains on the display, with the last line
>>> reading "Stashed 20 records").
>>>
>>> I'd usually try to debug this a bit further, but without a console it's
>>> really painful to get anywhere. I've been working with 3.15, but now I'm
>>> having to backport patches when I want to test them, which is more effort
>>> than I can be bothered with.
>>>
>>> Is anybody else running mainline on this device and are these known/fixed
>>> problems?
> 
> I've added Javier, who says he'll try to take a look at the problem on
> Monday.  He's got a snow and I think he's got a serial console hooked
> up to it (but I don't think he's tried the simplefb workflow).
> 

I'm back from holidays with access to the machine again so I was able to look
at your issue.

> 
> He also added the following thoughts:
> 
>> Have you seen the very long "[PATCH 4/4] simplefb: add clock handling
>> code" thread [0]?. I wonder if the problem is that the display clocks were
>> not known to the kernel before 3.15 but now are getting disabled and thus
>> the simplefb driver not working?
>>
>> So probably is worth to try passing clk_ignore_unused as a parameter to
>> the kernel command line.
>>
>> [0]: https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06623.html
> 

So my assumptions was correct and the issue is that the kernel disables the
resources (clocks and regulators) needed to have display working and because
the simplefb expects the display hardware to have been already initialized by
the bootloader/firmware, it simply fails.

You didn't face this issue before 3.15 because the default bootargs set by
nv_uboot-snow already includes the "clk_ignore_unused" parameter and the
kernel didn't know about the regulators but the later changed with commit:

b16be76 ("ARM: dts: add tps65090 power regulator for exynos5250-snow")

This was included in 3.16, so the mentioned commit is what "broke" your
workflow since now the kernel is aware of the tps65090 fet1 and fet6
regulators (used as supply for the the backlight and panel respectively) and
disables them because nothing uses them from a kernel POV.

You will have the same issue even  with 3.15 if you don't pass the
"clk_ignore_unused" parameter to the kernel command line.

The sunxi folks faced the same issue and tried to solve it by making the
simplefb driver to claim the needed resources thus preventing the kernel to
disable them due not used. But that spawn the very long thread [0] mentioned
above and I've zero interest in joining that discussion...

So, following is a workaround patch [1] that just forces the needed regulators
to be always-on but I don't think this is the proper solution. The right thing
to do IMHO is to use the needed Exynos DRM/KMS patches as Ajay mentioned
before since AFAIU the simplefb is only to have a frame-buffer console working
on platforms where a KMS/DRM driver is not available yet.

But maybe we could add a boot argument similar to "clk_ignore_unused" but for
regulators? Something like "regulator_ignore_unused" that would prevent the
regulator core to disable unused regulators? If Mark agrees with that idea
I'll be glad to propose a patch.

Best regards,
Javier

[0]: https://www.mail-archive.com/linux-sunxi at googlegroups.com/msg06623.html
[1]:
>From bdbb3bc1d69c10dce58affe74e6b64636f7810b5 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
Date: Sun, 7 Sep 2014 10:58:29 +0200
Subject: [PATCH 1/1] ARM: dts: prevent exynos5250-snow display regulators to
 be disabled

The tps65090 fet1 and fet6 regulators are used in the Exynos5250
based Snow as power supplies for the PWM backlight and LCD panel
respectively. The bootloader enables those regulators in order to
have display working but the kernel still doesn't support the eDP
to LVDS bridge used in the Snow and the display device nodes are
not present in the Device Tree so these regulators are disabled.

The problem is that the simple frame-buffer driver can't be used
anymore since this driver assumes that the display hardware has
been initialized before the kernel boots and does not claim any
needed resources (regulators, clocks, etc) so the subsystems
disabled them if they are not used.

This used to work before just because support for the tps65090
PMU was not present in the DT so the kernel didn't know about it.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---
 arch/arm/boot/dts/exynos5250-snow.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts
b/arch/arm/boot/dts/exynos5250-snow.dts
index 2a62459..6a29b44 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -196,6 +196,7 @@
 					};
 					fet1 {
 						regulator-name = "vcd_led";
+						regulator-always-on;
 						ti,overcurrent-wait = <3>;
 					};
 					tps65090_fet2: fet2 {
@@ -219,6 +220,7 @@
 					};
 					fet6 {
 						regulator-name = "lcd_vdd";
+						regulator-always-on;
 						ti,overcurrent-wait = <3>;
 					};
 					tps65090_fet7: fet7 {
-- 
2.1.0
