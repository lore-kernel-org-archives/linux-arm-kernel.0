From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Sep 2014 12:39:04 +0200
Subject: [PATCH v6 07/12] usb: chipidea: add a usb2 driver for ci13xxx
In-Reply-To: <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
References: <1411468088-5702-1-git-send-email-antoine.tenart@free-electrons.com>
 <1411468088-5702-8-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <2909480.SL9c0XWUbW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 September 2014 12:28:03 Antoine Tenart wrote:
> +       if (dev->of_node) {
> +               ret = ci_hdrc_usb2_dt_probe(dev, ci_pdata);
> +               if (ret)
> +                       goto clk_err;
> +       } else {
> +               ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> +               if (ret)
> +                       goto clk_err;
> +       }
> 

Why do you care about the non-DT case here? I think it would be nicer to
open-code the ci_hdrc_usb2_dt_probe() function in here and remove
the dma_set_mask_and_coherent(), which should not even be necessary for
the case where you have a hardwired platform device.

	Arnd
