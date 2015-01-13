From: mkl@pengutronix.de (Marc Kleine-Budde)
Date: Tue, 13 Jan 2015 19:03:32 +0100
Subject: [PATCH v5] can: Convert to runtime_pm
In-Reply-To: <922ff1827dfb484bbc42dbb56649d4b4@BN1BFFO11FD013.protection.gbl>
References: <baf987c11c0242c2bf87b81f9396b09d@BN1BFFO11FD018.protection.gbl>
 <3a3437c5c8ff48d9a45fee7e81fa8dca@BY2FFO11FD058.protection.gbl>
 <54B4FCB5.6040904@pengutronix.de>
 <6ea3c0ea0f5c4deb9a6e4738a8d94a36@BN1AFFO11FD047.protection.gbl>
 <54B55326.1060606@pengutronix.de>
 <1ef3e0f060f54c888061514bd2926762@BY2FFO11FD033.protection.gbl>
 <54B55993.4020806@pengutronix.de>
 <922ff1827dfb484bbc42dbb56649d4b4@BN1BFFO11FD013.protection.gbl>
Message-ID: <54B55DF4.2090505@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/13/2015 06:49 PM, S?ren Brinkmann wrote:
> On Tue, 2015-01-13 at 06:44PM +0100, Marc Kleine-Budde wrote:
>> On 01/13/2015 06:24 PM, S?ren Brinkmann wrote:
>>> On Tue, 2015-01-13 at 06:17PM +0100, Marc Kleine-Budde wrote:
>>>> On 01/13/2015 06:08 PM, S?ren Brinkmann wrote:
>>>>> On Tue, 2015-01-13 at 12:08PM +0100, Marc Kleine-Budde wrote:
>>>>>> On 01/12/2015 07:45 PM, S?ren Brinkmann wrote:
>>>>>>> On Mon, 2015-01-12 at 08:34PM +0530, Kedareswara rao Appana wrote:
>>>>>>>> Instead of enabling/disabling clocks at several locations in the driver,
>>>>>>>> Use the runtime_pm framework. This consolidates the actions for runtime PM
>>>>>>>> In the appropriate callbacks and makes the driver more readable and mantainable.
>>>>>>>>
>>>>>>>> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
>>>>>>>> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
>>>>>>>> ---
>>>>>>>> Changes for v5:
>>>>>>>>  - Updated with the review comments.
>>>>>>>>    Updated the remove fuction to use runtime_pm.
>>>>>>>> Chnages for v4:
>>>>>>>>  - Updated with the review comments.
>>>>>>>> Changes for v3:
>>>>>>>>   - Converted the driver to use runtime_pm.
>>>>>>>> Changes for v2:
>>>>>>>>   - Removed the struct platform_device* from suspend/resume
>>>>>>>>     as suggest by Lothar.
>>>>>>>>
>>>>>>>>  drivers/net/can/xilinx_can.c |  157 ++++++++++++++++++++++++++++-------------
>>>>>>>>  1 files changed, 107 insertions(+), 50 deletions(-)
>>>>>>> [..]
>>>>>>>> +static int __maybe_unused xcan_runtime_resume(struct device *dev)
>>>>>>>>  {
>>>>>>>> -	struct platform_device *pdev = dev_get_drvdata(dev);
>>>>>>>> -	struct net_device *ndev = platform_get_drvdata(pdev);
>>>>>>>> +	struct net_device *ndev = dev_get_drvdata(dev);
>>>>>>>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>>>>>>>  	int ret;
>>>>>>>> +	u32 isr, status;
>>>>>>>>  
>>>>>>>>  	ret = clk_enable(priv->bus_clk);
>>>>>>>>  	if (ret) {
>>>>>>>> @@ -1014,15 +1030,28 @@ static int __maybe_unused xcan_resume(struct device *dev)
>>>>>>>>  	ret = clk_enable(priv->can_clk);
>>>>>>>>  	if (ret) {
>>>>>>>>  		dev_err(dev, "Cannot enable clock.\n");
>>>>>>>> -		clk_disable_unprepare(priv->bus_clk);
>>>>>>>> +		clk_disable(priv->bus_clk);
>>>>>>> [...]
>>>>>>>> @@ -1173,12 +1219,23 @@ static int xcan_remove(struct platform_device *pdev)
>>>>>>>>  {
>>>>>>>>  	struct net_device *ndev = platform_get_drvdata(pdev);
>>>>>>>>  	struct xcan_priv *priv = netdev_priv(ndev);
>>>>>>>> +	int ret;
>>>>>>>> +
>>>>>>>> +	ret = pm_runtime_get_sync(&pdev->dev);
>>>>>>>> +	if (ret < 0) {
>>>>>>>> +		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
>>>>>>>> +				__func__, ret);
>>>>>>>> +		return ret;
>>>>>>>> +	}
>>>>>>>>  
>>>>>>>>  	if (set_reset_mode(ndev) < 0)
>>>>>>>>  		netdev_err(ndev, "mode resetting failed!\n");
>>>>>>>>  
>>>>>>>>  	unregister_candev(ndev);
>>>>>>>> +	pm_runtime_disable(&pdev->dev);
>>>>>>>>  	netif_napi_del(&priv->napi);
>>>>>>>> +	clk_disable_unprepare(priv->bus_clk);
>>>>>>>> +	clk_disable_unprepare(priv->can_clk);
>>>>>>>
>>>>>>> Shouldn't pretty much all these occurrences of clk_disable/enable
>>>>>>> disappear? This should all be handled by the runtime_pm framework now.
>>>>>>
>>>>>> We have:
>>>>>> - clk_prepare_enable() in probe
>>>>>
>>>>> This should become something like pm_runtime_get_sync(), shouldn't it?
>>>>>
>>>>>> - clk_disable_unprepare() in remove
>>>>>
>>>>> pm_runtime_put()
>>>>>
>>>>>> - clk_enable() in runtime_resume
>>>>>> - clk_disable() in runtime_suspend
>>>>>
>>>>> These are the ones needed.
>>>>>
>>>>> The above makes me suspect that the clocks are always on, regardless of
>>>>
>>>> Define "on" :)
>>>> The clocks are prepared after probe() exists, but not enabled. The first
>>>> pm_runtime_get_sync() will enable the clocks.
>>>>
>>>>> the runtime suspend state since they are enabled in probe and disabled
>>>>> in remove, is that right? Ideally, the usage in probe and remove should
>>>>> be migrated to runtime_pm and clocks should really only be running when
>>>>> needed and not throughout the whole lifetime of the driver.
>>>>
>>>> The clocks are not en/disabled via pm_runtime, because
>>>> pm_runtime_get_sync() is called from atomic contect. We can have another
>>>> look into the driver and try to change this.
>>
>>> Wasn't that why the call to pm_runtime_irq_safe() was added?
>>
>> Good question. That should be investigated.
>>
>>> Also, clk_enable/disable should be okay to be run from atomic context.
>>> And if the clock are already prepared after the exit of probe that
>>> should be enough. Then remove() should just have to do the unprepare.
>>> But I don't see why runtime_pm shouldn't be able to do the
>>> enable/disable.
>>
>> runtime_pm does call the clk_{enable,disable} function. But you mean
>> clk_prepare() + pm_runtime_get_sync() should be used in probe() instead
>> of calling clk_prepare_enable(). Good idea! I think the
>> "pm_runtime_set_active(&pdev->dev);" has to be removed from the patch.
> 
> Right, that's what I was thinking. The proposed changes make sense, IMHO.
> 
>>
>> Coming back whether blocking calls are allowed or not.
>> If you make a call to pm_runtime_irq_safe(), you state that it's okay to
>> call pm_runtime_get_sync() from atomic context. But it's only called in
>> open, probe, remove and in xcan_get_berr_counter, which is not called
>> from atomic either. So let's try to remove the pm_runtime_irq_safe() and
>> use clk_prepare_enable() clk_disable_unprepare() in the runtime_resume()
>> runtime_suspend() functions.
> 
> IIRC, xcan_get_berr_counter() is called from atomic context. I think
> that was how this got started.

In some drivers the get_berr_counter() function is used in the irq
handler, but here it's only called from outside, an thus from non atomic
context.

>From an older mail of yours:

> I have the feeling I'm missing something. If I remove the 'must not
> sleep' requirement from the runtime suspend/resume functions, I get
> this:
> 
> BUG: sleeping function called from invalid context at drivers/base/power/runtime.c:954

http://lxr.free-electrons.com/source/drivers/base/power/runtime.c#L954

I think it's failing because of the pm_runtime_irq_safe() call.

> in_atomic(): 0, irqs_disabled(): 0, pid: 161, name: ip
> INFO: lockdep is turned off.
> CPU: 0 PID: 161 Comm: ip Not tainted 3.18.0-rc1-xilinx-00059-g21da26693b61-dirty #104
> [<c00186a8>] (unwind_backtrace) from [<c00139f4>] (show_stack+0x20/0x24)
> [<c00139f4>] (show_stack) from [<c055a41c>] (dump_stack+0x8c/0xd0)
> [<c055a41c>] (dump_stack) from [<c0054808>] (__might_sleep+0x1ac/0x1e4)
> [<c0054808>] (__might_sleep) from [<c034f8f0>] (__pm_runtime_resume+0x40/0x9c)
> [<c034f8f0>] (__pm_runtime_resume) from [<c03b48d8>] (xcan_get_berr_counter+0x2c/0x9c)
> [<c03b48d8>] (xcan_get_berr_counter) from [<c03b2ecc>] (can_fill_info+0x160/0x1f4)
> [<c03b2ecc>] (can_fill_info) from [<c049f3b0>] (rtnl_fill_ifinfo+0x794/0x970)
> [<c049f3b0>] (rtnl_fill_ifinfo) from [<c04a0048>] (rtnl_dump_ifinfo+0x1b4/0x2fc)
> [<c04a0048>] (rtnl_dump_ifinfo) from [<c04af9c8>] (netlink_dump+0xe4/0x270)
> [<c04af9c8>] (netlink_dump) from [<c04b0764>] (__netlink_dump_start+0xdc/0x170)
> [<c04b0764>] (__netlink_dump_start) from [<c04a1fc4>] (rtnetlink_rcv_msg+0x154/0x1e0)
> [<c04a1fc4>] (rtnetlink_rcv_msg) from [<c04b1e88>] (netlink_rcv_skb+0x68/0xc4)
> [<c04b1e88>] (netlink_rcv_skb) from [<c04a045c>] (rtnetlink_rcv+0x28/0x34)
> [<c04a045c>] (rtnetlink_rcv) from [<c04b1770>] (netlink_unicast+0x144/0x210)
> [<c04b1770>] (netlink_unicast) from [<c04b1c9c>] (netlink_sendmsg+0x394/0x414)
> [<c04b1c9c>] (netlink_sendmsg) from [<c046ffcc>] (sock_sendmsg+0x8c/0xc0)
> [<c046ffcc>] (sock_sendmsg) from [<c04726bc>] (SyS_sendto+0xd8/0x114)
> [<c04726bc>] (SyS_sendto) from [<c000f3e0>] (ret_fast_syscall+0x0/0x48)
> 
> I.e. the core calls this function from atomic context. And in an earlier
> thread you said the core can also call this before/after calling the
> open/close callbacks (which applies here too, I think).

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150113/20ce237c/attachment.sig>
