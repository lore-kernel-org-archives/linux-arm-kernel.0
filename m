From: l.stach@pengutronix.de (Lucas Stach)
Date: Fri, 14 Aug 2015 10:37:30 +0200
Subject: [PATCH v3 08/10] Doc: usb: ci-hdrc-usb2: add
 tx(rx)-burst-config-dword for binding doc
In-Reply-To: <1438931747-25209-9-git-send-email-peter.chen@freescale.com>
References: <1438931747-25209-1-git-send-email-peter.chen@freescale.com>
 <1438931747-25209-9-git-send-email-peter.chen@freescale.com>
Message-ID: <1439541450.13210.31.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, den 07.08.2015, 15:15 +0800 schrieb Peter Chen:
> It is used to override the default setting for burst size, changing
> burst size takes effect only when the SBUSCFG.AHBBRST = 0.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>
> ---
>  Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> index d52a747..d71ef07 100644
> --- a/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> +++ b/Documentation/devicetree/bindings/usb/ci-hdrc-usb2.txt
> @@ -37,6 +37,14 @@ Optional properties:
>    property is used to change AHB burst configuration, check the chipidea
>    spec for meaning of each value. If this property is not existed, it
>    will use the reset value.
> +- tx-burst-size-dword: it is vendor dependent, the tx burst size in dword
> +  (4 bytes), This register represents the maximum length of a the burst
> +  in 32-bit words while moving data from system memory to the USB
> +  bus, changing this value takes effect only the SBUSCFG.AHBBRST is 0.

The last bits about SBUSCFG.AHBBRST don't make any sense in the DT
binding. The DT writer doesn't know about the SBUSCFG.AHBBRST value and
should not care either. If someone sets the burst size to something
non-standard in the DT, the driver should make sure to enable to
necessary bits to make this setting take effect.

Also both those descriptions are missing a description to what value the
burst sizes will be set if the DT properties are not found. If it's
implementation defined spell this out in the doc.

Are there really cases where it makes sense to set RX and TX burst sizes
to different values?

Regards,
Lucas

> +- rx-burst-size-dword: it is vendor dependent, the rx burst size in dword
> +  (4 bytes), This register represents the maximum length of a the burst
> +  in 32-bit words while moving data from the USB bus to system memory,
> +  changing this value takes effect only the SBUSCFG.AHBBRST is 0.
>  
>  Example:
>  
> @@ -51,4 +59,6 @@ Example:
>  		gadget-itc-setting = <0x4>; /* 4 micro-frames */
>  		 /* Incremental burst of unspecified length */
>  		ahb-burst-config = <0x0>;
> +		tx-burst-size-dword = <0x10>; /* 64 bytes */
> +		rx-burst-size-dword = <0x10>;
>  	};

-- 
Pengutronix e.K.             | Lucas Stach                 |
Industrial Linux Solutions   | http://www.pengutronix.de/  |
