From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 15 Jul 2014 15:57:46 +0200
Subject: [PATCH v3 3/4] can: flexcan: switch on clocks before accessing
 ecr register
In-Reply-To: <20140715155426.3c03f0d8@ipc1.ka-ro>
References: <cover.1405428166.git.stefan@agner.ch>	<c80f9d2ec80d01088e51be61a4e7845cbfe58f6a.1405428166.git.stefan@agner.ch>
 <20140715155426.3c03f0d8@ipc1.ka-ro>
Message-ID: <53C5335A.8000000@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/15/2014 03:54 PM, Lothar Wa?mann wrote:
> Hi,
> 
> Stefan Agner wrote:
>> Reported-by: Ashutosh Singh <ashuleapyear@gmail.com>
>> Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
>> [stefan at agner.ch: added return check for clk_enable_prepare]
>>
>> Signed-off-by: Stefan Agner <stefan@agner.ch>
>> ---
>>  drivers/net/can/flexcan.c | 18 ++++++++++++++++--
>>  1 file changed, 16 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/flexcan.c b/drivers/net/can/flexcan.c
>> index f425ec2..89745aa 100644
>> --- a/drivers/net/can/flexcan.c
>> +++ b/drivers/net/can/flexcan.c
>> @@ -383,12 +383,26 @@ static int flexcan_get_berr_counter(const struct net_device *dev,
>>  {
>>  	const struct flexcan_priv *priv = netdev_priv(dev);
>>  	struct flexcan_regs __iomem *regs = priv->base;
>> -	u32 reg = flexcan_read(&regs->ecr);
>> +	u32 reg, err;
>> +
>> +	err = clk_prepare_enable(priv->clk_ipg);
>> +	if (err)
>> +		return err;
>> +
>> +	err = clk_prepare_enable(priv->clk_per);
>> +	if (err)
>> +		goto out_disable_ipg;
>> +
>> +	reg = flexcan_read(&regs->ecr);
>>  
> flexcan_get_berr_counter() may be called from interrupt context and
> thus must not call any functions that can sleep.
> Compiling the driver with CONFIG_DEBUG_ATOMIC_SLEEP would catch this!

It's called from the NAPI softirq. I'll prepare a patch.

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
Size: 242 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140715/00bbeec8/attachment-0001.sig>
