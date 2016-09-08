From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Wed, 07 Sep 2016 18:54:43 -0700
Subject: [PATCH v4 03/22] usb: ulpi: Support device discovery via DT
In-Reply-To: <CAL_JsqJbk2TGmASK974hO0n+Y3DmB3tbggbd9wXCNa9Ug9QdDg@mail.gmail.com>
References: <20160907213519.27340-1-stephen.boyd@linaro.org>
 <20160907213519.27340-4-stephen.boyd@linaro.org>
 <CAL_JsqJbk2TGmASK974hO0n+Y3DmB3tbggbd9wXCNa9Ug9QdDg@mail.gmail.com>
Message-ID: <147329968397.3646.12327973042398769279@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Rob Herring (2016-09-07 18:12:32)
> On Wed, Sep 7, 2016 at 4:35 PM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
> > ---
> >  Documentation/devicetree/bindings/usb/ulpi.txt | 20 +++++++
> >  drivers/usb/common/ulpi.c                      | 77 ++++++++++++++++++++++++--
> >  2 files changed, 92 insertions(+), 5 deletions(-)
> >  create mode 100644 Documentation/devicetree/bindings/usb/ulpi.txt
> 
> Acked-by: Rob Herring <robh@kernel.org>
> 
> But one concern below.
> 
> > -static int ulpi_register(struct device *dev, struct ulpi *ulpi)
> > +static int ulpi_of_register(struct ulpi *ulpi)
> > +{
> > +       struct device_node *np = NULL, *child;
> > +
> > +       /* Find a ulpi bus underneath the parent or the parent of the parent */
> 
> parent of the parent is called the grandparent.

Heh, I can reword it.

> 
> > +       if (ulpi->dev.parent->of_node)
> > +               np = of_find_node_by_name(ulpi->dev.parent->of_node, "ulpi");
> > +       else if (ulpi->dev.parent->parent && ulpi->dev.parent->parent->of_node)
> > +               np = of_find_node_by_name(ulpi->dev.parent->parent->of_node,
> 
> First setting "parent = ulpi->dev.parent" would make this a bit easier
> on the eyes.

Ok.

> 
> When is it valid to be the grandparent? The binding doesn't mention that.

This case arises when we're registering the ulpi device as a child of
the device created by chipidea usb glue drivers (the "core" chipidea
device called something like ci_hdrc.N). In that case we have DT like
this:

	usb-controller {
		ulpi {
			phy {
			};
		};
	};

where the usb-controller node corresponds to a device that's probed by
the glue driver. That glue driver creates a child platform device,
ci_hdrc.0, that doesn't have any DT node associated with it, and then
that device driver probes and creates the ulpi device that is associated
with the phy node.

The grandparent scenario will fall away once Peter's patch is merged to
set the of_node of ci_hdrc.0 to be the same of_node as the glue
device[1]. I can rebase on that patch, but it looked like the power
sequence stuff was getting held up.

Honestly, having the child device registered by the glue driver seems to
cause some difficulties and I've been thinking about how we could get
rid of it, but Peter seems fairly adamant about keeping this design.
Also, I think dwc3 is done in a similar way, but in that case the child
device is in DT and I think we could put the ulpi node inside of it. I
haven't looked in too much detail though.

[1] http://lkml.kernel.org/r/1471252398-957-6-git-send-email-peter.chen at nxp.com
