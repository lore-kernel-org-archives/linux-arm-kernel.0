From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Thu, 13 Nov 2014 11:46:12 +0100
Subject: [PATCH] can: Fix bug in suspend/resume
In-Reply-To: <546484D9.4030005@pengutronix.de>
References: <a44efc1fb0144cca9d0c4851cc51db25@BL2FFO11FD024.protection.gbl>
 <546484D9.4030005@pengutronix.de>
Message-ID: <54648BF4.60007@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/13/2014 11:15 AM, Marc Kleine-Budde wrote:
> On 11/13/2014 07:58 AM, Kedareswara rao Appana wrote:
>> When accessing the priv structure use container_of instead of dev_get_drvdata.
> 
> Why?

The drvdata here is the struct net_device, not the platform device.
Please state this in the commit message.

If I understand the code correct, you can make use of the existing
helper function to_platform_device():

http://lxr.free-electrons.com/source/include/linux/platform_device.h#L42

> 
>> Enable the clocks in the suspend before accessing the registers of the CAN.
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>> ---
>>  drivers/net/can/xilinx_can.c |   20 ++++++++++++++++++--
>>  1 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
>> index 5e8b560..63ef645 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -972,15 +972,30 @@ static const struct net_device_ops xcan_netdev_ops = {
>>   */
>>  static int __maybe_unused xcan_suspend(struct device *dev)
>>  {
>> -	struct platform_device *pdev = dev_get_drvdata(dev);
>> +	struct platform_device *pdev = container_of(dev,
>> +			struct platform_device, dev);
>>  	struct net_device *ndev = platform_get_drvdata(pdev);
>>  	struct xcan_priv *priv = netdev_priv(ndev);
>> +	int ret;
>>  
>>  	if (netif_running(ndev)) {
>>  		netif_stop_queue(ndev);
>>  		netif_device_detach(ndev);
>>  	}
>>  
>> +	ret = clk_prepare_enable(priv->can_clk);
>> +	if (ret) {
>> +		dev_err(dev, "unable to enable device clock\n");
>> +		return ret;
>> +	}
>> +
>> +	ret = clk_prepare_enable(priv->bus_clk);
>> +	if (ret) {
>> +		dev_err(dev, "unable to enable bus clock\n");
>> +		clk_disable_unprepare(priv->can_clk);
>> +		return ret;
>> +	}
> 
> Now you have clock imbalance. Per suspend/resume cycle the clocks are
> enabled twice, but disabled only once.
> 
>> +
>>  	priv->write_reg(priv, XCAN_MSR_OFFSET, XCAN_MSR_SLEEP_MASK);
>>  	priv->can.state = CAN_STATE_SLEEPING;
>>  
>> @@ -999,7 +1014,8 @@ static int __maybe_unused xcan_suspend(struct device *dev)
>>   */
>>  static int __maybe_unused xcan_resume(struct device *dev)
>>  {
>> -	struct platform_device *pdev = dev_get_drvdata(dev);
>> +	struct platform_device *pdev = container_of(dev,
>> +			struct platform_device, dev);
>>  	struct net_device *ndev = platform_get_drvdata(pdev);
>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>  	int ret;

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
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141113/fb52e0ee/attachment.sig>
