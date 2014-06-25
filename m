From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 25 Jun 2014 17:08:06 +0200
Subject: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <53A9BB9E.7050707@linaro.org>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <17846485.GZEaSd7XIs@wuerfel> <53A9BB9E.7050707@linaro.org>
Message-ID: <6663855.4TI1cqqRkF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 24 June 2014 13:55:42 Ashwin Chaugule wrote:
> 
> Hi Arnd,
> 
> On 06/24/2014 10:18 AM, Arnd Bergmann wrote:
> 
> >
> > I think a model that's closer to the mailbox subsystem would imply
> > that the common mailbox code (or the pcc driver itself) parses the
> > PCCT table, while the slave driver only passes an index.
> 
> This is pretty close to what I have here:
> 
> The PCC mailbox version:
> 
> https://git.linaro.org/people/ashwin.chaugule/leg-kernel.git/shortlog/refs/heads/mbox-pcc-review
> 
> 
> Here the pcc driver in /drivers/acpi/pcc.c is the PCC mailbox controller 
> which parses the PCCT and /drivers/acpi/pcc-test.c is a sample PCC 
> client that sends dummy PCC reads/writes.
> 
> 
> The PCC + CPPC non-mailbox version:
> 
> https://git.linaro.org/people/ashwin.chaugule/leg-kernel.git/shortlog/refs/heads/pcc-cppc-dev
> 
> Here, the CPPC is the PCC client driver which parses the CPC tables. The 
> mailbox conversion for this stuff is a WIP. But it should give an idea 
> of how PCC and PCC clients would work.

Ok, but unfortunately it seems that there is no way for the CPPC to tell
the PCC driver to pull the index out of the CPPC tables as far as I can
tell.

> > Or even better, the slave driver would only pass a device pointer,
> > from which the pcc driver can find the pcc_register_resource in
> > the corresponding ACPI table. The name of that table can be the
> > string you pass down to the mailbox API. I suspect there is some
> > issue that makes this all break down though, but that would be
> > a portable way to do this for both DT and ACPI:
> >
> > If we wanted to use DT with the same driver, we would put the
> > name of the table containing pcc_register_resource into the
> > mbox-names property, and that could get used to look up a
> > reference to the pcc device, and to the other data that you
> > have in pcc_register_resource and PCCT.
> 
> So I dont think we should worry about the PCC clients being used in the 
> DT case, since the PCC and its client specification is very ACPI centric 
> and platforms that want to use these drivers will need an ACPI based 
> firmware anyway. Which is why I think having a separate PCC specific 
> mbox API makes sense.

I think we should be prepared to add any feature that exists in ACPI
also for DT if the need arises, even if we don't expect it to be
necessary.

There are a number of reasons why you might want to use the drivers
with DT, e.g. board bringup (before firmware is available), or to use
some features of a SoC that cannot be represented in ACPI but that
may be useful for a special-purpose appliance.

> Something like what you suggested should work well for ACPI based platforms.
> 
> struct mbox_controller *
> mbox_find_pcc_controller(char *name)
> {
> 	list_for_each_entry(mbox, &mbox_cons, node) {
> 		if (mbox->name)
> 			if (!strncmp(mbox->name, name))
> 				return mbox;
> 	}
> 
> 	return -ENODEV;
> }
> 
> int pcc_mbox_get_channel(struct mbox_client *cl,
> 		char *name, unsigned chan_id,
> 		struct mbox_chan **chan)
> {
> 	struct mbox_controller *mbox;
> 	mbox = mbox_find_pcc_controller(name);
> 
> 	if (!mbox) {
> 		pr_err("PCC mbox %s not found.\n", name);
> 		return -ENODEV;
> 	}
> 
> 	*chan = &mbox->chans[chan_id];
> 	return init_channel(*chan, cl);
> }

Yes, that seems fine, and it will just work with DT as well
if we need that.

	Arnd
