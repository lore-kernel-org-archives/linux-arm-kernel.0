From: sebastian.hesselbarth@gmail.com (Sebastian Hesselbarth)
Date: Thu, 17 Apr 2014 08:54:20 +0200
Subject: [PATCH 3/4] ARM: dts: berlin: add the SDHCI nodes for the BG2Q
In-Reply-To: <20140417113306.545ca4a7@xhacker>
References: <1397652011-21284-1-git-send-email-antoine.tenart@free-electrons.com>
 <1397652011-21284-4-git-send-email-antoine.tenart@free-electrons.com>
 <20140417113306.545ca4a7@xhacker>
Message-ID: <534F7A9C.2080609@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/17/2014 05:33 AM, Jisheng Zhang wrote:
> On Wed, 16 Apr 2014 05:40:10 -0700
> Antoine T?nart <antoine.tenart@free-electrons.com> wrote:
>> Add the SDHCI nodes for the Marvell Berlin BG2Q, using the berlin-sdhci
>> driver.
[...]
>> +		sdhci0: sdhci at ab0000 {
>> +			compatible = "marvell,berlin2q-sdhci";
>> +			reg = <0xab0000 0x200>;
>> +			clocks = <&sdio1clk>;
>> +			interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			broken-cd;
>> +			status = "disabled";
>> +		};
>> +
>> +		sdhci1: sdhci at ab0800 {
>> +			compatible = "marvell,berlin2q-sdhci";
>> +			reg = <0xab0800 0x200>;
>> +			clocks = <&sdio1clk>;
>> +			interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			status = "disabled";
>> +		};
>> +
>> +		sdhci2: sdhci at ab1000 {
>> +			compatible = "marvell,berlin2q-sdhci";
>> +			reg = <0xab1000 0x200>;
>> +			interrupts = <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>;
>> +			clocks = <&sdio1clk>;
>> +			keep-power-in-suspend;
>> +			enable-sdio-wakeup;
>> +			broken-cd;
>> +			status = "disabled";
>> +		};
> 
> could we put sdhci at ab1000 at the first of sdhci lists? For two reasons:

Don't reorder the nodes, but use aliases.

> 1. sdhci at ab0000 and sdhci at ab0800 is called as sdhci1 and sdhci2 in mrvl
> internal discussion, so this would make the name consistent when we
> upgrade linux kernel to one mainline version.

How about we only move the node labels?

> 2. sdhci at ab1000 is always used for emmc. if sdhci at ab0800 is put at the
> head of sdhci at ab1000, and there's one sdcard in it, mmcblock0 would be
> the sdcard rather than emmc.

And label this one sdhci0?

> I dunno whether there's elegant solutions for these two issues. alias? Could
> anyone kindly help?

Have a look at drivers/mmc/host/dw_mmc.c:

ctrl_id = of_alias_get_id(host->dev->of_node, "mshc");

this also requires an aliases node in berlin2foo.dtsi:

aliases {
	mshc0 = &sdhci0;
	mshc1 = &sdhci1;
	mshc2 = &sdhci2;
};

Rather than using "mshc", I'd prefer something like "sdio" or "mmc".

Also, if that alias would be part of generic mmc OF code would be
good too, but we'll have to wait for Chris' call here.

Sebastian
