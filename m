From: mwelling@ieee.org (Michael Welling)
Date: Mon, 11 May 2015 12:07:42 -0500
Subject: next-20150511 / omap2-mcspi: regression for sdp4430 boot
In-Reply-To: <5550DDCB.8010303@ti.com>
References: <5550DDCB.8010303@ti.com>
Message-ID: <20150511170742.GA6616@deathray>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 11:50:19AM -0500, Nishanth Menon wrote:
> Hi,
> 
> SDP4430 uses a SPI based network chip ks8851.
> 
> next-20150508:
> https://github.com/nmenon/kernel-test-logs/blob/next-20150508/omap2plus_defconfig/sdp4430.txt
> 
> However, next-20150511:
> https://github.com/nmenon/kernel-test-logs/blob/next-20150511/omap2plus_defconfig/sdp4430.txt
> 

I will look into this but it is going to be difficult to debug with access to the hardware.
This is what I get for changing a driver that effects so many SoCs.

> Generates infinite "ks8851 spi1.0: ks8851_irq: spi bus error" errors
> and hangs the platform.
> 
> Bisected the issue down to the following two commits when reverted
> allows the board to function:
> 
> 
> commit b28cb9414db9f8e42ac18c9e360e4e99cda42489
> Author: Michael Welling <mwelling@ieee.org>
> Date:   Thu May 7 18:36:53 2015 -0500
> 
>     spi: omap2-mcspi: Switch driver to use transfer_one
> 
>     Switches from transfer_one_message to transfer_one to prepare
> driver for
>     use of GPIO chip selects.
> 
>     Signed-off-by: Michael Welling <mwelling@ieee.org>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Reverting this alone: http://paste.ubuntu.org.cn/2594735 (did not boot up)
> 
> commit bc7f9bbc80bcc77745b3f54ec4e7103e3e142bb9
> Author: Michael Welling <mwelling@ieee.org>
> Date:   Fri May 8 13:31:01 2015 -0500
> 
>     spi: omap2-mcspi: Add gpio_request and init CS
> 
>     If GPIO chip select is specified, request the GPIO in the setup
> function
>     and release it in the cleanup function.
> 
>     Signed-off-by: Michael Welling <mwelling@ieee.org>
>     Signed-off-by: Mark Brown <broonie@kernel.org>
> 
> Reverting this as well allowed boot.
> 
> -- 
> Regards,
> Nishanth Menon
