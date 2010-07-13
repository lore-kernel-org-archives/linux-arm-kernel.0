From: s.nawrocki@samsung.com (Sylwester Nawrocki)
Date: Tue, 13 Jul 2010 09:40:44 +0000 (UTC)
Subject: [PATCH] ARM: S5PV210: allow clk to use clksrc as parents
References: <1278395553-9228-1-git-send-email-myungjoo.ham@samsung.com>
	<027d01cb1f51$99a74780$ccf5d680$%kim@samsung.com>
	<AANLkTimvA_gSxZsrkEWZMLRFl82MsW5tV9g4trFmaMIr@mail.gmail.com>
	<038201cb2169$c92ccbf0$5b8663d0$%kim@samsung.com>
	<AANLkTilbDABhIIIWCtiHLsvQtss8A99XYWyCy0MkihD3@mail.gmail.com>
	<039a01cb2180$d36679b0$7a336d10$%kim@samsung.com>
	<AANLkTikf5-KdGju_IcYg8t5ZV3iIzOhr4VdSa104ZZHH@mail.gmail.com>
	<00e501cb2242$eee8a100$ccb9e300$%kim@samsung.com>
Message-ID: <i1hcas$1or$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Tue, 13 Jul 2010 13:21:54 +0900, Kukjin Kim wrote:

> MyungJoo Ham wrote:
>> 
>> 
>  (snip)
> 
[snip]
> 
> Basically, each clock which is used in each device driver such as lcd
> module clock, camemra module clock should be controlled in its device
> driver.
> 
> Let's say, in the case of camera module clock, FIMC IP has a specific
> divider which is used clock dividing for camera module clock. And the
> divider which is in FIMC IP has own rate for camera module at that time.
> So cannot/no need to define it in the common clock part such as clock.c.

IMO FIMC clock divider control registers are located in the clock 
controller IO memory, not in the FIMC IP. But possibly you meant 
something different than SCLK_CAM0/1 here.

So if we are considering SCLK_CAM0/1 the FIMC driver should be able to 
configure dividers corresponding to these clock outputs through the clk 
API. 
There is core clock multiplexer in FIMC IP in some SoCs though, so in 
general you are right, it would not be possible to control all clocks
with clk API as for now, since the dividers are located in specific IPs 
(e.g. SDHCI controller, FIMD).

Regards,
Sylwester

> 
> In other words, can't implement set_rate() or get_rate() for camera
> module clock in the common clock part, because FIMC IP block has own
> specific divider for it.
> 
> 
[snip]

> Thanks.
> 
> Best regards,
> Kgene.
