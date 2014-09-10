From: will.deacon@arm.com (Will Deacon)
Date: Wed, 10 Sep 2014 12:17:28 +0100
Subject: Unable to boot mainline on snow chromebook since 3.15
In-Reply-To: <540DB7B4.4060300@collabora.co.uk>
References: <20140905122232.GP13515@arm.com>
 <CAD=FV=VfioJf9VYoSYL0QBk-bN93-Ecx3=0n9hb5Q4rcx43-_g@mail.gmail.com>
 <540C202E.2060009@collabora.co.uk> <540C7F5B.6070307@gmail.com>
 <540C83DE.10505@collabora.co.uk> <540C8577.2070907@gmail.com>
 <20140908112112.GK26030@arm.com>
 <CACxGe6v40wMSW8LJRtyZ3C6PinRMcQM-Zog+XpTJ-QG3HHJknw@mail.gmail.com>
 <20140908134937.GK4015@sirena.org.uk>
 <540DB7B4.4060300@collabora.co.uk>
Message-ID: <20140910111728.GG28488@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 08, 2014 at 03:05:40PM +0100, Javier Martinez Canillas wrote:
> Hello Will,

Hi Javier,

> Since many folks don't agree that hacking different subsystems is the way
> forward I'll hold the patches and don't post them. The sunxi thread [0]
> already shows how different people have strong opposite positions on the
> correct approach to handle this.
> 
> For now you can just disable the tps65090 PMIC support by not enabling the
> CONFIG_REGULATOR_TPS65090 kconfig symbol on your kernel config. That will give
> you exactly the same behavior that before tps65090 support was added to the
> Snow DT on commit b16be76 ("ARM: dts: add tps65090 power regulator for
> exynos5250-snow") which AFAIU was good enough for your workflow.

Disabling the regulator support gives me my framebuffer back, thanks. I
then get stuck mounting my root filesystem over sd card because it's
reported as read-only. The following hack solved the issue, but I'm not
exactly sure where this regression has come from (whether this is a board
quirk or pinctrl is really misconfigured).

Will

--->8

diff --git a/arch/arm/boot/dts/exynos5250-snow.dts b/arch/arm/boot/dts/exynos5250-snow.dts
index f2b8c41..932d82e 100644
--- a/arch/arm/boot/dts/exynos5250-snow.dts
+++ b/arch/arm/boot/dts/exynos5250-snow.dts
@@ -231,6 +231,7 @@
        };
 
        mmc at 12220000 {
+               disable-wp;
                status = "okay";
        };
 
