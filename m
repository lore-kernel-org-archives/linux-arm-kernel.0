From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Jan 2014 15:20:16 +0100
Subject: [PATCH] mmc: dw_mmc: fix dw_mci_get_cd
In-Reply-To: <3154671.7LPLgq8X4K@wuerfel>
References: <1389770159-21125-1-git-send-email-zhangfei.gao@linaro.org>
 <52D6938A.9050806@linaro.org> <3154671.7LPLgq8X4K@wuerfel>
Message-ID: <9483154.XYFILpUqYN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 15 January 2014 14:59:59 Arnd Bergmann wrote:
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

I missed the fact that we already have a "cd-inverted" property
as specified in bindings/mmc/mmc.txt. If your GPIO controller
does not handle polarity, you can use that.

	Arnd
