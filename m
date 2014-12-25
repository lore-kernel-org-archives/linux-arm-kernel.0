From: aaro.koskinen@iki.fi (Aaro Koskinen)
Date: Fri, 26 Dec 2014 00:21:23 +0200
Subject: v3.19-rc1 regression(?) on N900
In-Reply-To: <20141225091121.GA20355@amd>
References: <549B44E2.6080202@ti.com> <201412250932.40403@pali>
 <20141225091121.GA20355@amd>
Message-ID: <20141225222122.GB582@fuloong-minipc.musicnaut.iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Dec 25, 2014 at 10:11:21AM +0100, Pavel Machek wrote:
> On Thu 2014-12-25 09:32:40, Pali Roh?r wrote:
> > On Wednesday 24 December 2014 23:57:38 Nishanth Menon wrote:
> > > based on automated testing with u-boot as a chained
> > > bootloader..
> > > 
> > > v3.19-rc1: hung
> > > https://github.com/nmenon/kernel-test-logs/blob/v3.19-rc1/omap
> > > 2plus_defconfig/n900.txt
> 
> Early hang, independend on config. That's "dtb too big". Delete
> something, and it should work again.

For me, DT boot works fine with 3.19-rc1 as is...

> Plus you'll note video regression.

...however, I can confirm that framebuffer is broken:

[    8.230743] omapfb omapfb: no displays
[    8.255584] omapfb omapfb: failed to setup omapfb
[    8.260620] platform omapfb: Driver omapfb requests probe deferral
[    8.284118] of_get_named_gpiod_flags: parsed 'reset-gpios' property of node
'/ocp/spi at 48098000/acx565akm at 2[0]' - status (0)
[    8.284271] acx565akm spi1.2: failed to find video source
[    8.290069] spi spi1.2: Driver acx565akm requests probe deferral

I bisected it to ef691ff48bc8 (OMAPDSS: DT: Get source endpoint
by matching reg-id). When I revert that, also FB works with 3.19-rc1.

A.
