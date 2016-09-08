From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 15:52:30 +0200
Subject: [PATCH 2/2] ARM: dts: add SMSC ethernet on the APQ8060 Dragonboard
In-Reply-To: <1473342103-30554-1-git-send-email-linus.walleij@linaro.org>
References: <1473342103-30554-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <7249221.7eA5nsROLb@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 3:41:43 PM CEST Linus Walleij wrote:
> The SMSC9112 ethernet controller is connected to chip select 2
> on the EBI2 bus on the APQ8060 Dragonboard. We set this up by
> activating EBI2, creating a chipselect entry as a subnode, and then
> putting the ethernet controller in a subnode of the chipselect.
> 
> After the chipselect is configured, the SMSC device will be
> instantiated.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---

One more thing I noticed recently is that we still have some
hardcoded configuration in the driver:

  #ifdef CONFIG_ARCH_PXA
    #define SMC_USE_PXA_DMA       1
    #define SMC_USE_16BIT         0
    #define SMC_USE_32BIT         1
    #define SMC_IRQ_SENSE         IRQF_TRIGGER_FALLING
  #elif defined(CONFIG_SH_MAGIC_PANEL_R2)
    #define SMC_USE_16BIT         0
    #define SMC_USE_32BIT         1
    #define SMC_IRQ_SENSE         IRQF_TRIGGER_LOW
  #elif defined(CONFIG_ARCH_OMAP3)
    #define SMC_USE_16BIT         0
    #define SMC_USE_32BIT         1
    #define SMC_IRQ_SENSE         IRQF_TRIGGER_LOW
    #define SMC_MEM_RESERVED      1
  #elif defined(CONFIG_ARCH_OMAP2)
    #define SMC_USE_16BIT         0
    #define SMC_USE_32BIT         1
    #define SMC_IRQ_SENSE         IRQF_TRIGGER_LOW
    #define SMC_MEM_RESERVED      1
  #else
  /*
   * Default configuration
   */
  
  #define SMC_DYNAMIC_BUS_CONFIG
  #endif

and I suspect we have to convert the OMAP2/OMAP3 portion here to use
dynamic configuration, otherwise things may go wrong in a multiplatform
kernel.

	Arnd
