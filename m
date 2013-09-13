From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 13 Sep 2013 16:46:52 -0600
Subject: [PATCH] media: i2c: adv7343: fix the DT binding properties
In-Reply-To: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
References: <1379073471-7244-1-git-send-email-prabhakar.csengg@gmail.com>
Message-ID: <523395DC.5080009@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2013 05:57 AM, Prabhakar Lad wrote:
> From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
> 
> This patch fixes the DT binding properties of adv7343 decoder.
> The pdata which was being read from the DT property, is removed
> as this can done internally in the driver using cable detection
> register.
> 
> This patch also removes the pdata of ADV7343 which was passed from
> DA850 machine.

> diff --git a/Documentation/devicetree/bindings/media/i2c/adv7343.txt b/Documentation/devicetree/bindings/media/i2c/adv7343.txt

>  Required Properties :
>  - compatible: Must be "adi,adv7343"
> +- reg: I2C device address.
> +- vddio-supply: I/O voltage supply.
> +- vddcore-supply: core voltage supply.
> +- vaa-supply: Analog power supply.
> +- pvdd-supply: PLL power supply.

Old DTs won't contain those properties. This breaks the DT ABI if those
properties are required. Is that acceptable?

If it is, I think we should document that older versions of the binding
didn't require those properties, so they may in fact be missing.

I note that this patch doesn't actually update the driver to
regulator_get() anything. Shouldn't it?

>  Optional Properties :
> -- adi,power-mode-sleep-mode: on enable the current consumption is reduced to
> -			      micro ampere level. All DACs and the internal PLL
> -			      circuit are disabled.
> -- adi,power-mode-pll-ctrl: PLL and oversampling control. This control allows
> -			   internal PLL 1 circuit to be powered down and the
> -			   oversampling to be switched off.
> -- ad,adv7343-power-mode-dac: array configuring the power on/off DAC's 1..6,
> -			      0 = OFF and 1 = ON, Default value when this
> -			      property is not specified is <0 0 0 0 0 0>.
> -- ad,adv7343-sd-config-dac-out: array configure SD DAC Output's 1 and 2, 0 = OFF
> -				 and 1 = ON, Default value when this property is
> -				 not specified is <0 0>.

At a very quick glance, it's not really clear why those properties are
being removed. They seem like HW configuration, so might be fine to put
into DT. What replaces these?
