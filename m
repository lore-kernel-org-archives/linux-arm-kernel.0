From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Mon, 25 Nov 2013 18:48:11 +0100
Subject: [PATCH 2/2] ARM i.MX5: set CAN peripheral clock to 24 MHz parent
In-Reply-To: <1385400467.906340545@f177.i.mail.ru>
References: <1385399751-19109-1-git-send-email-mkl@pengutronix.de>
 <1385399751-19109-3-git-send-email-mkl@pengutronix.de>
 <1385400467.906340545@f177.i.mail.ru>
Message-ID: <52938D5B.6030002@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/25/2013 06:27 PM, Alexander Shiyan wrote:
>> This patch sets the parent of CAN peripheral clock (a.k.a. CPI clock) to the
>> lp_apm clock, which has a rate of 24 MHz.
>>
>> In the CAN world a base clock with multiple of 8 MHz is suited best for all CIA
>> recommented bit rates. Without this patch the CAN peripheral clock on i.MX53
>> has a rate of 66.666 MHz which produces quite large bit rate errors.
>>
>> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> ---
>>  arch/arm/mach-imx/clk-imx51-imx53.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/arch/arm/mach-imx/clk-imx51-imx53.c b/arch/arm/mach-imx/clk-imx51-imx53.c
>> index e349fd5..28f7f3f 100644
>> --- a/arch/arm/mach-imx/clk-imx51-imx53.c
>> +++ b/arch/arm/mach-imx/clk-imx51-imx53.c
>> @@ -306,6 +306,9 @@ static void __init mx5_clocks_common_init(unsigned long rate_ckil,
>>  	/* move usb phy clk to 24MHz */
>>  	clk_set_parent(clk[IMX5_CLK_USB_PHY_SEL], clk[IMX5_CLK_OSC]);
>>  
>> +	/* move can bus clk to 24MHz */
>> +	clk_set_parent(clk[IMX5_CLK_CAN_SEL], clk[IMX5_CLK_LP_APM]);
>> +
>>  	clk_prepare_enable(clk[IMX5_CLK_GPC_DVFS]);
>>  	clk_prepare_enable(clk[IMX5_CLK_AHB_MAX]); /* esdhc3 */
>>  	clk_prepare_enable(clk[IMX5_CLK_AIPS_TZ1]);
>> -- 
> 
> Again, CAN is missing on i.MX51, so this should be moved from common_init function.

Doh, will fix.

Marc

-- 
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 259 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131125/0e9eb91c/attachment.sig>
