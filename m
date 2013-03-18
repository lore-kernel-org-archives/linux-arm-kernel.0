From: arno@natisbad.org (Arnaud Ebalard)
Date: Tue, 19 Mar 2013 00:10:46 +0100
Subject: [PATCH] ARM: kirkwood: Add support for NETGEAR ReadyNAS Duo v2
 using DT
References: <8738vt3h11.fsf@natisbad.org> <20130317205047.GU21478@lunn.ch>
Message-ID: <87mwu0pamh.fsf@natisbad.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi guys,

Andrew Lunn <andrew@lunn.ch> writes:

>> +void __init netgear_readynas_init(void)
>> +{
>> +	u32 val;
>> +
>> +	kirkwood_ge00_init(&netgear_readynas_ge00_data);
>> +	kirkwood_pcie_init(KW_PCIE0);
>> +
>> +	/* USB 3.0 controller power on */
>> +	mdelay(3000);
>> +	val = readl(GPIO_HIGH_VIRT_BASE + 0x4);
>> +	writel(val & ~(0x1 << 14), GPIO_HIGH_VIRT_BASE + 0x4);
>> +	val = readl(GPIO_HIGH_VIRT_BASE);
>> +	writel(val | (0x1 << 14), GPIO_HIGH_VIRT_BASE);
>
> As Jason said, you can use a fixed regulator, in DT. Something like:
>
>         regulators {
>                 compatible = "simple-bus";
>                 #address-cells = <1>;
>                 #size-cells = <0>;
>
>                 usb_power: regulator at 1 {
>                         compatible = "regulator-fixed";
>                         reg = <1>;
>                         regulator-name = "USB Power";
>                         regulator-min-microvolt = <5000000>;
>                         regulator-max-microvolt = <5000000>;
>                         enable-active-high;
>                         regulator-always-on;
>                         regulator-boot-on;
>                         gpio = <&gpio0 14 0>;
>                 };
>         };

I spent a lot of time on this, trying various things and reading various
elements of Docomentation/ but for some reason, it does not work, i.e. I
always end up w/ something lik: 

[    7.599773] USB Power: Failed to request enable GPIO14: -517
[    7.605963] reg-fixed-voltage 1.regulator: Failed to register regulator: -517
[    7.613163] platform 1.regulator: Driver reg-fixed-voltage requests probe deferral

I must confess I am not familiar enough with the inner working of
regulators and dt-exposed options to map the following correctly to
a dts entry.

	val = readl(GPIO_HIGH_VIRT_BASE + 0x4);
	writel(val & ~(0x1 << 14), GPIO_HIGH_VIRT_BASE + 0x4);
	val = readl(GPIO_HIGH_VIRT_BASE);
	writel(val | (0x1 << 14), GPIO_HIGH_VIRT_BASE);

If you have any ideas/directions, I would be happy to dig and test.

> Is the mdelay() really required?

It does not seem to be required, i.e. removing it still allows me to
plug a usb key and mount it.

Cheers,

a+
