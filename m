From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Thu, 01 Sep 2016 15:00:22 -0700
Subject: [PATCH v3 21/22] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <CAFp+6iGJo5P3_oFCboKmOno6QzcMhVHhTWVWPFw3fCop0PSa8g@mail.gmail.com>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-22-stephen.boyd@linaro.org>
 <CAFp+6iGJo5P3_oFCboKmOno6QzcMhVHhTWVWPFw3fCop0PSa8g@mail.gmail.com>
Message-ID: <147276722271.30255.17486402880702436547@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

(Please trim replies)

Quoting Vivek Gautam (2016-08-31 23:17:55)
> On Thu, Sep 1, 2016 at 6:10 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> > +
> > +       uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
> > +       if (IS_ERR(clk))
> > +               return PTR_ERR(clk);
> > +
> > +       uphy->phy = devm_phy_create(&ulpi->dev, ulpi->dev.of_node,
> > +                                   &qcom_usb_hsic_phy_ops);
> 
> There's a ulpi_phy library available in  drivers/phy/. Do we want to use that ?
> That also creates a phy-lookup of this PHY so that the ulpi device's parent
> can request the PHY.

I don't have any interest in using those two functions (does two
functions constitute a library?). There's no devm as you say, and it
seems to be specific to the ULPI hardware for dwc3 (the only user) where
the phy is called "usb2-phy". This is a phy for the ChipIdea controller
which only has one phy and it's called "usb-phy" in that case.

> 
> You may want to modify the APIs available in ulpi_phy library to use the
> devm_* APIs.
> 

The lookup isn't necessary because we use DT to find the lookup. I seem
to recall the phy framework requiring a DT lookup too.
