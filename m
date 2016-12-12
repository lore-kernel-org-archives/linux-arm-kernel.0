From: tony@atomide.com (Tony Lindgren)
Date: Mon, 12 Dec 2016 13:10:12 -0800
Subject: [PATCH v2] usb: dwc3: omap: fix race of pm runtime with irq
 handler in probe
In-Reply-To: <20161212193752.32029-1-grygorii.strashko@ti.com>
References: <20161212193752.32029-1-grygorii.strashko@ti.com>
Message-ID: <20161212211012.GQ4920@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Grygorii Strashko <grygorii.strashko@ti.com> [161212 11:38]:
> Now races can happen between interrupt handler execution and PM runtime in
> error handling code path in probe and in dwc3_omap_remove() which will lead
> to system crash:
> 
> in probe:
> ...
>  err1:
> 	pm_runtime_put_sync(dev);
> ^^ PM runtime can race with IRQ handler when deferred probing happening
>    due to extcon
> 	pm_runtime_disable(dev);
> 
> 	return ret;
> 
> in dwc3_omap_remove:
> ...
> 	dwc3_omap_disable_irqs(omap);
> ^^ IRQs are disabled in HW, but handler may still run
> 	of_platform_depopulate(omap->dev);
> 	pm_runtime_put_sync(&pdev->dev);
> ^^ PM runtime can race with IRQ handler
> 	pm_runtime_disable(&pdev->dev);
> 
> 	return 0;
> 
> So, OMAP DWC3 IRQ need to be disabled before calling
> pm_runtime_put() in probe and in dwc3_omap_remove().

Acked-by: Tony Lindgren <tony@atomide.com>
