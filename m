From: b32955@freescale.com (Huang Shijie)
Date: Mon, 2 Jul 2012 14:00:18 +0800
Subject: [PATCH v3 3/3] mtd: gpmi: change the code for clocks
In-Reply-To: <4FF133F9.50704@gmail.com>
References: <1341200327-8144-1-git-send-email-shijie8@gmail.com>
 <1341200327-8144-4-git-send-email-shijie8@gmail.com>
 <4FF133F9.50704@gmail.com>
Message-ID: <4FF138F2.6070503@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?02? 13:39, Hui Wang ??:
> Huang Shijie wrote:
>> The gpmi nand driver may needs several clocks(MX6Q needs five clocks).
>>
>> In the old clock framework, all these clocks are chained together,
>> all you need is to manipulate the first clock.
>>
>> But the kernel uses the common clk framework now, which forces us to
>> get the clocks one by one. When we use them, we have to enable them
>> one by one too.
>>
>> Signed-off-by: Huang Shijie <shijie8@gmail.com>
>> ---
>> arch/arm/boot/dts/imx6q-arm2.dts | 2 +-
>> drivers/mtd/nand/gpmi-nand/gpmi-lib.c | 43 ++++++++++++++---
>> drivers/mtd/nand/gpmi-nand/gpmi-nand.c | 82 
>> ++++++++++++++++++++++++++++----
>> drivers/mtd/nand/gpmi-nand/gpmi-nand.h | 3 +-
>> 4 files changed, 111 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/arm/boot/dts/imx6q-arm2.dts 
>> b/arch/arm/boot/dts/imx6q-arm2.dts
>> index 14e72e2..027a2f8 100644
>> --- a/arch/arm/boot/dts/imx6q-arm2.dts
>> +++ b/arch/arm/boot/dts/imx6q-arm2.dts
>> @@ -25,7 +25,7 @@
>> gpmi-nand at 00112000 {
>> pinctrl-names = "default";
>> pinctrl-0 = <&pinctrl_gpmi_nand_1>;
>> - status = "disabled"; /* gpmi nand conflicts with SD */
>> + status = "okay"; /* gpmi nand conflicts with SD */
>> };
>>
>> aips-bus at 02100000 { /* AIPS2 */
>> diff --git a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c 
>> b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> index a1f4332..c3778c0 100644
>> --- a/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> +++ b/drivers/mtd/nand/gpmi-nand/gpmi-lib.c
>> @@ -124,12 +124,40 @@ error:
>> return -ETIMEDOUT;
>> }
>>
>> +static int __gpmi_enable_clk(struct gpmi_nand_data *this, bool v)
>> +{
>> + struct clk *clk;
>> + int ret;
>> + int i;
>> +
>> + for (i = 0; i < GPMI_CLK_MAX; i++) {
>> + clk = this->resources.clock[i];
>> + if (!clk)
>> + break;
>> +
>> + if (v) {
>> + ret = clk_prepare_enable(clk);
>> + if (ret)
>> + goto err_clk;
>> + } else {
>> + clk_disable_unprepare(clk);
>> + }
>> + }
>> + return 0;
>> +
>> +err_clk:
> Doesn't this design introduce clk_enalbe/disable un-balance problems?
>
> Suppose you successfully enabled 1st and 2nd clocks, and failed at the 
> third clock, this function will return, then the caller function will 
> check the return value and call
>
> __gpmi_enable_clk(this, 0), in this function, it will unconditionally 
> disable all five clocks.
thanks, fix it in next version.

Huang Shijie
>
>
> Regards,
> Hui.
>
>> + return ret;
>> +}
>> +
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
