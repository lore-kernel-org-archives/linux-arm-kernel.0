From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 24 Oct 2016 11:41:08 -0700
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <20161024174249.GQ15620@leverpostej> (Mark Rutland's message of
 "Mon, 24 Oct 2016 18:42:49 +0100")
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
 <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
 <20161024170035.GO15620@leverpostej> <7hd1ipzm3h.fsf@baylibre.com>
 <20161024174249.GQ15620@leverpostej>
Message-ID: <7hfunly4hn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mark Rutland <mark.rutland@arm.com> writes:

> On Mon, Oct 24, 2016 at 10:35:30AM -0700, Kevin Hilman wrote:
>> Hi Mark,
>> 
>> Mark Rutland <mark.rutland@arm.com> writes:
>> > On Mon, Oct 24, 2016 at 06:46:36PM +0200, Bartosz Golaszewski wrote:
>> >> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
>> >> +{
>> >> +	const struct da8xx_ddrctl_config_knob *knob;
>> >> +	const struct da8xx_ddrctl_setting *setting;
>> >> +	u32 regprop[2], base, memsize, reg;
>> >> +	struct device_node *node, *parent;
>> >> +	void __iomem *ddrctl;
>> >> +	const char *board;
>> >> +	struct device *dev;
>> >> +	int ret;
>> >> +
>> >> +	dev = &pdev->dev;
>> >> +	node = dev->of_node;
>> >> +
>> >> +	/* Find the board name. */
>> >> +	for (parent = node;
>> >> +	     !of_node_is_root(parent);
>> >> +	     parent = of_get_parent(parent));
>> >> +
>> >> +	ret = of_property_read_string(parent, "compatible", &board);
>> >> +	if (ret) {
>> >> +		dev_err(dev, "unable to read the soc model\n");
>> >> +		return ret;
>> >> +	}
>> >
>> > I can see that you want to expose sysfs knobs for this, but is it really
>> > necessary to match boards like this? It's very fragile, and commits us
>> > to maintaining a database of board data (i.e. a board file).
>> >
>> > I am very much not keen on that.
>> 
>> The original proposal[1] was to create DT properties reflecting the
>> various knobs in the DDR Controller, but that was frowned upon since
>> that was more HW configuration than hardware description.
>> 
>> That resulted in this approach which keeps the HW configuration values
>> in the driver, and selectable based on DT compatible.
>> 
>> IMO, neither aproach is pretty.  From a DT maintainer perspective, can
>> you comment on your preference?
>
> From my PoV, it really depends on *why* we need this. What does the
> tuning gain us, and is it specific to a given use-case?

This is essentially a bus controller which allows you to set relative
priorities of the various bus masters (CPU data, CPU instructions, DMA
channels, ethernet MAC, SATA, display controller, etc. etc.)

The reason behind this work in the first place is a specific
use-case. Namely, a display controller on this SoC needs its bus
priority to be adjusted in order to work reliably at certain
resolutions

The vendor BSPs for this chip just setup hard-coded values in the board
files (davinci, still hasn't fully migrated to DT) but we're trying to
figure out a better way.

The first approach was exposing DT knobs for all the priorities.  The
second approach was the other extermem allowing SoC or board-specific
hard-coded values.

Another possible approach would be getting rid of the hard-coded values
and exporting an API from the driver to set the priorities of the
available masters at run-time.  I'm not awarye any current need of
changing things at run-time, but it seems potentially useful as well.

Based on all this discussion, I'm starting to lean towards the runtime
API approach, but am hoping for some suggestions.

Kevin
