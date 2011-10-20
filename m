From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Thu, 20 Oct 2011 09:33:29 +0100
Subject: [PATCH 2/3] ARM: AT91: IIO: Add AT91 ADC driver.
In-Reply-To: <20111020090532.7df7af70@skate>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1319041134-19712-3-git-send-email-maxime.ripard@free-electrons.com>
	<4E9EFE0B.2030205@cam.ac.uk> <4E9F15B6.90506@free-electrons.com>
	<20111020090532.7df7af70@skate>
Message-ID: <4E9FDCD9.7030202@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bringing in Mark and Linus as others who have been active in talking about
similar issues.
> Hello,
> 
> Le Wed, 19 Oct 2011 20:23:50 +0200,
> Maxime Ripard <maxime.ripard@free-electrons.com> a ?crit :
> 
>> On 19/10/2011 18:42, Jonathan Cameron wrote:
>>> Afraid I'm out of time for today, but just thought I'd ask one quick question...
>>>
>>> Why isn't this touchscreen ADC in input?
>>
>> Because what I say in the Kconfig is mostly wrong... Sorry about that.
>>
>> Actually, like I was saying, this ADC is present in a lot of AT91 SoC,
>> and while it is always an ADC, sometimes (like on the G45), it can be
>> used as a touchscreen controller, or even as both, with channels for the
>> touchscreen and channels as ADC. On the G20 however, it is just an ADC.
>>
>> For now, the plan is only to support the ADC mode, so I put it in adc.
> 
> Just to expand a bit on this: there is already in the kernel an input
> driver for the AT91 touchscreen which uses some ADC channels (that have
> additional touchscreen-related features: on the G45, you have 8 ADCs
> channels, 4 can optionally be used for touchscreen, the 4 other are
> just raw ADCs).
> 
> The ultimate goal is of course to make it possible to use both the IIO
> AT91 ADC driver and the AT91 touchscreen driver work simultaneously
> (with of course non-conflicting ADC channels usage). However, as shown
> by recent discussions on this list, it is not yet entirely clearly how
> this should be done:
> 
>  * Should we have some low-level ADC driver in arch/arm/mach-at91/ that
>    allows to request/release/access the ADC channels, this driver
>    providing an internal kernel API used by the IIO ADC driver and the
>    touchscreen driver ?
That's definitely not going to go down well against moves to move everything
that looks like a driver out of the arch directories. An equivalent somewhere
else might work though.
> 
>            sysfs access                  /dev/input/...
>            to ADC channels               access to touchscreen
>                 ||                              ||
>                 \/                              \/
>         +------------------+            +------------------+
>         |     AT91 IIO     |            | AT91 touchscreen |
>         +------------------+            +------------------+
>                  |                               |
>                  \_______________________________/
>                                  |
>                         +---------------------+
>                         | Some low-level ADC  |
>                         | code to request,    |
>                         | release and access  |
>                         | ADC channels        |
>                         +---------------------+
> 
>  * Should IIO provide some internal kernel API (as you suggested some
>    time ago) so that kernel drivers can use ADC channels ?
> 
> 
>             +-------------------+
>             | AT91 touchscreen  | -> /dev/input/... access to touchscreen
>             +-------------------+
>                      ||
>                      \/
>             +-------------------+
>             |   AT91 IIO        | -> sysfs access to ADC channels
>             +-------------------+
> 
> Regards,
> 
> Thomas
Agreed.  This is currently up in the air. The current state of those IIO
hooks is that they do pull only.  Push based capture is tricky as for IIO
we want to control the triggering of the push at a far finer scale than
makes sense for input. I'm not yet clear how these two will play together.

If we sit something underneath the IIO and input drivers (or use the lower
portions of IIO to do this) then the intent would be to have a fully generic
input touchscreen driver on top.  I'm not sure that's possible. For
example are the switches on the G45's adc (from datasheet) something that
all/many similar touch screen controllers have?
I suppose we could support these in the chan_spec but only if it helps
us to write a generic touch screen driver on top.  I have no real
feeling for whether this would be possible...
(all my boards are headless ;)

Jonathan
