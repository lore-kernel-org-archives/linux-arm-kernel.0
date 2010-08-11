From: tarun.kanti@ti.com (DebBarma, Tarun Kanti)
Date: Thu, 12 Aug 2010 00:22:54 +0530
Subject: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
	board data
In-Reply-To: <20100811184742.GA21778@nokia.com>
References: <1281550913-17633-1-git-send-email-ohad@wizery.com>
	<1281550913-17633-4-git-send-email-ohad@wizery.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB0324110ABD@dbde02.ent.ti.com>
	<20100811184742.GA21778@nokia.com>
Message-ID: <5A47E75E594F054BAF48C5E4FC4B92AB0324110AC1@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> -----Original Message-----
> From: Felipe Balbi [mailto:felipe.balbi at nokia.com]
> Sent: Thursday, August 12, 2010 12:18 AM
> To: DebBarma, Tarun Kanti
> Cc: Ohad Ben-Cohen; linux-wireless at vger.kernel.org; linux-
> mmc at vger.kernel.org; linux-omap at vger.kernel.org; Ido Yariv; Mark Brown;
> linux-arm-kernel at lists.infradead.org; Chikkature Rajashekar, Madhusudhan;
> Coelho Luciano (Nokia-MS/Helsinki); akpm at linux-foundation.org; San Mehat;
> Quadros Roger (Nokia-MS/Helsinki); Tony Lindgren; Nicolas Pitre; Pandita,
> Vikram; Kalle Valo
> Subject: Re: [PATCH v4 3/8] wireless: wl1271: add platform driver to get
> board data
> 
> hi,
> 
> On Wed, Aug 11, 2010 at 08:42:18PM +0200, ext DebBarma, Tarun Kanti wrote:
> >> @@ -182,10 +186,84 @@ static struct wl1271_if_operations sdio_ops = {
> >>  	.disable_irq	= wl1271_sdio_disable_interrupts
> >>  };
> >>
> >> +static int wl1271_plat_probe(struct platform_device *pdev)
> >> +{
> >> +	struct wl12xx_platform_data *pdata;
> >> +	struct platform_driver *pdriver;
> >> +	struct wl12xx_plat_instance *pinstance;
> >> +
> >What about checking for pdev here before extracting pdata?
> 
> why ? if probe is called pdev is guaranteed to be valid, no ?
> 
True; however if we go by that argument than we can also assume pdata is valid, so that we would not need the below check.
Still, I would go ahead and find out if there is any scenario where pdev can go wrong during device registration. Thanks.

> >> +	pdata = pdev->dev.platform_data;
> >> +	if (!pdata) {
> >> +		wl1271_error("no platform data");
> >> +		return -ENODEV;
> >> +	}
> >> +
> >> +	pdriver = container_of(pdev->dev.driver, struct platform_driver,
> >> +								driver);
> 
> but you shouldn't fiddle with the driver structure here. What are you
> actually trying to achieve here ? What's pinstance supposed to do ? are
> you trying to handle cases where you might have several wl12xx chips on
> the same board ? If that's the case you should have several platform
> devices, one for each chip. They'll only have different ids.
> 
> --
> balbi
> 
> DefectiveByDesign.org
