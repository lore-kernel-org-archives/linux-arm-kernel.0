From: joshc@codeaurora.org (Josh Cartwright)
Date: Tue, 29 Oct 2013 11:26:15 -0500
Subject: [PATCH v3 02/10] spmi: Linux driver framework for SPMI
In-Reply-To: <1383058923.2837.33.camel@iivanov-dev.int.mm-sol.com>
References: <cover.1382985169.git.joshc@codeaurora.org>
 <149bbfe89e37376cc176c3aeb6c1fab9e4fd2b91.1382985169.git.joshc@codeaurora.org>
 <1383058923.2837.33.camel@iivanov-dev.int.mm-sol.com>
Message-ID: <20131029162615.GH20207@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 29, 2013 at 05:02:03PM +0200, Ivan T. Ivanov wrote:
> On Mon, 2013-10-28 at 13:12 -0500, Josh Cartwright wrote: 
> > From: Kenneth Heitke <kheitke@codeaurora.org>
> > 
> > System Power Management Interface (SPMI) is a specification
> > developed by the MIPI (Mobile Industry Process Interface) Alliance
> > optimized for the real time control of Power Management ICs (PMIC).
> > 
> > SPMI is a two-wire serial interface that supports up to 4 master
> > devices and up to 16 logical slaves.
> > 
> > The framework supports message APIs, multiple busses (1 controller
> > per bus) and multiple clients/slave devices per controller.
> > 
> > Signed-off-by: Kenneth Heitke <kheitke@codeaurora.org>
> > Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
[..]
> > +static int spmi_drv_probe(struct device *dev)
> > +{
> > +	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
> > +	int err = 0;
> > +
> > +	if (sdrv->probe)
> > +		err = sdrv->probe(to_spmi_device(dev));
> > +
> > +	return err;
> > +}
> > +
> > +static int spmi_drv_remove(struct device *dev)
> > +{
> > +	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
> > +	int err = 0;
> > +
> > +	if (sdrv->remove)
> > +		err = sdrv->remove(to_spmi_device(dev));
> > +
> > +	return err;
> > +}
> > +
> > +static void spmi_drv_shutdown(struct device *dev)
> > +{
> > +	const struct spmi_driver *sdrv = to_spmi_driver(dev->driver);
> > +
> > +	if (sdrv->shutdown)
> 
> If driver for device is not loaded this will cause kernel NULL
> pointer dereference.

Indeed.  I'll fix this.

> > +static int of_spmi_register_devices(struct spmi_controller *ctrl)
> > +{
> > +	struct device_node *node;
> > +	int err;
> > +
> > +	dev_dbg(&ctrl->dev, "of_spmi_register_devices\n");
> > +
> > +	if (!ctrl->dev.of_node)
> > +		return -ENODEV;
> > +
> > +	dev_dbg(&ctrl->dev, "looping through children\n");
> > +
> > +	for_each_available_child_of_node(ctrl->dev.of_node, node) {
> > +		struct spmi_device *sdev;
> > +		u32 reg[2];
> > +
> > +		dev_dbg(&ctrl->dev, "adding child %s\n", node->full_name);
> > +
> > +		err = of_property_read_u32_array(node, "reg", reg, 2);
> > +		if (err) {
> > +			dev_err(&ctrl->dev,
> > +				"node %s does not have 'reg' property\n",
> > +				node->full_name);
> > +			continue;
> 
> Shouldn't this be a fatal error?

Fatal in what way?  It is fatal in the sense that this particular child
node is skipped, but other children can still be enumerated.  Are you
suggesting that we bail completely when we hit a wrongly-described
child?

> > +		}
> > +
> > +		if (reg[1] != SPMI_USID) {
> > +			dev_err(&ctrl->dev,
> > +				"node %s contains unsupported 'reg' entry\n",
> > +				node->full_name);
> > +			continue;
> > +		}
> > +
> > +		if (reg[0] > 0xF) {
> > +			dev_err(&ctrl->dev,
> > +				"invalid usid on node %s\n",
> > +				node->full_name);
> > +			continue;
> > +		}
> > +
> > +		dev_dbg(&ctrl->dev, "read usid %02x\n", reg[0]);
> > +
> > +		sdev = spmi_device_alloc(ctrl);
> > +		if (!sdev)
> > +			continue;
> > +
> > +		sdev->dev.of_node = node;
> > +		sdev->usid = (u8) reg[0];
> > +
> > +		err = spmi_device_add(sdev);
> > +		if (err) {
> > +			dev_err(&sdev->dev,
> > +				"failure adding device. status %d\n", err);
> > +			spmi_device_put(sdev);
> > +			continue;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +int spmi_controller_add(struct spmi_controller *ctrl)
> > +{
> > +	int ret;
> > +
> > +	/* Can't register until after driver model init */
> > +	if (WARN_ON(!spmi_bus_type.p))
> > +		return -EAGAIN;
> > +
> > +	ret = device_add(&ctrl->dev);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (IS_ENABLED(CONFIG_OF))
> > +		of_spmi_register_devices(ctrl);
> 
> Check for error code here?

And do what with it?  Maybe instead, I should make
of_spmi_register_devices() return void.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
