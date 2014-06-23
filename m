From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 23 Jun 2014 21:10:41 +0200
Subject: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <CAJ5Y-eZTmwiJViABy4MkioFYrXCoc2ho1AQ2RPThqDaUomvZ4Q@mail.gmail.com>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <4678828.UygJelrJo5@wuerfel>
 <CAJ5Y-eZTmwiJViABy4MkioFYrXCoc2ho1AQ2RPThqDaUomvZ4Q@mail.gmail.com>
Message-ID: <5338610.xCINKmsENX@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 23 June 2014 14:25:26 Ashwin Chaugule wrote:
> Hi Arnd,
> 
> On 21 June 2014 05:34, Arnd Bergmann <arnd@arndb.de> wrote:
> >>
> >> linux/mailbox_client.h
> >>
> >>  18  * struct mbox_client - User of a mailbox
> >>  19  * @dev:        The client device
> >>  20  * @chan_name:      The "controller:channel" this client wants
> 
> Please correct me if I'm mistaken, but I think this comment in the
> header is confusing.

Yes, definitely. Thanks for pointing that out.

> It gives the impression that the user is expected
> to fill in this field as "controller name: channel id". But, looking
> at an example of a DT based mbox client [1] , that doesnt seem to be
> the case. And "chan_name" is compared with "mbox-names", which seems
> to contain a list of Channel names. The mailbox is then identified by
> a separate DT binding : "mbox", which has the mailbox name and the
> channel id. So shouldnt this comment not say anything about the
> "controller" and the DT binding should be changed to "channel-names",
> instead of "mbox-names" to keep things consistent?

The comment should be changed, but the property name is good the
way it is. We follow the exact same pattern we have for registers,
interrupts, dma-channels, etc.

> > However, it seems you still make the same mistake here: The name that
> > gets passed as chan_name in the mailbox API is a local identifier
> > that is supposed to be interpreted for the client device and used
> > to look up a pointer to the mailbox device and channel. If you require
> > drivers to put global data (e.g. the mbox->name, or the channel
> > number) in there, it's impossible to write a driver that works on
> > both DT and ACPI. If you want to use the mbox_request_channel()
> > interface from a driver, you need some form of lookup table in
> > the ACPI data to do the conversion.
> 
> Fair point. The more I think about this, it seems that if we want to
> use the mailbox framework for ACPI kernels, we should have a PCC
> specific bypass, something like the one you suggested below. The ACPI
> spec defines PCC as the only "mailbox" like mechanism. There are 3 PCC
> clients defined as well; CPPC, MPST and RASF. Each of these have their
> own ACPI tables and so they dont require special DSDT entries.

Ok, I see. Can you describe what data is in these tables?

> Moreover, these PCC client drivers will be very ACPI specific anyway.
> So, trying to emulate DT like mbox controller-client matching in ACPI
> at this point is rather pointless. It will require creating dummy DSDT
> entries for the PCC mailbox controller and PCC mailbox clients which
> have their own well defined ACPI tables (and so dont belong in the OS
> agnostic DSDT) and then coming up with customized Device Specific
> Methods (DSMs) for mbox clients to refer to mbox controllers.

Actually you wouldn't necessarily need DSDT entries, the ACPI core could
just call platform_device_create() to instantiate the devices based on
the PCC tables.

> The other alternative is to skip the mailbox framework altogether. One
> thing to note is that the PCC driver and its clients should work on
> X86, ARMv8 and any other platform that has ACPI support. Currently the
> Mailbox framework looks platform agnostic but is tied to DT, so it may
> not work well for everyone. But like I mentioned early on, the
> framework provides for async notification and queuing which is useful
> for PCC, so I'd prefer the PCC specific bypass option.

The mailbox API should still work fine without DT, it would be easy
enough to add a lookup mechanism for architectures that create their
own platform devices from hardcoded kernel structures, or from ACPI
tables that are meant to emulate the DT bindings on embedded x86.

But treating PCC special probably does make most sense here, at
least the lookup path.

> > The alternative would be not to use mbox_request_channel() at all
> > for now, but to add a new interface that can only be used PCC and
> > that matches by ID but is independent of the use of ACPI or DT,
> > something like:
> >
> > struct mbox_chan *pcc_mbox_get_channel(struct mbox_client *cl,
> >                         char *name, unsigned chan_id,
> >                         struct mbox_chan **chan)
> > {
> >         struct mbox_controller *mbox;
> >         mbox = mbox_find_pcc_controller(name, ...);
> >
> >         *chan = &mbox->chans[chan_id];
> >         return init_channel(*chan, cl);
> > }
> >
> > This would mean that we'd have to special-case "pcc" users, which is
> > not very nice, but at least it would work on both DT and ACPI,
> > and a future ACPI version could still add support for the mailbox
> > API later.
> 
> I'll play around with this idea a bit and see how it looks.
> 

Ok, thanks for looking into this.

	Arnd
