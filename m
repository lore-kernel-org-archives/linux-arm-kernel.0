From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 11 Jun 2015 09:51:10 +0100
Subject: [PATCH 09/15] mfd: kill off set_irq_flags usage
In-Reply-To: <1433874401-27161-10-git-send-email-robh@kernel.org>
References: <1433874401-27161-1-git-send-email-robh@kernel.org>
 <1433874401-27161-10-git-send-email-robh@kernel.org>
Message-ID: <20150611085110.GF2982@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 09 Jun 2015, Rob Herring wrote:

> set_irq_flags is ARM specific with custom flags which have genirq
> equivalents. Convert drivers to use the genirq interfaces directly, so we
> can kill off set_irq_flags. The translation of flags is as follows:
> 
> IRQF_VALID -> !IRQ_NOREQUEST
> IRQF_PROBE -> !IRQ_NOPROBE
> IRQF_NOAUTOEN -> IRQ_NOAUTOEN
> 
> For IRQs managed by an irqdomain, the irqdomain core code handles clearing
> and setting IRQ_NOREQUEST already, so there is no need to do this in
> .map() functions and we can simply remove the set_irq_flags calls. Some
> users also set IRQ_NOPROBE and this has been maintained although it is not
> clear that is really needed. There appears to be a great deal of blind
> copy and paste of this code.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Milo Kim <milo.kim@ti.com>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Andy Gross <agross@codeaurora.org>
> Cc: David Brown <davidb@codeaurora.org>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: patches at opensource.wolfsonmicro.com
> Cc: linux-arm-msm at vger.kernel.org
> Cc: linux-soc at vger.kernel.org
> Cc: linux-omap at vger.kernel.org
> ---
>  drivers/mfd/88pm860x-core.c |  4 ----
>  drivers/mfd/ab8500-core.c   |  4 ----
>  drivers/mfd/arizona-irq.c   |  7 -------
>  drivers/mfd/asic3.c         |  4 ++--
>  drivers/mfd/db8500-prcmu.c  |  1 -
>  drivers/mfd/ezx-pcap.c      |  6 +-----
>  drivers/mfd/htc-egpio.c     |  4 ++--
>  drivers/mfd/htc-i2cpld.c    |  6 +-----
>  drivers/mfd/lp8788-irq.c    |  5 -----
>  drivers/mfd/max8925-core.c  |  5 +----
>  drivers/mfd/max8997-irq.c   |  5 +----
>  drivers/mfd/max8998-irq.c   |  5 +----
>  drivers/mfd/mt6397-core.c   |  4 ----
>  drivers/mfd/pm8921-core.c   |  5 +----
>  drivers/mfd/rc5t583-irq.c   |  4 +---
>  drivers/mfd/stmpe.c         |  7 -------
>  drivers/mfd/t7l66xb.c       |  6 ------
>  drivers/mfd/tc3589x.c       |  7 -------
>  drivers/mfd/tc6393xb.c      |  4 ++--
>  drivers/mfd/tps6586x.c      |  7 -------
>  drivers/mfd/tps65912-irq.c  |  8 +-------
>  drivers/mfd/twl4030-irq.c   | 11 +----------
>  drivers/mfd/twl6030-irq.c   | 13 -------------
>  drivers/mfd/ucb1x00-core.c  |  2 +-
>  drivers/mfd/wm831x-irq.c    |  7 -------
>  drivers/mfd/wm8350-irq.c    |  8 +-------
>  drivers/mfd/wm8994-irq.c    |  7 -------
>  27 files changed, 17 insertions(+), 139 deletions(-)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
