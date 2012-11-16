From: s.peter@mpl.ch (Stefan Peter)
Date: Fri, 16 Nov 2012 20:30:53 +0100
Subject: [PATCH 1/1] ARM: kirkwood: Add support for the MPL CEC4
In-Reply-To: <20121116151128.GO22106@titan.lakedaemon.net>
References: <cover.1353055273.git.s.peter@mpl.ch>
 <7f8832a749a9ebc378460f26d13ed524b7da18a8.1353055273.git.s.peter@mpl.ch>
 <20121116151128.GO22106@titan.lakedaemon.net>
Message-ID: <50A6946D.3030006@mpl.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jason

On 16.11.2012 16:11, Jason Cooper wrote:
> Stefan,
> 
> Thanks for the patch!  I didn't know kirkwood made it into industrial
> controllers.  Comments below.

It evolved out of an industrial firewall design that unfortunately is a
little bit trickier to get into mainline linux, but I will try as soon
as the CEC4 is there.

> 
> On Fri, Nov 16, 2012 at 11:10:22AM +0100, Stefan Peter wrote:
>>
>> Signed-off-by: Stefan Peter <s.peter@mpl.ch>
>>
>> diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
>> index f37cf9f..bc1c8f2 100644
>> --- a/arch/arm/boot/dts/Makefile
>> +++ b/arch/arm/boot/dts/Makefile
>> @@ -40,7 +40,8 @@ dtb-$(CONFIG_ARCH_KIRKWOOD) += kirkwood-dns320.dtb \
>>  	kirkwood-lschlv2.dtb \
>>  	kirkwood-lsxhl.dtb \
>>  	kirkwood-ts219-6281.dtb \
>> -	kirkwood-ts219-6282.dtb
>> +	kirkwood-ts219-6282.dtb \
>> +	kirkwood-mplcec4.dtb
> 
> Please insert in alphabetical order.  This reduces merge conflicts for
> us.

Will do.

> 
>>  dtb-$(CONFIG_ARCH_MSM) += msm8660-surf.dtb \
>>  	msm8960-cdp.dtb
>>  dtb-$(CONFIG_ARCH_MVEBU) += armada-370-db.dtb \
>> diff --git a/arch/arm/boot/dts/kirkwood-mplcec4.dts b/arch/arm/boot/dts/kirkwood-mplcec4.dts
>> new file mode 100644
>> index 0000000..d221487
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/kirkwood-mplcec4.dts
>> @@ -0,0 +1,119 @@
>> +/dts-v1/;
>> +
>> +/include/ "kirkwood.dtsi"
>> +
>> +/ {
>> +	model = "MPL CEC4";
>> +	compatible = "mpl,mplcec4", "marvell,kirkwood-88f6281", "marvell,kirkwood";
> 
> Perhaps "mpl,cec4-10", "mpl,cec4", "marvell..." would be more
> appropriate here, according to the slick sheet.
> 

OK, no problem.


>> +
>> +                        partition at 600000 {
>> +                                label = "rootfs";
>> +                                reg = <0x600000 0x1fa00000>;
>> +                        };
>> +                };
>> +
>> +		rtc at 10300 {
>> +			status = "disabled";
>> +		};
> 
> really?
> 

Really. We use the nxp,pcff856 i2c RTC because the battery holders
available for the kirwood rtc are to flimsy for an industrial design.


>> index d94872f..e2e650e 100644
>> --- a/arch/arm/mach-kirkwood/board-dt.c
>> +++ b/arch/arm/mach-kirkwood/board-dt.c
>> @@ -94,6 +94,9 @@ static void __init kirkwood_dt_init(void)
>>  	if (of_machine_is_compatible("keymile,km_kirkwood"))
>>  		km_kirkwood_init();
>>  
>> +	if (of_machine_is_compatible("mpl,mplcec4"))
> 
> With the above comment, this would be "mpl,cec4"

Yes, I will adapt this and the following s/mplcec4/cec4/ occurrences.



>> +
>> +static unsigned int mplcec4_mpp_config[] __initdata = {
>> +	MPP0_NF_IO2,
>> +	MPP1_NF_IO3,
>> +	MPP2_NF_IO4,
>> +	MPP3_NF_IO5,
>> +	MPP4_NF_IO6,
>> +	MPP5_NF_IO7,
>> +	MPP6_SYSRST_OUTn,
>> +	MPP7_GPO,	/* Status LED Green High Active */
>> +	MPP10_UART0_TXD,
>> +	MPP11_UART0_RXD,
>> +	MPP12_SD_CLK,
>> +	MPP13_SD_CMD,	/* Alt UART1_TXD */
>> +	MPP14_SD_D0,	/* Alt UART1_RXD */
>> +	MPP15_SD_D1,
>> +	MPP16_SD_D2,
>> +	MPP17_SD_D3,
>> +	MPP18_NF_IO0,
>> +	MPP19_NF_IO1,
>> +	MPP28_GPIO,	/* Input SYS_POR_DET (active High) */
>> +	MPP29_GPIO,	/* Input SYS_RTC_INT (active High) */
>> +	MPP34_SATA1_ACTn,
>> +	MPP35_SATA0_ACTn,
>> +	MPP40_GPIO,	/* LED User1 orange */
>> +	MPP41_GPIO,	/* LED User1 green */
>> +	MPP44_GPIO,	/* LED User0 orange */
>> +	MPP45_GPIO,	/* LED User0 green */
>> +	MPP46_GPIO,	/* Status LED Yellow High Active */
>> +	MPP47_GPIO,	/* SD_CD# (in/IRQ)*/
>> +	0
>> +};
> 
> We're this to DT during this merge window, but don't worry about
> changing it.  We'll be doing a cleanup patch to catch the new boards.
> If you could just keep an eye out for it and test, it would be
> appreciated.


If you can point me to the appropriate tree, I'd like to try to do this
myself. I could even rebase the CEC4 patch to this tree if you prefer.

> 
> This looks really good, if you can turn around a V2, I should be able to
> get this in for v3.8.  It's getting close, though.

I will try to comply ASAP.


Thank you very much for the prompt review.


Regards

Stefan Peter

-- 
MPL AG, Switzerland                     http://www.mpl.ch
Tel. +41 (0)56 483 34 34          Fax: +41(0)56 493 30 20
