From: khilman@baylibre.com (Kevin Hilman)
Date: Mon, 24 Oct 2016 11:52:39 -0700
Subject: [RFC] ARM: memory: da8xx-ddrctl: new driver
In-Reply-To: <7hfunly4hn.fsf@baylibre.com>
References: <1477327596-16060-1-git-send-email-bgolaszewski@baylibre.com>
 <1477327596-16060-2-git-send-email-bgolaszewski@baylibre.com>
 <20161024170035.GO15620@leverpostej> <7hd1ipzm3h.fsf@baylibre.com>
 <20161024174249.GQ15620@leverpostej> <7hfunly4hn.fsf@baylibre.com>
Message-ID: <CAOi56cXePjssk0AzMz27A_dOdLdJCWGMc86DH9nih5SHe-Eo=g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 24, 2016 at 11:41 AM, Kevin Hilman <khilman@baylibre.com> wrote:
> Mark Rutland <mark.rutland@arm.com> writes:
>
>> On Mon, Oct 24, 2016 at 10:35:30AM -0700, Kevin Hilman wrote:
>>> Hi Mark,
>>>
>>> Mark Rutland <mark.rutland@arm.com> writes:
>>> > On Mon, Oct 24, 2016 at 06:46:36PM +0200, Bartosz Golaszewski wrote:
>>> >> +static int da8xx_ddrctl_probe(struct platform_device *pdev)
>>> >> +{
>>> >> + const struct da8xx_ddrctl_config_knob *knob;
>>> >> + const struct da8xx_ddrctl_setting *setting;
>>> >> + u32 regprop[2], base, memsize, reg;
>>> >> + struct device_node *node, *parent;
>>> >> + void __iomem *ddrctl;
>>> >> + const char *board;
>>> >> + struct device *dev;
>>> >> + int ret;
>>> >> +
>>> >> + dev = &pdev->dev;
>>> >> + node = dev->of_node;
>>> >> +
>>> >> + /* Find the board name. */
>>> >> + for (parent = node;
>>> >> +      !of_node_is_root(parent);
>>> >> +      parent = of_get_parent(parent));
>>> >> +
>>> >> + ret = of_property_read_string(parent, "compatible", &board);
>>> >> + if (ret) {
>>> >> +         dev_err(dev, "unable to read the soc model\n");
>>> >> +         return ret;
>>> >> + }
>>> >
>>> > I can see that you want to expose sysfs knobs for this, but is it really
>>> > necessary to match boards like this? It's very fragile, and commits us
>>> > to maintaining a database of board data (i.e. a board file).
>>> >
>>> > I am very much not keen on that.
>>>
>>> The original proposal[1] was to create DT properties reflecting the
>>> various knobs in the DDR Controller, but that was frowned upon since
>>> that was more HW configuration than hardware description.
>>>
>>> That resulted in this approach which keeps the HW configuration values
>>> in the driver, and selectable based on DT compatible.
>>>
>>> IMO, neither aproach is pretty.  From a DT maintainer perspective, can
>>> you comment on your preference?
>>
>> From my PoV, it really depends on *why* we need this. What does the
>> tuning gain us, and is it specific to a given use-case?
>
> This is essentially a bus controller which allows you to set relative
> priorities of the various bus masters (CPU data, CPU instructions, DMA
> channels, ethernet MAC, SATA, display controller, etc. etc.)

Scratch that... I got this one confused with a different drivers/bus
driver Bartosz is also working on. :(

This one is just for the mechanism that controls how long old
(low-priority) xfers in the DDR command FIFO are allowed to sit around
before they will be flushed.

The use-case is the same though.  The display controller doesn't work
at higher resolutions without tweaking this setting.

The question remains though: as a system-wide setting, should this be
configured via DT (either by a DT property, or based on a compatible
string in the driver) or should the driver provide an API to tweak it.

Kevin
