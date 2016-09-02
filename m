From: vivek.gautam@codeaurora.org (vivek.gautam at codeaurora.org)
Date: Fri, 02 Sep 2016 16:58:12 +0530
Subject: [PATCH v3 21/22] phy: Add support for Qualcomm's USB HSIC phy
In-Reply-To: <147276722271.30255.17486402880702436547@sboyd-linaro>
References: <20160901004036.23936-1-stephen.boyd@linaro.org>
 <20160901004036.23936-22-stephen.boyd@linaro.org>
 <CAFp+6iGJo5P3_oFCboKmOno6QzcMhVHhTWVWPFw3fCop0PSa8g@mail.gmail.com>
 <147276722271.30255.17486402880702436547@sboyd-linaro>
Message-ID: <0a3780a5073324772b873b8c474358c5@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-09-02 03:30, Stephen Boyd wrote:
> (Please trim replies)

sorry, will take care from next time.

> 
> Quoting Vivek Gautam (2016-08-31 23:17:55)
>> On Thu, Sep 1, 2016 at 6:10 AM, Stephen Boyd <stephen.boyd@linaro.org> 
>> wrote:
>> > +
>> > +       uphy->cal_sleep_clk = clk = devm_clk_get(&ulpi->dev, "cal_sleep");
>> > +       if (IS_ERR(clk))
>> > +               return PTR_ERR(clk);
>> > +
>> > +       uphy->phy = devm_phy_create(&ulpi->dev, ulpi->dev.of_node,
>> > +                                   &qcom_usb_hsic_phy_ops);
>> 
>> There's a ulpi_phy library available in  drivers/phy/. Do we want to 
>> use that ?
>> That also creates a phy-lookup of this PHY so that the ulpi device's 
>> parent
>> can request the PHY.
> 
> I don't have any interest in using those two functions (does two
> functions constitute a library?).

Not really.

> There's no devm as you say,

I meant to say that you may need to change the existing APIs to the 
devm_* APIs.

> and it seems to be specific to the ULPI hardware for dwc3 (the only 
> user) where
> the phy is called "usb2-phy".

This was used with TI's USB 2.0 PHY, that has ULPI interface.

> This is a phy for the ChipIdea controller
> which only has one phy and it's called "usb-phy" in that case.

In a way this is also a USB 2.0 phy, isn't it ?

> 
>> 
>> You may want to modify the APIs available in ulpi_phy library to use 
>> the
>> devm_* APIs.
>> 
> 
> The lookup isn't necessary because we use DT to find the lookup. I seem
> to recall the phy framework requiring a DT lookup too.

The lookup created in this ulpi_phy.h was used to help getting the PHY 
in the
driver for parent device (a core wrapper) of the controller (platform 
glue layer) that requests this PHY.
I am not certain at this point about how PHY has to be handled in case 
of Chipidea.
Was just throwing in ideas. :-)


Thanks
Vivek
