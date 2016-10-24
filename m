From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 24 Oct 2016 18:42:49 +0100
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <7hd1ipzm3h.fsf@baylibre.com>
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
 <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
 <20161024170035.GO15620@leverpostej> <7hd1ipzm3h.fsf@baylibre.com>
Message-ID: <20161024174249.GQ15620@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 10:35:30AM -0700, Kevin Hilman wrote:
> Hi Mark,
> 
> Mark Rutland <mark.rutland@arm.com> writes:
> > On Mon, Oct 24, 2016 at 06:46:36PM +0200, Bartosz Golaszewski wrote:
> >> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
> >> +{
> >> +	const struct da8xx_ddrctl_config_knob *knob;
> >> +	const struct da8xx_ddrctl_setting *setting;
> >> +	u32 regprop[2], base, memsize, reg;
> >> +	struct device_node *node, *parent;
> >> +	void __iomem *ddrctl;
> >> +	const char *board;
> >> +	struct device *dev;
> >> +	int ret;
> >> +
> >> +	dev = &pdev->dev;
> >> +	node = dev->of_node;
> >> +
> >> +	/* Find the board name. */
> >> +	for (parent = node;
> >> +	     !of_node_is_root(parent);
> >> +	     parent = of_get_parent(parent));
> >> +
> >> +	ret = of_property_read_string(parent, "compatible", &board);
> >> +	if (ret) {
> >> +		dev_err(dev, "unable to read the soc model\n");
> >> +		return ret;
> >> +	}
> >
> > I can see that you want to expose sysfs knobs for this, but is it really
> > necessary to match boards like this? It's very fragile, and commits us
> > to maintaining a database of board data (i.e. a board file).
> >
> > I am very much not keen on that.
> 
> The original proposal[1] was to create DT properties reflecting the
> various knobs in the DDR Controller, but that was frowned upon since
> that was more HW configuration than hardware description.
> 
> That resulted in this approach which keeps the HW configuration values
> in the driver, and selectable based on DT compatible.
> 
> IMO, neither aproach is pretty.  From a DT maintainer perspective, can
> you comment on your preference?

>From my PoV, it really depends on *why* we need this. What does the
tuning gain us, and is it specific to a given use-case?

Thanks,
Mark.
