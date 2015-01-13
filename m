From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Tue, 13 Jan 2015 09:08:38 -0800
Subject: [PATCH v5] can: Convert to runtime_pm
In-Reply-To: <54B4FCB5.6040904@pengutronix.de>
References: <baf987c11c0242c2bf87b81f9396b09d@BN1BFFO11FD018.protection.gbl>
 <3a3437c5c8ff48d9a45fee7e81fa8dca@BY2FFO11FD058.protection.gbl>
 <54B4FCB5.6040904@pengutronix.de>
Message-ID: <6ea3c0ea0f5c4deb9a6e4738a8d94a36@BN1AFFO11FD047.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2015-01-13 at 12:08PM +0100, Marc Kleine-Budde wrote:
> On 01/12/2015 07:45 PM, S?ren Brinkmann wrote:
> > On Mon, 2015-01-12 at 08:34PM +0530, Kedareswara rao Appana wrote:
> >> Instead of enabling/disabling clocks at several locations in the driver,
> >> Use the runtime_pm framework. This consolidates the actions for runtime PM
> >> In the appropriate callbacks and makes the driver more readable and mantainable.
> >>
> >> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> >> Signed-off-by: Kedareswara rao Appana <appanad@xilinx.com>
> >> ---
> >> Changes for v5:
> >>  - Updated with the review comments.
> >>    Updated the remove fuction to use runtime_pm.
> >> Chnages for v4:
> >>  - Updated with the review comments.
> >> Changes for v3:
> >>   - Converted the driver to use runtime_pm.
> >> Changes for v2:
> >>   - Removed the struct platform_device* from suspend/resume
> >>     as suggest by Lothar.
> >>
> >>  drivers/net/can/xilinx_can.c |  157 ++++++++++++++++++++++++++++-------------
> >>  1 files changed, 107 insertions(+), 50 deletions(-)
> > [..]
> >> +static int __maybe_unused xcan_runtime_resume(struct device *dev)
> >>  {
> >> -	struct platform_device *pdev = dev_get_drvdata(dev);
> >> -	struct net_device *ndev = platform_get_drvdata(pdev);
> >> +	struct net_device *ndev = dev_get_drvdata(dev);
> >>  	struct xcan_priv *priv = netdev_priv(ndev);
> >>  	int ret;
> >> +	u32 isr, status;
> >>  
> >>  	ret = clk_enable(priv->bus_clk);
> >>  	if (ret) {
> >> @@ -1014,15 +1030,28 @@ static int __maybe_unused xcan_resume(struct device *dev)
> >>  	ret = clk_enable(priv->can_clk);
> >>  	if (ret) {
> >>  		dev_err(dev, "Cannot enable clock.\n");
> >> -		clk_disable_unprepare(priv->bus_clk);
> >> +		clk_disable(priv->bus_clk);
> > [...]
> >> @@ -1173,12 +1219,23 @@ static int xcan_remove(struct platform_device *pdev)
> >>  {
> >>  	struct net_device *ndev = platform_get_drvdata(pdev);
> >>  	struct xcan_priv *priv = netdev_priv(ndev);
> >> +	int ret;
> >> +
> >> +	ret = pm_runtime_get_sync(&pdev->dev);
> >> +	if (ret < 0) {
> >> +		netdev_err(ndev, "%s: pm_runtime_get failed(%d)\n",
> >> +				__func__, ret);
> >> +		return ret;
> >> +	}
> >>  
> >>  	if (set_reset_mode(ndev) < 0)
> >>  		netdev_err(ndev, "mode resetting failed!\n");
> >>  
> >>  	unregister_candev(ndev);
> >> +	pm_runtime_disable(&pdev->dev);
> >>  	netif_napi_del(&priv->napi);
> >> +	clk_disable_unprepare(priv->bus_clk);
> >> +	clk_disable_unprepare(priv->can_clk);
> > 
> > Shouldn't pretty much all these occurrences of clk_disable/enable
> > disappear? This should all be handled by the runtime_pm framework now.
> 
> We have:
> - clk_prepare_enable() in probe

This should become something like pm_runtime_get_sync(), shouldn't it?

> - clk_disable_unprepare() in remove

pm_runtime_put()

> - clk_enable() in runtime_resume
> - clk_disable() in runtime_suspend

These are the ones needed.

The above makes me suspect that the clocks are always on, regardless of
the runtime suspend state since they are enabled in probe and disabled
in remove, is that right? Ideally, the usage in probe and remove should
be migrated to runtime_pm and clocks should really only be running when
needed and not throughout the whole lifetime of the driver.

	S?ren
