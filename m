From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Jan 2015 14:20:32 -0600
Subject: [PATCH 3/3] remoteproc: wkup_m3: Add wkup_m3 remote proc driver
In-Reply-To: <54AAEFA6.3080603@ti.com>
References: <1420228319-41085-1-git-send-email-d-gerlach@ti.com>
 <1420228319-41085-4-git-send-email-d-gerlach@ti.com>
 <20150102200424.GD4920@saruman> <54AAEFA6.3080603@ti.com>
Message-ID: <20150105202032.GQ19336@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 05, 2015 at 02:10:14PM -0600, Dave Gerlach wrote:
> >> Add a remoteproc driver to load the firmware for and boot the wkup_m3
> >> present on am33xx. The wkup_m3 is an integrated Cortex M3 that allows
> >> the SoC to enter the lowest possible power state by taking control from
> >> the MPU after it has gone into its own low power state and shutting off
> >> any additional peripherals.
> >>
> >> The driver expects a resource table to be present in the wkup_m3
> >> firmware to define the required memory resources needed by the wkup_m3,
> >> at least the data memory so that the firmware can be copied to the proper
> >> place for execution.
> >>
> >> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> >> ---
> >>  drivers/remoteproc/Kconfig         |  12 +++
> >>  drivers/remoteproc/Makefile        |   1 +
> >>  drivers/remoteproc/wkup_m3_rproc.c | 175 +++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 188 insertions(+)
> >>  create mode 100644 drivers/remoteproc/wkup_m3_rproc.c
> >>
> >> diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >> index 5e343ba..7fbdb53 100644
> >> --- a/drivers/remoteproc/Kconfig
> >> +++ b/drivers/remoteproc/Kconfig
> >> @@ -41,6 +41,18 @@ config STE_MODEM_RPROC
> >>  	  This can be either built-in or a loadable module.
> >>  	  If unsure say N.
> >>  
> >> +config WKUP_M3_RPROC
> >> +	bool "AM33xx wkup-m3 remoteproc support"
> > 
> > it would be nicer if this could be a loadable module.
> 
> Do we really want that though? This is required for core PM functionality like
> CPUIdle and Suspend/resume, I feel that it should always be built in for am335x.
> I had been taking this approach with all of the PM dependencies.

right, will we have CPUIdle or suspend/resume during boot ?

> >> +static const struct of_device_id wkup_m3_rproc_of_match[] = {
> >> +	{
> >> +		.compatible = "ti,am3353-wkup-m3",
> >> +		.data = (void *)"am335x-pm-firmware.elf",
> > 
> > do you know of anybody else who might want to different firmware image
> > name ? Otherwise why pass it as driver_data ?
> 
> I suppose we could pass the name in the devicetree. I do not know of any other
> users of other firmware but it's probably better to keep things flexible.

or, since this is handled internally to the driver, we can refactor this
name passing later, when we actually need a different firmware depending
on different devices. No ?

> >> +static int wkup_m3_rproc_probe(struct platform_device *pdev)
> >> +{
> >> +	struct device *dev = &pdev->dev;
> >> +	const char *fw_name;
> >> +	struct wkup_m3_platform_data *pdata = dev->platform_data;
> >> +	struct wkup_m3_rproc *m3_rproc;
> >> +	const struct of_device_id *match;
> >> +	struct rproc *rproc;
> >> +	int ret;
> >> +
> >> +	if (!(pdata && pdata->deassert_reset && pdata->assert_reset &&
> >> +	      pdata->reset_name)) {
> >> +		dev_err(dev, "Platform data missing!\n");
> >> +		return -ENODEV;
> >> +	}
> > 
> > if pdata is missing, couldn't you assume the thing has been reset and
> > try to load anyway ?
> 
> Probably not, we MUST reset after loading the firmware as that is what boots the
> wkup_m3.

alright, perhaps add a comment ?

> >> +	match = of_match_device(wkup_m3_rproc_of_match, &pdev->dev);
> >> +	if (!match)
> >> +		return -ENODEV;
> >> +	fw_name = (char *)match->data;
> >> +
> >> +	pm_runtime_enable(&pdev->dev);
> >> +
> >> +	ret = pm_runtime_get_sync(&pdev->dev);
> >> +	if (IS_ERR_VALUE(ret)) {
> >> +		dev_err(&pdev->dev, "pm_runtime_get_sync() failed\n");
> >> +		return ret;
> > 
> > this is wrong for two reasons:
> > 
> > a) you need to pm_runtime_disable();
> > b) even if pm_runtime_get*() fails, you _must_ call
> > 	pm_runtime_put_sync();
> 
> Ok I will fix this and the following pm_runtime issues. Didn't realize you still
> had to call put_sync after a failed get_sync.

alright.

> >> +static int wkup_m3_rpm_suspend(struct device *dev)
> >> +{
> >> +	return -EBUSY;
> >> +}
> > 
> > looks like this is just coping with omap_device bogosity, no ?
> >
> 
> Yes, without this omap_device shuts down ther wkup_m3 during suspend, which of
> course prevents the wkup_m3 from finishing suspend process or waking SoC back
> up. Haven't found a better solution for the problem than this.

Tony, any better for this ? Do we keep this small hack or find a better
way ?

> >> +static int wkup_m3_rpm_resume(struct device *dev)
> >> +{
> >> +	return 0;
> >> +}
> >> +
> >> +static const struct dev_pm_ops wkup_m3_rproc_pm_ops = {
> >> +	SET_RUNTIME_PM_OPS(wkup_m3_rpm_suspend, wkup_m3_rpm_resume, NULL)
> >> +};
> >> +
> >> +static struct platform_driver wkup_m3_rproc_driver = {
> >> +	.probe = wkup_m3_rproc_probe,
> >> +	.remove = wkup_m3_rproc_remove,
> >> +	.driver = {
> >> +		.name = "wkup_m3",
> >> +		.of_match_table = wkup_m3_rproc_of_match,
> >> +		.pm = &wkup_m3_rproc_pm_ops,
> >> +	},
> >> +};
> >> +
> >> +module_platform_driver(wkup_m3_rproc_driver);
> >> +
> >> +MODULE_LICENSE("GPL v2");
> >> +MODULE_DESCRIPTION("wkup m3 remote processor control driver");
> > 
> > do you want to add MODULE_AUTHOR() ?
> > 
> 
> Yes. Thanks for the comments.

np.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/b91cbca5/attachment.sig>
