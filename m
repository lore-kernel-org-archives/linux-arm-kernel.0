From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 15 Jan 2014 16:01:46 +0000
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <3154671.7LPLgq8X4K@wuerfel>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <001c01cf11ed$039b6270$0ad22750$%jun@samsung.com>
 <52D6938A.9050806@linaro.org> <3154671.7LPLgq8X4K@wuerfel>
Message-ID: <20140115160146.GO15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 15, 2014 at 02:59:59PM +0100, Arnd Bergmann wrote:
> On Wednesday 15 January 2014 21:56:26 zhangfei wrote:
> > However, in our board cd =0 when card is deteced while cd=1 when card is
> > removed.
> > In order to mmc_gpio_get_cd return 1, MMC_CAP2_CD_ACTIVE_HIGH has to be
> > set, as well as new property "caps2-mmc-cd-active-low".
> > 
> > --- a/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > +++ b/Documentation/devicetree/bindings/mmc/synopsys-dw-mshc.txt
> > @@ -73,6 +73,8 @@ Optional properties:
> > +* caps2-mmc-cd-active-low: cd pin is low when card active
> > +
> > 
> > diff --git a/drivers/mmc/host/dw_mmc.c b/drivers/mmc/host/dw_mmc.c
> > +       if (of_find_property(np, "caps2-mmc-cd-active-low", NULL))
> > +               pdata->caps2 |= MMC_CAP2_CD_ACTIVE_HIGH;
> > +
> 
> The MMC_CAP2_CD_ACTIVE_HIGH flag should only be required for
> legacy platforms. With DT parsing, you can normally specify
> the polarity of the GPIO line in the GPIO specifier in DT.

Since when?

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
