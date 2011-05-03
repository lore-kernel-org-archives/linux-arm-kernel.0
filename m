From: bn@niasdigital.com (Ben Nizette)
Date: Tue, 3 May 2011 11:45:21 +1000
Subject: [PATCH 1/4] drivers: create a pinmux subsystem
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0497F1B201@HQMAIL01.nvidia.com>
References: <1304363786-30376-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF0497F1B201@HQMAIL01.nvidia.com>
Message-ID: <D43C969C-DB05-4778-AB2B-824EB9A3CF7D@niasdigital.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 03/05/2011, at 6:52 AM, Stephen Warren wrote:

> Linus Walleij wrote at Monday, May 02, 2011 1:16 PM:
>> From: Linus Walleij <linus.walleij@linaro.org>
>> 
>> This creates a subsystem for handling of pinmux devices. These are
>> devices that enable and disable groups of pins on primarily PGA and
>> BGA type of chip packages and common in embedded systems.
> 
> I would avoid any references to particular package types; I've seen
> pinmuxing applied to PLCC and DIP/DIL too, and in general, it's possible
> irrespective of package type.
> 
>> This is being done to depopulate the arch/arm/* directory of such
>> custom drivers and try to abstract the infrastructure they all
>> need. See the Documentation/pinmux.txt file that is part of this
>> patch for more details.
> 
>> diff --git a/Documentation/pinmux.txt b/Documentation/pinmux.txt
>> ...
>> +The mux settings are:
>> +
>> +- Oriented around enumerated physical pins or pads denoted by unsigned
>> +  integers in the range 0..MAX_INT. Every pin on your system (or atleast
>> +  every pin that can be muxed) should have a unique number. The numberspace
> 
> Does this imply a model where each pin's "special function" can be
> controlled independently? I think reading through the document that
> isn't the case, but I just wanted to be sure.

The relevant driver can /request/ each special function independently but if
the pinmux driver can't implement it for whatever reason, including being
batshit-crazy like Tegra, it can just return an error.  It's still up to the
board designer to ensure the requested setup is physically possible.

> 
> In particular, NVIDIA Tegra has a setup where:
> 
> * Pinmux configuration for "special functions" is at a "pad-group"
> level, where there may be 1..N pins in a pad-group, and there is a
> single register field that defines the current special function routed
> to/from all pins in that pad-group at once.
> 
> * Each pad group can be assigned 1 of N special functions (none might be
> an option in some/all cases too)
> 
> * Some special functions may be assignable to multiple pad groups,
> although obviously only 1 pad group per function at a time.

To me that all looks like it can be encapsulated by this interface

> 
> * GPIO selection is at per-pin granularity; individual pins may be used
> as a GPIO irrespective of what SFR is selected for the pad group
> containing the pin.
> 
> * There are also other configurations associated with pinmuxing, such
> as drive strength, pull up/down enables, etc.

This pin configuration stuff should be bunted to gpiolib gpio_config()
callbacks which Linus implemented last week.

> 
> Also, some of our drivers use "dynamic pinmuxing". For example, our
> downstream I2C driver exposes N I2C busses and reprograms the pinmux
> at runtime to attach the actual I2C controller to different sets of
> pins, essentially multi-plexing the control across N physical busses.

Neat!  Should be a perfect use-case for this pinmux subsystem.  Perhaps,
if you've got time, you could try and implement a pinmux driver for your
chip and make sure all bases are covered?  Nothing like taking a madhouse
chip and actually trying to code for it to shake down a new interface like
this one :)

	--Ben.
