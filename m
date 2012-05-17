From: aisheng.dong@freescale.com (Dong Aisheng)
Date: Thu, 17 May 2012 10:50:26 +0800
Subject: [PATCH] pinctrl: mxs: add gpio range support
In-Reply-To: <20120517024715.GH3764@S2100-06.ap.freescale.net>
References: <1337061374-24823-1-git-send-email-shawn.guo@linaro.org>
 <20120515115113.GC10347@shlinux2.ap.freescale.net>
 <20120517024715.GH3764@S2100-06.ap.freescale.net>
Message-ID: <20120517025025.GI10347@shlinux2.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 17, 2012 at 10:47:15AM +0800, Guo Shawn-R65073 wrote:
...
> > > +	for_each_child_of_node(np, child) {
> > > +		if (!of_device_is_compatible(child, "fsl,mxs-gpio"))
> > > +			continue;
> > I planned to use a phandle list to point to gpio nodes rather than forcing
> > put gpio nodes under pinctrl node.
> 
> On mxs, the gpio nodes are naturally under pinctrl node, because gpio
> controller is part of pin controller and share the same IO space range
> with pin controller.
> 
Well, for that point, it seems reasonable to me.

> For the phandle approach, there is a patch from Viresh Kumar "gpiolib:
> Add of_get_gpio_chip_by_phandle() helper" are currently flowing around
> on the list.  But it hasn't been accepted.  The whole pull-request of
> "SPEAr pinctrl updates for v-3.5" is being held on this.
> 
> http://thread.gmane.org/gmane.linux.ports.arm.kernel/166668/focus=167395
> 
Thanks for the info.

> > I will send out the common patch for discussion.
> > 
> > > +
> > > +		id = of_alias_get_id(child, "gpio");
> > > +		if (id < 0 || id > soc->gpio_num_ranges) {
> > > +			dev_err(&pdev->dev, "invalid gpio id: %d\n", id);
> > > +			return id;
> > > +		}
> > > +
> > > +		for (i = j; i < soc->gpio_num_ranges; i++) {
> > I'm wondering this may fail if the gpio nodes are not sequentially listed
> > in dts file.
> > 
> This is a mxs specific implementation, and we do have gpio nodes
> sequentially listed under pinctrl node.
> 
I'm wondering if dt forces user to define the same device sequentially.
But if not, the driver may be better not assume how the device node are
organized in dts, right?
If we really want do like this, do we need to add some comments in binding doc?

Regards
Dong Aisheng
