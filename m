From: alex.aring@gmail.com (Alexander Aring)
Date: Mon, 2 Nov 2015 10:02:58 +0100
Subject: [RFC] rpi: add support to enable usb power domain
In-Reply-To: <5631A165.3050304@wwwdotorg.org>
References: <1446064810-5064-1-git-send-email-alex.aring@gmail.com>
 <5631A165.3050304@wwwdotorg.org>
Message-ID: <20151102090257.GB1342@omega>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 10:32:37PM -0600, Stephen Warren wrote:
> On 10/28/2015 02:40 PM, Alexander Aring wrote:
> > This patch adds support for RPi several Power Domains and enable support
> > to enable the USB Power Domain when it's not enabled before.
> > 
> > This patch based on Eric Anholt's patch to support Power Domains. He had
> > an issue about -EPROBE_DEFER inside the power domain subsystem, this
> > issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
> > if we fail to init or turn-on domain").
> 
> > diff --git a/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt b/Documentation/devicetree/bindings/arm/bcm/raspberrypi,bcm2835-firmware.txt
> 
> >  firmware {
> >  	compatible = "raspberrypi,bcm2835-firmware";
> >  	mboxes = <&mailbox>;
> > +	#power-domain-cells = <1>;
> > +};
> 
> I would have expected a separate DT node for the power domains driver
> that referenced the firmware node by phandle. I believe that's why the
> firmware node exports mailboxes to other drivers. If the firmware driver
> was going to implement all the features directly, it wouldn't need to
> act as a mailbox provider, since all the mailbox programming would be
> internal.
> 

ok.

> > diff --git a/drivers/firmware/raspberrypi.c b/drivers/firmware/raspberrypi.c
> 
> > +#define RPI_POWER_DOMAIN(_domain, _name)			\
> > +	[_domain] =						\
> > +	{							\
> 
> I'd expect { wrapped onto the previous line.
> 

ok.

> > +static int raspberrypi_firmware_set_power(struct rpi_firmware *fw,
> > +					  u32 domain, bool on)
> 
> > +	packet.on = on;
> > +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_SET_POWER_STATE, &packet,
> > +				    sizeof(packet));
> > +	if (!ret && !packet.on)
> > +		ret = -EINVAL;
> 
> The error is only reported for power off requests?
> 

grab it from old patch. I will fix that, I suppose it should something
like:

if (!ret && packet.on != on)
	ret = -EINVAL;

to confirm if packet.on is set or unset afterwards. I don't know if this
is a valid error reporting mechanism from firmware.

I will drop such checking here.

> > +/* Asks the firmware to if power is on for a specific power domain. */
> > +static int raspberrypi_firmware_power_is_on(struct rpi_firmware *fw,
> > +					    u32 domain)
> 
> > +	packet.domain = domain;
> > +	ret = rpi_firmware_property(fw, RPI_FIRMWARE_GET_POWER_STATE, &packet,
> > +				    sizeof(packet));
> > +	if (ret < 0)
> > +		return ret;
> 
> Hmm. If rpi_firmware_property() returns <0 on error, I'm confused what
> the test I commented on above is intended to do.
> 

yes, I will fix it.

> > +/*
> > + * IMPORTANT: be sure this array has no entries which are not specified
> > + * between others by RPI_POWER_DOMAIN, otherwise mapping between
> > + * generic_pm_domain array doesn't work anymore.
> > + */
> 
> "has no entries which are not specified between others by
> RPI_POWER_DOMAIN" might be better phrased as "is contiguous" or
> "contains only contiguous entries".
> 

Okay, Eric Anholt told me to support the power domains which he had in
his patch only. I would add add the power domains only which has an
use-case -> "USB". 

> > @@ -208,15 +312,44 @@ static int rpi_firmware_probe(struct platform_device *pdev)
> 
> > +	for (i = 0; i < num_domains; i++) {
> > +		bool is_off;
> > +
> > +		rpi_power_domains[i].fw = fw;
> > +		power_domains[i] = &rpi_power_domains[i].base;
> > +
> > +		/* get the initial state */
> > +		ret = raspberrypi_firmware_power_is_on(fw, i);
> > +		if (ret < 0)
> > +			goto mbox;
> 
> The label name "mbox" doesn't give a clue that it's an error handler.
> "free_mbox" might be better.
> 

ok.

> > +mbox:
> > +	mbox_free_channel(fw->chan);
> > +	return ret;
> >  }
> 
> Does the pm_genpd_init() call for all the power domains need to be
> undone at all?

I would say yes. The function will call:

list_add(&genpd->gpd_list_node, &gpd_list);

And gpd_list is a _static_ list inside the generic power domain subsystem.
If probing fails we need to delete these entries from gpd_list again.

I searched the whole file about "gpd_list_node" and can't find a
list_del on it. :-( Seems such handling isn't supported, but I think
"normally" it should be cleanuped then.

- Alex
