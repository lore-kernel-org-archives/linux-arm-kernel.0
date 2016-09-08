From: martin.blumenstingl@googlemail.com (Martin Blumenstingl)
Date: Thu, 8 Sep 2016 21:52:45 +0200
Subject: [PATCH 4/7] phy: meson: add USB2 PHY support for Meson8b and GXBB
In-Reply-To: <m260q6jibf.fsf@baylibre.com>
References: <20160904213152.25837-1-martin.blumenstingl@googlemail.com>
 <20160904213152.25837-5-martin.blumenstingl@googlemail.com>
 <m260q6jibf.fsf@baylibre.com>
Message-ID: <CAFBinCA4Yvw5pbOFmJ8SqyOASADavyEPmHywSdOiUazcqe_Zmg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 8, 2016 at 9:35 PM, Kevin Hilman <khilman@baylibre.com> wrote:
>> +     phy = devm_phy_create(&pdev->dev, NULL, &phy_meson_usb2_ops);
>> +     if (IS_ERR(phy)) {
>> +             dev_err(&pdev->dev, "failed to create PHY\n");
>> +             return PTR_ERR(phy);
>> +     }
>> +
>> +     if (usb_reset_refcnt++ == 0) {
>> +             ret = device_reset(&pdev->dev);
>> +             if (ret) {
>> +                     dev_err(&phy->dev, "Failed to reset USB PHY\n");
>> +                     return ret;
>> +             }
>> +     }
>
> The ref count + reset here looks like something that could/should be
> handled in a runtime PM callback.
Unfortunately that doesn't work (as Jerome found out) because both
PHYs are sharing the same reset line.
So if the second PHY would call device_reset then it would also reset
the first PHY!

There's a comment above the declaration of usb_reset_refcnt which
tries to explain this:
"The PHYs are sharing a common reset line -> we are only allowed to
reset once for all PHYs."
Maybe I should move this comment to the "if (usb_reset_refcnt++ == 0)
{" line to make it easier to see?


Regards,
Martin
