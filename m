From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 2 Nov 2009 11:39:40 +0100
Subject: Using statically allocated memory for platform_data.
In-Reply-To: <20091102112316.16163f6a.ospite@studenti.unina.it>
References: <20091102112316.16163f6a.ospite@studenti.unina.it>
Message-ID: <20091102103940.GA25282@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, Nov 02, 2009 at 11:23:16AM +0100, Antonio Ospite wrote:
> Hi,
> 
> I noted that in some mfd drivers (drivers/mfd/ezx-pcap.c and
> drivers/mfd/da903x.c) there is code like this:
> 
> static int __devinit pcap_add_subdev(struct pcap_chip *pcap,
>                                      struct pcap_subdev *subdev)
> {
>         struct platform_device *pdev;
> 
>         pdev = platform_device_alloc(subdev->name, subdev->id);
>         pdev->dev.parent = &pcap->spi->dev;
>         pdev->dev.platform_data = subdev->platform_data;
> 
>         return platform_device_add(pdev);
> }
> 
> Note the _direct_assignment_ of platform data; then in board init code
> there are often global struct pointers passed as subdev platform data,
> see arch/arm/mach-pxa/em-x270.c::em_x270_da9030_subdevs for instance.
> 
> In these cases, whenever the subdev platform device is unregistered,
> the call to platform_device_release() tries to kfree the platform data,
> and being it statically allocated memory this triggers a bug from SLAB:
> 	kernel BUG at mm/slab.c:521!
> In my case this prevented proper device poweroff.
> 
> The question: should these mfd drivers use platform_device_add_data()
> which allocates dynamic memory for *a copy* of platform data? Is this
> simple solution acceptable even if there will be more memory used?
If you move the original data lives in .init there is no duplication.

Best regards
Uwe

-- 
Pengutronix e.K.                              | Uwe Kleine-K?nig            |
Industrial Linux Solutions                    | http://www.pengutronix.de/  |
