From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Thu, 13 Nov 2014 11:01:30 +0000
Subject: [PATCH] can: Fix bug in suspend/resume
References: <a44efc1fb0144cca9d0c4851cc51db25@BL2FFO11FD024.protection.gbl>
 <546484D9.4030005@pengutronix.de> <54648BF4.60007@pengutronix.de>
Message-ID: <2abd0a7b76bd4c5fab3cda60b8e2f8d1@BN1AFFO11FD030.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

-----Original Message-----
From: Appana Durga Kedareswara Rao
Sent: Thursday, November 13, 2014 4:28 PM
To: 'Marc Kleine-Budde'; wg at grandegger.com; Michal Simek; Soren Brinkmann; grant.likely at linaro.org; robh+dt at kernel.org
Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org
Subject: RE: [PATCH] can: Fix bug in suspend/resume

Hi Marc,

-----Original Message-----
From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
Sent: Thursday, November 13, 2014 4:16 PM
To: Appana Durga Kedareswara Rao; wg at grandegger.com; Michal Simek; Soren Brinkmann; grant.likely at linaro.org; robh+dt at kernel.org
Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-kernel at lists.infradead.org; linux-kernel at vger.kernel.org; devicetree at vger.kernel.org; Appana Durga Kedareswara Rao
Subject: Re: [PATCH] can: Fix bug in suspend/resume

On 11/13/2014 11:15 AM, Marc Kleine-Budde wrote:
> On 11/13/2014 07:58 AM, Kedareswara rao Appana wrote:
>> When accessing the priv structure use container_of instead of dev_get_drvdata.
>
> Why?

The drvdata here is the struct net_device, not the platform device.
Please state this in the commit message.

If I understand the code correct, you can make use of the existing helper function to_platform_device():

http://lxr.free-electrons.com/source/include/linux/platform_device.h#L42

Thanks for the suggestion.
 Will use this macro(to_platform_device)  .

>
>> Enable the clocks in the suspend before accessing the registers of the CAN.
>>
>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>> ---
>>  drivers/net/can/xilinx_can.c |   20 ++++++++++++++++++--
>>  1 files changed, 18 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/can/xilinx_can.c
>> b/drivers/net/can/xilinx_can.c index 5e8b560..63ef645 100644
>> --- a/drivers/net/can/xilinx_can.c
>> +++ b/drivers/net/can/xilinx_can.c
>> @@ -972,15 +972,30 @@ static const struct net_device_ops xcan_netdev_ops = {
>>   */
>>  static int __maybe_unused xcan_suspend(struct device *dev)  {
>> -    struct platform_device *pdev = dev_get_drvdata(dev);
>> +    struct platform_device *pdev = container_of(dev,
>> +                    struct platform_device, dev);
>>      struct net_device *ndev = platform_get_drvdata(pdev);
>>      struct xcan_priv *priv = netdev_priv(ndev);
>> +    int ret;
>>
>>      if (netif_running(ndev)) {
>>              netif_stop_queue(ndev);
>>              netif_device_detach(ndev);
>>      }
>>
>> +    ret = clk_prepare_enable(priv->can_clk);
>> +    if (ret) {
>> +            dev_err(dev, "unable to enable device clock\n");
>> +            return ret;
>> +    }
>> +
>> +    ret = clk_prepare_enable(priv->bus_clk);
>> +    if (ret) {
>> +            dev_err(dev, "unable to enable bus clock\n");
>> +            clk_disable_unprepare(priv->can_clk);
>> +            return ret;
>> +    }
>
> Now you have clock imbalance. Per suspend/resume cycle the clocks are
> enabled twice, but disabled only once.
>

The clocks are getting disabled and un prepared at the end of the probe.
In the resume the driver is doing register write.

Sorry spell mistake not in resume in the suspend I am doing a register write.

In order to do that register write I have to again enable and prepare the clocks.


Regards,
Kedar.


Regards,
Kedar.

>> +
>>      priv->write_reg(priv, XCAN_MSR_OFFSET, XCAN_MSR_SLEEP_MASK);
>>      priv->can.state = CAN_STATE_SLEEPING;
>>
>> @@ -999,7 +1014,8 @@ static int __maybe_unused xcan_suspend(struct device *dev)
>>   */
>>  static int __maybe_unused xcan_resume(struct device *dev)  {
>> -    struct platform_device *pdev = dev_get_drvdata(dev);
>> +    struct platform_device *pdev = container_of(dev,
>> +                    struct platform_device, dev);
>>      struct net_device *ndev = platform_get_drvdata(pdev);
>>      struct xcan_priv *priv = netdev_priv(ndev);
>>      int ret;

Marc

--
Pengutronix e.K.                  | Marc Kleine-Budde           |
Industrial Linux Solutions        | Phone: +49-231-2826-924     |
Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
