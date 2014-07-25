From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Fri, 25 Jul 2014 10:42:47 +0200
Subject: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
In-Reply-To: <53D20E5B.9070501@monstr.eu>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
 <1406242820-20140-6-git-send-email-afaerber@suse.de>
 <ddb38ce5-9e31-4c94-967c-7784c7fba75c@BN1BFFO11FD028.protection.gbl>
 <53D20E5B.9070501@monstr.eu>
Message-ID: <53D21887.2020305@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Am 25.07.2014 09:59, schrieb Michal Simek:
> On 07/25/2014 01:18 AM, S?ren Brinkmann wrote:
>> On Fri, 2014-07-25 at 01:00AM +0200, Andreas F?rber wrote:
>>> Prepare SPI0 and SPI1 while at it.
> 
> Patch subject is incorrect. You are adding SPI and QSPI.

Yes, it originally added only QSPI, but I considered it a good deed to
add SPI as well while already reading that part of the TRM. :)

>>> 
>>> Signed-off-by: Andreas F?rber <afaerber@suse.de> --- v2: New
>>> 
>>> arch/arm/boot/dts/zynq-7000.dtsi      | 37
>>> +++++++++++++++++++++++++++++++++++ 
>>> arch/arm/boot/dts/zynq-parallella.dts |  4 ++++ 2 files
>>> changed, 41 insertions(+)
>>> 
>>> diff --git a/arch/arm/boot/dts/zynq-7000.dtsi
>>> b/arch/arm/boot/dts/zynq-7000.dtsi index 8fd826a..eed3df0
>>> 100644 --- a/arch/arm/boot/dts/zynq-7000.dtsi +++
>>> b/arch/arm/boot/dts/zynq-7000.dtsi @@ -122,6 +122,30 @@ 
>>> interrupts = <0 50 4>; };
>>> 
>>> +		spi0: spi at e0006000 { +			compatible = "xlnx,zynq-spi-r1p6"; 
>>> +			reg = <0xe0006000 0x1000>; +			status = "disabled"; +
>>> interrupt-parent = <&intc>; +			interrupts = <0 26 4>; +
>>> clocks = <&clkc 25>, <&clkc 34>; +			clock-names = "ref_clk",
>>> "pclk"; +			#address-cells = <1>; +			#size-cells = <0>; +		}; 
>>> + +		spi1: spi at e0007000 { +			compatible =
>>> "xlnx,zynq-spi-r1p6"; +			reg = <0xe0007000 0x1000>; +			status
>>> = "disabled"; +			interrupt-parent = <&intc>; +			interrupts =
>>> <0 49 4>; +			clocks = <&clkc 26>, <&clkc 35>; +			clock-names
>>> = "ref_clk", "pclk"; +			#address-cells = <1>; +			#size-cells
>>> = <0>; +		}; +
>> Until here things look good.
>> 
>>> gem0: ethernet at e000b000 { compatible = "cdns,gem"; reg =
>>> <0xe000b000 0x4000>; @@ -140,6 +164,19 @@ clock-names = "pclk",
>>> "hclk", "tx_clk"; };
>>> 
>>> +		qspi: qspi at e000d000 { +			compatible =
>>> "xlnx,zynq-spi-r1p6"; +			reg = <0xe000d000 0x1000>; +			status
>>> = "disabled"; +			interrupt-parent = <&intc>; +			interrupts =
>>> <0 19 4>; +			clocks = <&clkc 10>, <&clkc 43>; +			clock-names
>>> = "ref_clk", "pclk"; +			num-cs = <1>; +			#address-cells =
>>> <1>; +			#size-cells = <0>; +		}; +
>> I'm not sure what the status of this driver is. I think QSPI is
>> still under review on the mailing lists and I don't think we
>> should add this yet.
> 
> Driver for qspi is not in the mainline yet but it doesn't mean that
> this fragment won't work. Harini: Can you please correct me if I am
> wrong?

It did seem to find the flash chip (cf. parallella-next branch), but I
didn't find a driver capable of handling its ID. The downstream tree
was using m25p80; I tried both micron,n25q128a11 and ...a13 based on
U-Boot output.

> I would prefer to send two separate patches.

Will do.

> 1. just add SPI to zynq

As I don't have any of the other Zynq boards, can you please advise
whether either of them should be enabled for some board?

> 2. if Harini confirms that it is working I think that make sense to
> enable at least simple mode for qspi. That's why not a problem to
> add it too. It means qspi patch with enabling for your board as
> second patch.

Thanks,
Andreas

- -- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJT0hiHAAoJEPou0S0+fgE/DQwP/1zkv0tkOemDedPDa9dVu/77
0Qc9LTsbBsbn6STakd2z1+Iz2qoy4dePjsGd3hYVgHV6S6MnEiSDTqKjGXmX4Dqu
ALxksCLi0wezlQuEN2H110eivMGJ8DBz0qCq0t1acN5Y4YhF9tiCNQARF6XoAwcK
6FtGic/qVC92byGosbD4Y/SvZpJPuk+gACyIhUYEJTS/jKwB68jm5pZZbdGrVsB+
H4B9tGc+qs4bumdmbzxPXp66HyOqKsfRT0P/S6N0nvkqvNaWyM+MAmB4VDW3dnJJ
2ApbNJaPCoKtMHTQ2vnWstOVM4smsYJsszBF1zBIwUYgwW4q2Nv3vvjI23746m+x
gq7Tlqa5yIuPe/9+f6ek4dbZWQ7Zj+xw68taLvFkw9+4HvFd9qul/BxryFGTkErH
mZkEuQqTq1oppLGS+2ld+/VXt452UKF80Potra/Qt6D/LUA2UBcEIjoLpYxndjqz
3QrVNsw625LCyvJdYovO3FLHJ69U9VyZ4/8edDQzVvhD6/pcQp75W6mchWkxGnyS
jZVwKsIKVAWC9k6N6ZOLC5A8KOHRGGY5SOOpOLUQkfTviI5r2eAY5CvX8HOqx9s9
+tVphTMSLc5rC26ePdMwqAWbax4xt1kmWSiSUZ8cOnKvaUpWEPsAfQNMDsBfWiLN
aMQyrzdYs+nuCoIksVfN
=h5eC
-----END PGP SIGNATURE-----
