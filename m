From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 01 Jun 2015 17:51:31 +0200
Subject: [PATCH] devicetree: Add support for I2C and related devices to
 TI-NSPIRE platform
In-Reply-To: <1433065442-92750-1-git-send-email-dt.tangr@gmail.com>
References: <1433065442-92750-1-git-send-email-dt.tangr@gmail.com>
Message-ID: <1838480.tt9zIv1PRB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 31 May 2015 19:44:02 Daniel Tang wrote:
> +
> +                               touchpad at 20 {
> +                                       compatible = "synaptics_i2c";
> +                                       reg = <0x20>;
> +                               };
>                         };

While this works, "synaptics_i2c" is not a well-formed DT compatible string,
we should do it right.

Please submit three patches:

a) one patch add "syna" as the vendor string in
   Documentation/devicetree/bindings/vendor-prefixes.txt
   As this is a publicly traded company, we use the stock ticker
   symbol by convention. Cc the patch to devicetree at vger.kernel.org
   for review, but I can merge it along with the dts patch if nobody
   else does

b) a patch to add an of_device_id match table to
   drivers/input/mouse/synaptics_i2c.c, with the proper name of the
   device. Ideally, this would be the full name of the component that
   is used here, something like "syna,abc12345-touchscreen". If you
   have no way of finding out the real name, "syna,i2c-touchscreen"
   will have to suffice.

c) This patch, with the correct string used for compatible.

	Arnd
