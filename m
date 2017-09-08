From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Fri, 8 Sep 2017 23:44:13 +0900
Subject: [PATCH net-next 2/3] net: ethernet: socionext: add AVE ethernet
 driver
In-Reply-To: <1504875731-3680-3-git-send-email-hayashi.kunihiko@socionext.com>
References: <1504875731-3680-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1504875731-3680-3-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <CAK7LNASqfRbG08gvLxx4WxY2Vs2YYPkZ6NUpjj3_OOvOdEBKMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017-09-08 22:02 GMT+09:00 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>:

> diff --git a/drivers/net/ethernet/socionext/Kconfig b/drivers/net/ethernet/socionext/Kconfig
> new file mode 100644
> index 0000000..788f26f
> --- /dev/null
> +++ b/drivers/net/ethernet/socionext/Kconfig
> @@ -0,0 +1,22 @@
> +config NET_VENDOR_SOCIONEXT
> +       bool "Socionext ethernet drivers"
> +       default y
> +       ---help---
> +         Option to select ethernet drivers for Socionext platforms.
> +
> +         Note that the answer to this question doesn't directly affect the
> +         kernel: saying N will just cause the configurator to skip all
> +         the questions about Agere devices. If you say Y, you will be asked
> +         for your specific card in the following questions.


Agere?



> +
> +       dev_info(dev, "Socionext %c%c%c%c Ethernet IP %s (irq=%d, phy=%s)\n",
> +                (ave_id >> 24) & 0xff, (ave_id >> 16) & 0xff,
> +                (ave_id >> 8) & 0xff, (ave_id >> 0) & 0xff,
> +                buf, ndev->irq, phy_modes(phy_mode));
> +
> +       return 0;
> +err_netdev_register:

Maybe, a bad label name.
for ex. out_del_napi or whatever.

Documentation/process/coding-style.rst says
"Choose label names which say what the goto does ..."


> +       netif_napi_del(&priv->napi_rx);
> +       netif_napi_del(&priv->napi_tx);
> +       mdiobus_unregister(priv->mdio);
> +err_mdiobus_register:
> +err_mdiobus_alloc:
> +err_req_irq:

These three should be merged, for ex.
out_free_device.



I ran sparse for you.

Please take a look if it is worthwhile.
Seems endianess around mac_addr.


drivers/net/ethernet/socionext/sni_ave.c:423:15: warning: cast to
restricted __le32
drivers/net/ethernet/socionext/sni_ave.c:425:20: warning: cast to
restricted __le16
drivers/net/ethernet/socionext/sni_ave.c:1194:15: warning: cast to
restricted __le32
drivers/net/ethernet/socionext/sni_ave.c:1196:20: warning: cast to
restricted __le16
drivers/net/ethernet/socionext/sni_ave.c:1398:15: warning: cast to
restricted __le32
drivers/net/ethernet/socionext/sni_ave.c:1400:20: warning: cast to
restricted __le16





-- 
Best Regards
Masahiro Yamada
