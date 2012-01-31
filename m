From: hs@denx.de (Heiko Schocher)
Date: Tue, 31 Jan 2012 14:04:32 +0100
Subject: [RFC PATCH 7/7] ARM: davinci: add support for the am1808 based
 enbw_cmc board
In-Reply-To: <20120130203252.GX28397@ponder.secretlab.ca>
References: <1327308967-8092-1-git-send-email-hs@denx.de>
 <1327308967-8092-8-git-send-email-hs@denx.de>
 <20120130203252.GX28397@ponder.secretlab.ca>
Message-ID: <4F27E6E0.1050608@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Grant,

Grant Likely wrote:
> On Mon, Jan 23, 2012 at 09:56:07AM +0100, Heiko Schocher wrote:
>> - AM1808 based board
>> - 64 MiB DDR ram
>> - 2 MiB Nor flash
>> - 128 MiB NAND flash
>> - use internal RTC
>> - I2C support
>> - hwmon lm75 support
>> - UBI/UBIFS support
>> - MMC support
>> - USB OTG support
>>
>> Signed-off-by: Heiko Schocher <hs@denx.de>
>> Cc: linux-arm-kernel at lists.infradead.org
>> Cc: devicetree-discuss at lists.ozlabs.org
>> Cc: davinci-linux-open-source at linux.davincidsp.com
>> Cc: linux-mtd at lists.infradead.org
>> Cc: linux-i2c at vger.kernel.org
>> Cc: netdev at vger.kernel.org
>> Cc: David Woodhouse <dwmw2@infradead.org>
>> Cc: Ben Dooks <ben-linux@fluff.org>
>> Cc: Wolfram Sang <w.sang@pengutronix.de>
>> Cc: Sekhar Nori <nsekhar@ti.com>
>> Cc: Kevin Hilman <khilman@ti.com>
>> Cc: Wolfgang Denk <wd@denx.de>
>>
>> ---
>> - post this board support with USB support, even though
>>   USB is only working with the 10 ms "workaround", posted here:
>>   http://comments.gmane.org/gmane.linux.usb.general/54505
>>   I see this issue also on the AM1808 TMDXEXP1808L evalboard.
>> - MMC and USB are not using OF support yet, ideas how to port
>>   this are welcome. I need for USB and MMC boards board
>>   specific callbacks, how to solve this with OF support?

Can you give me a hint, how to add callbacks to OF support?

>>  arch/arm/boot/dts/enbw_cmc.dts                  |  286 +++++++++++++++++
>>  arch/arm/configs/enbw_cmc_defconfig             |  125 ++++++++
>>  arch/arm/mach-davinci/Kconfig                   |    8 +
>>  arch/arm/mach-davinci/Makefile                  |    1 +
>>  arch/arm/mach-davinci/board-enbw-cmc.c          |  384 +++++++++++++++++++++++
>>  arch/arm/mach-davinci/include/mach/uncompress.h |    1 +
>>  6 files changed, 805 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/enbw_cmc.dts
>>  create mode 100644 arch/arm/configs/enbw_cmc_defconfig
>>  create mode 100644 arch/arm/mach-davinci/board-enbw-cmc.c
>>
>> diff --git a/arch/arm/boot/dts/enbw_cmc.dts b/arch/arm/boot/dts/enbw_cmc.dts
>> new file mode 100644
>> index 0000000..e5995ce
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/enbw_cmc.dts
>> @@ -0,0 +1,286 @@
>> +/*
>> + * Device Tree for the EnBW CMC plattform
>> + *
>> + * Copyright 2011 DENX Software Engineering GmbH
>> + * Heiko Schocher <hs@denx.de>
>> + *
>> + * This program is free software; you can redistribute  it and/or modify it
>> + * under  the terms of  the GNU General  Public License as published by the
>> + * Free Software Foundation;  either version 2 of the  License, or (at your
>> + * option) any later version.
>> + */
>> +/dts-v1/;
>> +/include/ "skeleton.dtsi"
>> +
>> +/ {
>> +	model = "EnBW CMC";
>> +	compatible = "enbw,cmc";
>> +
>> +	aliases {
>> +		ethernet0 = &eth0;
>> +	};
>> +
>> +	arm {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0 0xfffee000 0x00020000>;
>> +		intc: interrupt-controller at 1 {
>> +			compatible = "ti,davinci-intc";
>> +			interrupt-controller;
>> +			#interrupt-cells = <1>;
>> +			ti,intc-size = <101>;
>> +			reg = <0x0 0x2000>;
>> +		};
>> +	};
>> +	soc at 1c00000 {
>> +		compatible = "ti,da8xx";
> 
> As previously mentioned, using wildcard ('x') characters in compatible
> properties is bad practice.  Always be specific and use the compatible
> list to make sure the correct driver gets bound (assuming the device
> is 100% register level compatible with the older one).

fixed.

>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		ranges = <0x0 0x01c00000 0x400000>;
>> +
>> +		serial0: serial at 1c42000 {
>> +			cell-index = <2>;
> 
> As previously mentioned, don't use cell index.  If you *really* need
> to assign a number to a device, then use a property in the /aliases
> node and make sure pdev->id does *not* get modified.

removed, as not needed.

>> +			compatible = "ns16550a";
> 
> Should include a string for the specific device.  Something like:
> 
> 	compatible = "ti,da800", "ns16550a";

added.

>> diff --git a/arch/arm/mach-davinci/board-enbw-cmc.c b/arch/arm/mach-davinci/board-enbw-cmc.c
>> new file mode 100644
>> index 0000000..4473c4a
>> --- /dev/null
>> +++ b/arch/arm/mach-davinci/board-enbw-cmc.c
>> @@ -0,0 +1,384 @@
[...]
>> +#if defined(CONFIG_OF)
>> +static __init void enbw_cmc_usb_init(void)
> 
> All the focus is on DT now.  How about making CONFIG_OF required for
> this board?  Also, this is just another board file.  The focus should

fixed.

> be on creating a generic board support file for DT platforms.

move the arch/arm/mach-davinci/board-enbw-cmc.c to
arch/arm/mach-davinci/board-da850_simple.c

and do it like

arch/powerpc/platforms/52xx/mpc5200_simple.c ?

and extract common nodes from arch/arm/boot/dts/enbw_cmc.dts
to arch/arm/boot/dts/da850.dtsi?

bye,
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
