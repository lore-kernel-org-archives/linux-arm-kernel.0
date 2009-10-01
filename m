From: linuxzsc@gmail.com (Richard Zhao)
Date: Thu, 1 Oct 2009 15:52:15 +0800
Subject: [PATCH 2/4] i2c: imx: only imx1 needs disable delay
In-Reply-To: <20091001072643.GW27039@pengutronix.de>
References: <1254359613-21210-1-git-send-email-linuxzsc@gmail.com>
	<1254359613-21210-2-git-send-email-linuxzsc@gmail.com>
	<20091001072643.GW27039@pengutronix.de>
Message-ID: <4e090d470910010052k37a0a4eep6d436e45e6524234@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 1, 2009 at 3:26 PM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Thu, Oct 01, 2009 at 09:13:31AM +0800, Richard Zhao wrote:
>> check cpu_is_mx1() when set disable_delay.
>>
>> Signed-off-by: Richard Zhao <linuxzsc@gmail.com>
>>
>> diff --git a/drivers/i2c/busses/i2c-imx.c b/drivers/i2c/busses/i2c-imx.c
>> index 156cc95..c1e541c 100644
>> --- a/drivers/i2c/busses/i2c-imx.c
>> +++ b/drivers/i2c/busses/i2c-imx.c
>> @@ -254,14 +254,16 @@ static void __init i2c_imx_set_clk(struct imx_i2c_struct *i2c_imx,
>> ? ? ? /* Write divider value to register */
>> ? ? ? writeb(i2c_clk_div[i][1], i2c_imx->base + IMX_I2C_IFDR);
>>
>> - ? ? /*
>> - ? ? ?* There dummy delay is calculated.
>> - ? ? ?* It should be about one I2C clock period long.
>> - ? ? ?* This delay is used in I2C bus disable function
>> - ? ? ?* to fix chip hardware bug.
>> - ? ? ?*/
>> - ? ? i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
>> - ? ? ? ? ? ? + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>> + ? ? if (cpu_is_mx1()) {
>> + ? ? ? ? ? ? /*
>> + ? ? ? ? ? ? ?* There dummy delay is calculated.
>> + ? ? ? ? ? ? ?* It should be about one I2C clock period long.
>> + ? ? ? ? ? ? ?* This delay is used in I2C bus disable function
>> + ? ? ? ? ? ? ?* to fix chip hardware bug.
>> + ? ? ? ? ? ? ?*/
>> + ? ? ? ? ? ? i2c_imx->disable_delay = (500000U * i2c_clk_div[i][0]
>> + ? ? ? ? ? ? ? ? ? ? + (i2c_clk_rate / 2) - 1) / (i2c_clk_rate / 2);
>> + ? ? }
>
> I think you should put the udelay(i2c_imx->disable_delay) in
> cpu_is_mx1() rather than the calculation.
>
> Sascha
>
>
> --
> Pengutronix e.K. ? ? ? ? ? ? ? ? ? ? ? ? ? | ? ? ? ? ? ? ? ? ? ? ? ? ? ? |
> Industrial Linux Solutions ? ? ? ? ? ? ? ? | http://www.pengutronix.de/ ?|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 ? ?|
> Amtsgericht Hildesheim, HRA 2686 ? ? ? ? ? | Fax: ? +49-5121-206917-5555 |
>
Do you think udelay(0) wast any more time than if()?
And Could I get all you comments in a single patch loop?

Thanks
Richard
