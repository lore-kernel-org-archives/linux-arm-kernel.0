From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 17 Apr 2014 09:00:51 +0100
Subject: [PATCH 10/11] mfd: twl-core: Fix idle mode signaling for omaps
 when booted with device tree
In-Reply-To: <1397173639-29587-11-git-send-email-tony@atomide.com>
References: <1397173639-29587-1-git-send-email-tony@atomide.com>
 <1397173639-29587-11-git-send-email-tony@atomide.com>
Message-ID: <20140417080051.GE28725@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> I noticed a regression where the omap sys_clkreq signal will never
> trigger for omap3 when booted with device tree while it triggers
> when booted in legacy mode. This means voltage scaling does not
> do anything when booted with device tree.
> 
> Turns out the reason is we fail to initialize the SmartReflex
> enable bit in twl4030 with the following error:
> 
> twl: not initialized
> 
> And that happens because we are wrongly tinkering with the twl4030
> registers in arch/arm/mach-omap2/omap_twl.c before the driver is
> initialized. Looking at the the SmartReflex bit enable code in
> omap_twl.c, we need to always set it.
> 
> So let's fix the issue by always enabling the twl4030 SmartReflex
> bit in the drivers/mfd/twl-core.c probe, and drop the related
> code in omap_twl.c.
> 
> Note that we still have some twl4030 tinkering left in omap_twl.c
> for the twl6030 case, but that's a different patch.
> 
> Cc: Kevin Hilman <khilman@linaro.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Nishanth Menon <nm@ti.com>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Paul Walmsley <paul@pwsan.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  arch/arm/mach-omap2/omap_twl.c | 60 ------------------------------------------
>  drivers/mfd/twl-core.c         | 15 +++++++++++
>  2 files changed, 15 insertions(+), 60 deletions(-)

Patch looks okay to me, and removes lots of code which is nice to
see. How do you want to handle this patch? How about if I set up an
MFD-OMAP immutable branch for us to use leading up to the v3.16 merge
window?

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
