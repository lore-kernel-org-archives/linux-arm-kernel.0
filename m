From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 08 Jan 2014 17:00:53 +0100
Subject: [PATCH 1/2] ohci-platform: Add support for devicetree
 instantiation
In-Reply-To: <52CA603B.3070203@redhat.com>
References: <1388963080-12544-1-git-send-email-hdegoede@redhat.com>
 <201401060816.02998.arnd@arndb.de> <52CA603B.3070203@redhat.com>
Message-ID: <52CD7635.8040102@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/06/2014 08:50 AM, Hans de Goede wrote:

<snip>

>> Otherwise you don't know the difference between "no clock
>> provided", "error getting the clock reference" and "clock controller not
>> initialized yet, try again".
>
> I guess of these 3 we really only want to continue on "no clock provided",
> so I think something like this (for both clks and the phy) would be best:
>
>          priv->ahb_clk = devm_clk_get(&dev->dev, "ahb");
>          if (IS_ERR(priv->ahb_clk)) {
>              err = PTR_ERR(priv->ahb_clk);
>              if (err != -EINVAL && err != -ENODATA)
>                  goto err_put_hcd;
>              priv->ahb_clk = NULL; /* No clock provided */
>          }
>
> To clarify -EINVAL will be returned when there is no clock-names, and
> -ENODATA when the specified name is not found in clock-names.

Ok, so I've got this wrong, if there is no clk by that name specified
in dt -ENOENT will be returned. Actually -ENOENT is the only
error clk_get and thus devm_clk_get will ever return.

So it seems that clk_get currently is not properly passing along
probe-deferral. To make things future proof I will add a probe
deferral check to the next version of my patch.

Regards,

Hans
