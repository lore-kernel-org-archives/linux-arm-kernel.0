From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Fri, 20 Jun 2014 17:43:05 -0400
Subject: [Linaro-acpi] [RFC v2 1/3] Mailbox: Add support for ACPI
In-Reply-To: <4600246.SKVsl5kA9F@wuerfel>
References: <1402591692-7736-1-git-send-email-ashwin.chaugule@linaro.org>
 <5207109.Ir8j6FZuiX@wuerfel>
 <CAJ5Y-eYd_dyhzOdnxsi96mGN6dqihN_5rw83FsFwauZzUVz9YA@mail.gmail.com>
 <4600246.SKVsl5kA9F@wuerfel>
Message-ID: <CAJ5Y-eYN6NfFdKAkv5yrHTdeRNWJfvgPVL61EjZdgN0DYP8zpA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 20 June 2014 16:49, Arnd Bergmann <arnd@arndb.de> wrote:
> On Friday 20 June 2014 15:29:18 Ashwin Chaugule wrote:
>>
>> On 20 June 2014 15:08, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Friday 20 June 2014 14:55:16 Ashwin Chaugule wrote:
>> >> So, in order to get an mbox->dev for ACPI platforms, we'd need an
>> >> entry in the DSDT table. That seems rather pointless, since the DSDT
>> >> is reserved for devices and is supposed to be OS agnostic. Since the
>> >> mailbox controller itself is not really a "device" with a resource
>> >> descriptor, I dont see the point in adding a dummy DSDT entry for the
>> >> sake of getting this `struct device`. Also, I'm told adding new
>> >> entries to this table requires registering a unique 4 character
>> >> identifier and approval from some committees. If there are other ways
>> >> to get this structure I'd like to hear about it.
>> >>
>> >> The other alternative would be to piggy back on the ACPI CPU detection
>> >> code, which looks for the ACPI0007 device node in the DSDT and use
>> >> that as the mbox controller device. This node is already registered
>> >> and is an established method to detect CPUs. But I'm not sure what
>> >> happens when CPUs are hotplugged off, we surely dont want mailbox
>> >> clients such as PCC to break.
>> >
>> > The main question here is whether you expect having to support multiple
>> > mailbox devices in an ACPI system. If you think there is never more than
>> > one, you wouldn't need a DSDT entry, but if you can end up in a situation
>> > where another device needs to specify which mailbox it is using, then
>> > you need that entry anyway.
>>
>> At this point, I dont see the need for multiple mailbox devices. But
>> I'm not seeing why we'd need a DSDT entry only if there are more than
>> one mailbox devices? I'd obviously prefer not having a DSDT entry for
>> this, and the patch I posted is the only way I could see to keep DT
>> and ACPI mbox supported at runtime without DSDT involved. Please let
>> me know if there are better ways.
>
> It's mostly a matter of consistency: We can have multiple interrupt
> controllers, pin controllers, clock controllers, dma engines, etc,
> and in the DT case we use references to the nodes wherever we have
> other devices referring to a mailbox name.
>
> I believe Intel's embedded chips are moving in the same direction
> with their ACPI support. If the ACPI spec gains support for mailbox
> devices, locking them into having only a single device may be
> a problem later for them.
>
> Note that "device" here doesn't have to mean a platform device that
> is instantiated from DSDT, it can be any mailbox provider that is
> registered in an arbitrary way, as long as you have a method to map
> back from the (consumer-device, name-string) tuple back to the
> (provider, channel) tuple. I have read your patch again now and noticed
> that you actually tried to do this, but unfortunately you got it
> wrong by requiring the consumer to fill out the name of the provider
> in the request. You can't do that, because it's not generic enough
> to support devices that can be reused, and it means that drivers
> using the API are never portable between DT and ACPI. You have to
> get rid of the "ctrl_name" field in the mbox_client structure and
> change the lookup to be based only on cd->dev and cl->chan_name,
> using whatever tables you have available in ACPI.

I think you looked at the previous version of the patch. I'm attaching
the latest version here again FWIW. In this version, I removed the
"ctrl_name" field and rely on the cl->chan_name to provide the info as
described in Jassi' original patch.


linux/mailbox_client.h

 18  * struct mbox_client - User of a mailbox
 19  * @dev:        The client device
 20  * @chan_name:      The "controller:channel" this client wants

Instead of dev, I added a name string to the mbox controller
structure. So now the client gets its channel by requesting
"controller:channel" where controller should match with mbox->name and
channel becomes an index into mbox->chans[].


Cheers,
Ashwin
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-Mailbox-Add-support-for-ACPI.patch
Type: text/x-patch
Size: 8409 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140620/5a4ff595/attachment.bin>
