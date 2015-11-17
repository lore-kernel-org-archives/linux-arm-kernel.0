From: eric@anholt.net (Eric Anholt)
Date: Tue, 17 Nov 2015 13:46:32 -0800
Subject: [RFC] rpi: add support to enable usb power domain
In-Reply-To: <20151102084557.GA1342@omega>
References: <1446064810-5064-1-git-send-email-alex.aring@gmail.com>
 <87a8r1pkfz.fsf@eliezer.anholt.net> <20151102084557.GA1342@omega>
Message-ID: <8761105mfb.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alexander Aring <alex.aring@gmail.com> writes:

> Hi,
>
> On Thu, Oct 29, 2015 at 12:02:24PM -0700, Eric Anholt wrote:
>> Alexander Aring <alex.aring@gmail.com> writes:
>> 
>> > This patch adds support for RPi several Power Domains and enable support
>> > to enable the USB Power Domain when it's not enabled before.
>> >
>> > This patch based on Eric Anholt's patch to support Power Domains. He had
>> > an issue about -EPROBE_DEFER inside the power domain subsystem, this
>> > issue was solved by commit <311fa6a> ("PM / Domains: Return -EPROBE_DEFER
>> > if we fail to init or turn-on domain").
>> >
>> > It was tested with barebox and the following scripts before booting
> ...
>> > Third:
>> > The barebox regulator doesn't support right now to enable/disable
>> > regulators at runtime but I want to bring this mainline in the next
>> > days. So you can't check yourself if the above scripts working right
>> > now. I describe it here to show you what exactly I tested.
>> >
>> > changes since Eric Anholts "power domain" patch:
>> >  - add for me all known power domains of the RPi, it contains the domains
>> >    0 - 9.
>> 
>> Note: None of the power domain enums other than the ones I'd had in my
>> patch are actually connected to anything in the firmware.  I don't think
>> we should be adding them, given that.
>
> Okay. Then it makes sense that I still accessing UART and SDHC when I
> turn off the power.
>
> In you patch you had SDHC, USB, DSI. Are you sure that SDHC power domain
> has any effect, because I don't see any effect and can still access the
> sd card.

It looks like the SDCARD domain is kept always on, even if we ask for it
off.  We can clear the always-on flag by setting domain 29 in
MBOX_CHAN_POWER.  It's not accessible from the property channel, unless
I've misread the logic.

Yet another reason I'm hoping to write a native power domain driver.

> I would add the power-domains where we have currently an use-case for it
> and this USB at the moment. Is this okay for you?

Sounds good to me.  I'll probably extend that for V3D.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151117/1e23e8ec/attachment.sig>
