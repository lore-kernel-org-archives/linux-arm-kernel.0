From: swboyd@chromium.org (Stephen Boyd)
Date: Wed, 21 Mar 2018 13:17:49 -0700
Subject: [PATCH v3 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <20180321165848.89751-4-swboyd@chromium.org>
References: <20180321165848.89751-1-swboyd@chromium.org>
 <20180321165848.89751-4-swboyd@chromium.org>
Message-ID: <152166346979.154352.7302935269984897659@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Stephen Boyd (2018-03-21 09:58:48)
> +       ret = device_property_read_u16_array(pctrl->dev, "gpios", NULL, 0);
> +       if (ret > 0 && ret < max_gpios) {
> +               u16 *tmp;
> +
> +               len = ret;
> +               tmp = kmalloc_array(len, sizeof(tmp[0]), GFP_KERNEL);
> +               if (!tmp)
> +                       return -ENOMEM;
> +
> +               ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
> +                                                    len);
> +               if (ret < 0) {
> +                       dev_err(pctrl->dev, "could not read list of GPIOs\n");
> +                       kfree(tmp);
> +                       return ret;
> +               }
> +
> +               bitmap_zero(chip->valid_mask, max_gpios);
> +               for (i = 0; i < len; i++)
> +                       set_bit(tmp[i], chip->valid_mask);

This leaks tmp too.. I'll fix that in v4 and resend tomorrow if there
aren't more comments.
