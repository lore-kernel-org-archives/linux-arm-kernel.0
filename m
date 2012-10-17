From: t.figa@samsung.com (Tomasz Figa)
Date: Wed, 17 Oct 2012 15:42:46 -0000
Subject: [PATCH 6/6] ARM: EXYNOS5: SATA PHY controller driver
In-Reply-To: <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
References: <1349783332-18467-1-git-send-email-vasanthananthan@gmail.com>
 <10179968.slaZyPIETn@flatron>
 <CAK1UHiw8+ebzGyjV53Y9efpMFPbCL9RR_o9ZSw=NTuRw_9gRwg@mail.gmail.com>
Message-ID: <1536414.tLHsaDcjWh@amdc1227>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vasanth,

On Tuesday 16 of October 2012 12:03:47 Vasanth Ananthan wrote:
> Hi Tomasz,
> 
> On Sat, Oct 13, 2012 at 4:20 AM, Tomasz Figa <tomasz.figa@gmail.com> 
wrote:
> > Hi,
> > 
> > On Tuesday 09 of October 2012 17:18:52 Vasanth Ananthan wrote:
> >> This patch adds a platform driver and I2C client driver for SATA PHY
> >> controller
> >> 
> >> Signed-off-by: Vasanth Ananthan <vasanth.a@samsung.com>
> >> ---
> >> 
> >>  drivers/ata/Makefile          |    2 +-
> >>  drivers/ata/sata_exynos_phy.c |  303
> >> 
> >> +++++++++++++++++++++++++++++++++++++++++ 2 files changed, 304
> >> insertions(+), 1 deletions(-)
> >> 
> >>  create mode 100644 drivers/ata/sata_exynos_phy.c
> 
> [ ... ]
> 
> >> +
> >> +     phy->init = sataphy_init;
> >> +     phy->shutdown = sataphy_shutdown;
> >> +     phy->priv_data = (void *)sataphy;
> >> +     phy->dev = &pdev->dev;
> >> +
> >> +     ret = sata_add_phy(phy, SATA_PHY_GENERATION3);
> >> +     if (ret < 0)
> >> +             goto err4;
> > 
> > Do you have any warranties that phy callbacks won't get called before
> > i2c device probes and sets i2c_client?
> > 
> >> +
> >> +     ret = i2c_add_driver(&sataphy_i2c_driver);
> >> +     if (ret < 0)
> >> +             goto err5;
> >> +
> >> +     platform_set_drvdata(pdev, phy);
> 
> I shall register my i2c client driver before assigning the SATA PHY
> call backs. Would that guarantee the calling of phy callbacks after
> the i2c device probes?

No. You might still not have the sata phy i2c controller registered at 
that time and so the i2c driver will not be probed.

The only definitive solution for this would be to register both platform 
and i2c drivers in module init (instead of using module_platform_driver) 
and defer the probe of platform driver until i2c device gets registered. 

You can defer the probe by returning -EPROBE_DEFER after checking that 
i2c_client is still NULL.

Best regards,
-- 
Tomasz Figa
Samsung Poland R&D Center
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121017/ff347413/attachment-0001.html>
