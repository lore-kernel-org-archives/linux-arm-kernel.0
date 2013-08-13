From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 13 Aug 2013 17:26:40 -0400
Subject: [PATCH v2 4/5] PCI: mvebu: add support for reset on GPIO
In-Reply-To: <20130813222943.46fdacff@skate>
References: <1376396724-32048-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <1376396724-32048-5-git-send-email-sebastian.hesselbarth@gmail.com>
 <20130813222943.46fdacff@skate>
Message-ID: <20130813212640.GK25111@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 13, 2013 at 10:29:43PM +0200, Thomas Petazzoni wrote:
> Dear Sebastian Hesselbarth,
> 
> On Tue, 13 Aug 2013 14:25:23 +0200, Sebastian Hesselbarth wrote:
> 
> > +		port->reset_gpio = of_get_named_gpio_flags(child,
> > +						   "reset-gpios", 0, &flags);
> > +		if (gpio_is_valid(port->reset_gpio)) {
> > +			u32 reset_udelay = 20000;
> > +
> > +			port->reset_active_low = flags & OF_GPIO_ACTIVE_LOW;
> > +			port->reset_name = kasprintf(GFP_KERNEL,
> > +				     "pcie%d.%d-reset", port->port, port->lane);
> > +			of_property_read_u32(child, "reset-delay-us",
> > +					     &reset_udelay);
> > +
> > +			ret = devm_gpio_request_one(&pdev->dev,
> > +			    port->reset_gpio, GPIOF_DIR_OUT, port->reset_name);
> > +			if (ret) {
> > +				if (ret == -EPROBE_DEFER)
> > +					return ret;
> > +				continue;
> > +			}
> > +
> > +			gpio_set_value(port->reset_gpio,
> > +				       (port->reset_active_low) ? 1 : 0);
> > +			udelay(reset_udelay);
> > +		}
> 
> Sorry for raising this only now, but I think I would have preferred to
> see this reset-gpios handling be moved into a separate sub-function.
> The loop initializing each PCIe interface is already quite large, and I
> believe moving this reset-gpios thing to a sub-function would have made
> sense.
> 
> But well, the patches have been applied, and we can always adjust this
> with a followup patch.

The branch this is in will be the last PR, so if the patch is reworked
by tomorrow, I'll just replace it.

> Jason, have you re-created your for-next branch with all those patches?
> I'd like to give them a test if possible.

Yep.  Give it a go.

thx,

Jason.
