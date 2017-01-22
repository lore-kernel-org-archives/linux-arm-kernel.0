From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sun, 22 Jan 2017 15:32:44 +0100
Subject: [PATCH 0/6] rtc: sun6i: Fix the RTC accuracy
In-Reply-To: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
References: <cover.180d5ae6bc36ead9625d208824f5cbd7114cf92e.1484927680.git-series.maxime.ripard@free-electrons.com>
Message-ID: <20170122143244.n2d4fpxnt62tkwtt@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/01/2017 at 16:56:37 +0100, Maxime Ripard wrote :
> Hi,
> 
> The RTC used in the A31 and later SoC has an accuracy issue, which is
> already significant even after a couple of hours.
> 
> This is due to the fact that the oscillator used by default is an internal
> and very inaccurate one.
> 
> A first attempt at fixing that by switching to the external oscillator was
> done in the patch "rtc: sun6i: Switch to the external oscillator". However,
> it turned out to be problematic since it was tracked properly in the clock
> framework, which might lead to some clocks being disabled, even though
> their devices were not notified.
> 
> This is a second attempt, this time by making it part of the CCF. It
> turned out to be a bit more complicated than one would expect since the mux
> found inside the RTC also controls one of the input of the main clock unit.
> Therefore, it needs to be probed before the main clock unit driver.
> 
> Let me know what you think,
> Maxime
> 
> Maxime Ripard (6):
>   rtc: sun6i: Expose the 32kHz oscillator
>   rtc: sun6i: Add some locking
>   rtc: sun6i: Disable the build as a module
>   rtc: sun6i: Force the mux to the external oscillator
>   ARM: sun8i: a23/a33: Enable the real LOSC and use it
>   ARM: sun8i: a23/a33: Add the oscillators accuracy
> 

As Chen-Yu mentioned, maybe you can reorder some patches so they can go
in stable.

>  Documentation/devicetree/bindings/rtc/sun6i-rtc.txt |   8 +-
>  arch/arm/boot/dts/sun8i-a23-a33.dtsi                |  15 +-
>  drivers/rtc/Kconfig                                 |   2 +-
>  drivers/rtc/rtc-sun6i.c                             | 189 +++++++++++--
>  4 files changed, 181 insertions(+), 33 deletions(-)
> 
> base-commit: 99cef370ac9939df2aeb16c96d07e842b2fa8201
> -- 
> git-series 0.8.11

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
