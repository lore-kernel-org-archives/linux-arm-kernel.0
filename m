From: nm@ti.com (Menon, Nishanth)
Date: Thu, 7 Oct 2010 17:03:20 -0500
Subject: [PATCH] power: introduce library for device-specific OPPs
In-Reply-To: <201010072354.57011.rjw@sisk.pl>
References: <1286357180-21565-1-git-send-email-nm@ti.com>
	<201010072354.57011.rjw@sisk.pl>
Message-ID: <7A436F7769CA33409C6B44B358BFFF0C014F748B07@dlee02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Rafael J. Wysocki [mailto:rjw at sisk.pl]
> Sent: Thursday, October 07, 2010 4:55 PM


> 
> Hi,
> 
> On Wednesday, October 06, 2010, Nishanth Menon wrote:
> > SoCs have a standard set of tuples consisting of frequency and
> > voltage pairs that the device will support per voltage domain. These
> > are called Operating Performance Points or OPPs. The actual
> > definitions of OPP varies over silicon versions. For a specific domain,
> > we can have a set of {frequency, voltage} pairs. As the kernel boots
> > and more information is available, a default set of these are activated
> > based on the precise nature of device. Further on operation, based on
> > conditions prevailing in the system (such as temperature), some OPP
> > availability may be temporarily controlled by the SoC frameworks.
> >
> > To implement an OPP, some sort of power management support is necessary
> > hence this library depends on CONFIG_PM.
> 
> The patch generally looks good to me, I only have a couple of cosmetic
Thanks for the great reviews.. It did bump up the resultant patch.

> remarks
> (below).
> 
> ...
> > +static int opp_set_availability(struct device *dev, unsigned long freq,
> > +		bool availability_req)
> > +{
> > +	struct device_opp *tmp_dev_opp, *dev_opp = NULL;
> > +	struct opp *new_opp, *tmp_opp, *opp = ERR_PTR(-ENODEV);
> > +	int r = 0;
> > +
> > +	/* keep the node allocated */
> > +	new_opp = kmalloc(sizeof(struct opp), GFP_KERNEL);
> > +	if (!new_opp) {
> > +		pr_warning("Unable to allocate opp\n");
> 
> Please add an identification string to the messages, something like
> "OPP: Unable to allocat object\n" (and similarly in the other messages).
> That would help to find the source of a message in case there's any
> problem.

pr_fmt has been reformatted for this. The actual message which will appear
is as follows:
opp_set_availability: Unable to allocate opp

is'nt that good enough considering that all functions are opp_ prefixed? 
I can modify pr_fmt to add "OPP:" but I kinda think it is redundant. But I
have no strong opinions on that and look forward to your recommendations.

> 
> 
> > +		return -ENOMEM;
> > +	}
> > +
> > +	mutex_lock(&dev_opp_list_lock);
> > +
> > +	/* Find the device_opp */
> > +	list_for_each_entry(tmp_dev_opp, &dev_opp_list, node) {
> > +		if (dev == tmp_dev_opp->dev) {
> > +			dev_opp = tmp_dev_opp;
> > +			break;
> > +		}
> > +	}
> > +	if (IS_ERR(dev_opp)) {
> > +		r = PTR_ERR(dev_opp);
> > +		pr_warning("Unable to find device\n");
> > +		goto out1;
> 
> I'd prefer this lable to be called "unlock".  It will be a bit more
> informative.
Ack. Fixing in v6 if you are ok with the above.

Regards,
Nishanth Menon
