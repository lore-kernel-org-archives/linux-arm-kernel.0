From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 08 Sep 2016 14:14:50 +0200
Subject: [PATCH] usb: dwc3: host: inherit dma configuration from parent dev
In-Reply-To: <01a5728b-9ea7-3ccf-34e8-7602a654306b@ti.com>
References: <Pine.LNX.4.44L0.1604271357190.1912-100000@iolanthe.rowland.org>
 <87d1keirlu.fsf@linux.intel.com>
 <01a5728b-9ea7-3ccf-34e8-7602a654306b@ti.com>
Message-ID: <3028577.HpC29kEMTB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, September 8, 2016 3:02:56 PM CEST Grygorii Strashko wrote:
> dwc3: probe()
>         if (!&pdev->dev->of_node)
>                  legacy case - hard-code DMA props
>                 dwc->sysdev = &pdev->dev;

The PCI case will fall into this too, as we almost never have an
->of_node pointer for a PCI device.

Do we actually have any legacy dwc3 users in Linux that are neither DT
nor PCI based? Maybe we can just skip that.

>         else
>                 dev = &pdev->dev;
>                 do {
>                         if (is_device_dma_capable(dev)) {
>                                 dwc->sysdev = dev;
>                                 break;
>                         }
>                    dev = dev->parent;
>                 while (dev);
>                 ^this cycle can be limited in depth (2 for PCI)

Right, this could work by itself and looks generic enough.

	Arnd
