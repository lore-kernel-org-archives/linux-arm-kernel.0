From: bgat@billgatliff.com (Bill Gatliff)
Date: Mon, 15 Mar 2010 11:53:15 -0500
Subject: QUERY: How to handle SOC Configuration (Peripheral Multiplexing)
	in linux
In-Reply-To: <4B9E5A29.1090407@st.com>
References: <4B9DB823.1040809@st.com>	<1b68c6791003142147y200fff12vc805fbd07f1c0ef4@mail.gmail.com>
	<4B9DC239.90407@st.com> <4B9E2D7E.1020702@billgatliff.com>
	<4B9E5A29.1090407@st.com>
Message-ID: <4B9E65FB.1070501@billgatliff.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Armando VISCONTI wrote:
>
> Now you both are saying that compile time options are better, correct?

That's what I'm saying, yes.  Rmk will have to speak for himself. :)

>
> So, we have two choices:
>
> 1. Stay as it is, which means to use menuconfig options.
> 2. Provide board-specific code in the mach-spear directory.
>
> You are suggesting 2, which also seems to be the pin_config stuff
> inside mach-pxa. Am I aligned?

Yes, though the mach-pxa guys aren't the only ones handling pin muxes---
see also at91 and omap2.  There are lots of different ways to set up the
API for this functionality.  I have no idea which one is better, I just
take what I'm given.  :)


>> If you assume that the driver "just knows" what the multiplexer settings
>> need to be, then sooner or later that same peripheral gets used in a
>> different SoC and that assumption has to get tossed out.  That's
>> happening some with the AT91 drivers that can also be used on AVR32
>> chips.  Best to avoid that extra work by putting the platform-specific
>> knowledge where it belongs: in the platform-specific code.
>>   
> Correct.
>
> I think this has never been our intention anyway.
> The drivers shouldn't know anything about platform-specific stuff, as
> they are expected to work across multiple platform.

Keep in mind that to the driver, anything non-driver is
"platform-specific".  For a driver to be truly reusable, then, it can't
assume anything about where its pins are, what interrupt channel it's
tied to, or anything else like that.  All those things are subject to
change as the peripheral gets re-used across SoCs.  Don't let them sneak
into the driver code.

It's true that for a specific SoC, you *do* know such things.  So you
handle that the way the at91 guys have done: you provide a
at91sam9263_devices.c:at91_add_device_usbh(struct at91_usbh_data *data),
and _that_ function sets up pins, etc. before it registers the generic
platform device.  The driver is always a generic platform one, and gets
its information only from ordinary resource specifications.  It can
assume that SoC-specific stuff like pin mux setup, etc. has been taken
care of already--- it's completely platform-agnostic.

Later on, a module can do all the pin mux stuff itself and then register
the "at91_ohci" platform device if for some reason it doesn't like the
way existing code does things.  There's no specific need to modify
kernel code just because you've provided an SoC-specific "wrapper"
around the platform device registration, it's just a convenience
function that you can choose to use, or not.



HTH,


b.g.

-- 
Bill Gatliff
Embedded systems training and consulting
http://billgatliff.com
bgat at billgatliff.com
