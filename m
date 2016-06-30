From: hzpeterchen@gmail.com (Peter Chen)
Date: Thu, 30 Jun 2016 16:54:36 +0800
Subject: [PATCH 16/21] usb: chipidea: msm: Restore wrapper settings after
 reset
In-Reply-To: <146722762509.16253.13062209537472705701@sboyd-linaro>
References: <20160626072838.28082-1-stephen.boyd@linaro.org>
 <20160626072838.28082-17-stephen.boyd@linaro.org>
 <20160629082648.GK25236@shlinux2>
 <146722762509.16253.13062209537472705701@sboyd-linaro>
Message-ID: <20160630085436.GA18426@shlinux2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 29, 2016 at 12:13:45PM -0700, Stephen Boyd wrote:
> Quoting Peter Chen (2016-06-29 01:26:48)
> > On Sun, Jun 26, 2016 at 12:28:33AM -0700, Stephen Boyd wrote:
> > > When the RESET bit is set in the USBCMD register it resets quite
> > > @@ -21,11 +23,22 @@
> > >  #define HS_PHY_SEC_CTRL                      0x0278
> > >  # define HS_PHY_DIG_CLAMP_N          BIT(16)
> > >  
> > > +#define HS_PHY_GENCONFIG             0x009c
> > > +# define HS_PHY_TXFIFO_IDLE_FORCE_DIS        BIT(4)
> > > +
> > > +#define HS_PHY_GENCONFIG_2           0x00a0
> > > +# define HS_PHY_SESS_VLD_CTRL_EN     BIT(7)
> > > +# define HS_PHY_ULPI_TX_PKT_EN_CLR_FIX       BIT(19)
> > > +
> > > +#define HSPHY_SESS_VLD_CTRL          BIT(25)
> > > +
> > 
> > Keep alignment please.
> 
> I take it this means it should look like:
> 
> #define HS_PHY_GENCONFIG
> #define HS_PHY_TXFIFO_IDLE_FORCE_DIS
> 
> ?
> 

Yes

> > > @@ -141,6 +172,13 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> > >       if (!base)
> > >               return -ENOMEM;
> > >  
> > > +     ci->vbus_edev = extcon_get_edev_by_phandle(&pdev->dev, 0);
> > > +     if (IS_ERR(ci->vbus_edev)) {
> > > +             if (PTR_ERR(ci->vbus_edev) != -ENODEV)
> > > +                     return PTR_ERR(ci->vbus_edev);
> > > +             ci->vbus_edev = NULL;
> > > +     }
> > > +
> > 
> > Why not using ci->platdata->vbus_extcon directly?
> 
> Because ci->platdata->vbus_extcon is assigned after the child platform
> driver probes, and we have no idea when that will happen from the
> ci_hdrc_msm driver probe. If we try after ci_hdrc_add_device() we'll
> race with the driver probe and only get the pointer sometimes.

ci->platdata->vbus_extcon->edev is assigned at ci_get_platdata which is
called before ci core device is created.

> 
> > 
> > >       reset_control_assert(reset);
> > >       usleep_range(10000, 12000);
> > >       reset_control_deassert(reset);
> > > @@ -157,6 +195,14 @@ static int ci_hdrc_msm_probe(struct platform_device *pdev)
> > >       if (ret)
> > >               goto err_mux;
> > >  
> > > +     ulpi_node = of_find_node_by_name(pdev->dev.of_node, "ulpi");
> > > +     if (ulpi_node) {
> > > +             phy_node = of_get_next_available_child(ulpi_node, NULL);
> > > +             ci->hsic = of_device_is_compatible(phy_node, "qcom,usb-hsic-phy");
> > > +             of_node_put(phy_node);
> > > +     }
> > > +     of_node_put(ulpi_node);
> > > +
> > 
> > Just confirm with you that ci->platdata->phy_mode is not enough?
> 
> Right. The phy_mode is never set to HSIC. It's always ULPI.

Ok

-- 

Best Regards,
Peter Chen
