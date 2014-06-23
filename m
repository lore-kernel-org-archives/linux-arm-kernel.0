From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Mon, 23 Jun 2014 15:46:08 -0400
Subject: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <5338610.xCINKmsENX@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <4678828.UygJelrJo5@wuerfel>
 <CAJ5Y-eZTmwiJViABy4MkioFYrXCoc2ho1AQ2RPThqDaUomvZ4Q@mail.gmail.com>
 <5338610.xCINKmsENX@wuerfel>
Message-ID: <CAJ5Y-eaA6vPvhbfMjys8PeSC7B+=ZLLBYh4Wi79Nh9=pwB3+sg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 23 June 2014 15:10, Arnd Bergmann <arnd@arndb.de> wrote:
>> Fair point. The more I think about this, it seems that if we want to
>> use the mailbox framework for ACPI kernels, we should have a PCC
>> specific bypass, something like the one you suggested below. The ACPI
>> spec defines PCC as the only "mailbox" like mechanism. There are 3 PCC
>> clients defined as well; CPPC, MPST and RASF. Each of these have their
>> own ACPI tables and so they dont require special DSDT entries.
>
> Ok, I see. Can you describe what data is in these tables?

For CPPC, its a field for version number, number of entries and then
followed by a bunch of PCC entries that have the following structure:

 51 struct pcc_register_resource {
 52     u8 descriptor;
 53     u16 length;
 54     u8 space_id;
 55     u8 bit_width;
 56     u8 bit_offset;
 57     u8 access_size;
 58     u64 address;
 59 } __attribute__ ((packed));

These essentially describe the PCC register space to be used by the
respective protocol. e.g. CPPC uses these to exchange CPU performance
metrics between the OS and the firmware.
I believe MPST and RASF also follow the same format.

>
>> Moreover, these PCC client drivers will be very ACPI specific anyway.
>> So, trying to emulate DT like mbox controller-client matching in ACPI
>> at this point is rather pointless. It will require creating dummy DSDT
>> entries for the PCC mailbox controller and PCC mailbox clients which
>> have their own well defined ACPI tables (and so dont belong in the OS
>> agnostic DSDT) and then coming up with customized Device Specific
>> Methods (DSMs) for mbox clients to refer to mbox controllers.
>
> Actually you wouldn't necessarily need DSDT entries, the ACPI core could
> just call platform_device_create() to instantiate the devices based on
> the PCC tables.
>
>> The other alternative is to skip the mailbox framework altogether. One
>> thing to note is that the PCC driver and its clients should work on
>> X86, ARMv8 and any other platform that has ACPI support. Currently the
>> Mailbox framework looks platform agnostic but is tied to DT, so it may
>> not work well for everyone. But like I mentioned early on, the
>> framework provides for async notification and queuing which is useful
>> for PCC, so I'd prefer the PCC specific bypass option.
>
> The mailbox API should still work fine without DT, it would be easy
> enough to add a lookup mechanism for architectures that create their
> own platform devices from hardcoded kernel structures, or from ACPI
> tables that are meant to emulate the DT bindings on embedded x86.

Right, a generic lookup method would be useful. I think we should
probably revisit this option when/if there are ACPI cases which use
anything other than the PCC mailbox controller.

>
> But treating PCC special probably does make most sense here, at
> least the lookup path.

Agreed.

>
>> > The alternative would be not to use mbox_request_channel() at all
>> > for now, but to add a new interface that can only be used PCC and
>> > that matches by ID but is independent of the use of ACPI or DT,
>> > something like:
>> >
>> > struct mbox_chan *pcc_mbox_get_channel(struct mbox_client *cl,
>> >                         char *name, unsigned chan_id,
>> >                         struct mbox_chan **chan)
>> > {
>> >         struct mbox_controller *mbox;
>> >         mbox = mbox_find_pcc_controller(name, ...);
>> >
>> >         *chan = &mbox->chans[chan_id];
>> >         return init_channel(*chan, cl);
>> > }
>> >
>> > This would mean that we'd have to special-case "pcc" users, which is
>> > not very nice, but at least it would work on both DT and ACPI,
>> > and a future ACPI version could still add support for the mailbox
>> > API later.
>>
>> I'll play around with this idea a bit and see how it looks.
>>
>
> Ok, thanks for looking into this.

Cheers,
Ashwin
