From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 17 Mar 2013 21:50:47 +0100
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
In-Reply-To: <8738vt3h11.fsf@natisbad.org>
References: <8738vt3h11.fsf@natisbad.org>
Message-ID: <20130317205047.GU21478@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnaud

> +
> +		thermal at 10078 {
> +			compatible = "marvell,kirkwood-thermal";
> +			reg = <0x10078 0x4>;
> +			status = "okay";
> +		};

This should not be needed. All 6282 have the thermal sensor, so the
kirkwood-6282.dtsi will contain this. For 3.9 we submitted the DT
change too late, so it did not make it in, but for 3.10 it should be
there.

> +void __init netgear_readynas_init(void)
> +{
> +	u32 val;
> +
> +	kirkwood_ge00_init(&netgear_readynas_ge00_data);
> +	kirkwood_pcie_init(KW_PCIE0);
> +
> +	/* USB 3.0 controller power on */
> +	mdelay(3000);
> +	val = readl(GPIO_HIGH_VIRT_BASE + 0x4);
> +	writel(val & ~(0x1 << 14), GPIO_HIGH_VIRT_BASE + 0x4);
> +	val = readl(GPIO_HIGH_VIRT_BASE);
> +	writel(val | (0x1 << 14), GPIO_HIGH_VIRT_BASE);

As Jason said, you can use a fixed regulator, in DT. Something like:

        regulators {
                compatible = "simple-bus";
                #address-cells = <1>;
                #size-cells = <0>;

                usb_power: regulator at 1 {
                        compatible = "regulator-fixed";
                        reg = <1>;
                        regulator-name = "USB Power";
                        regulator-min-microvolt = <5000000>;
                        regulator-max-microvolt = <5000000>;
                        enable-active-high;
                        regulator-always-on;
                        regulator-boot-on;
                        gpio = <&gpio0 14 0>;
                };
        };

Is the mdelay() really required?

   Andrew
