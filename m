From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 May 2014 18:42:37 +0200
Subject: [RFC] ARM: vt8500: cleanup start
In-Reply-To: <CAJ3iQco9qu8Z7Gm0AtcvV3OPc6C39Hdqjq6tVKMYy5qV2=ASwA@mail.gmail.com>
References: <CAJ3iQco9qu8Z7Gm0AtcvV3OPc6C39Hdqjq6tVKMYy5qV2=ASwA@mail.gmail.com>
Message-ID: <5016910.Qn6QdqhQ4L@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 24 May 2014 00:10:58 Gergely Imreh wrote:
> Hi,
> 
> This is my first post on the list. I'm preparing to contribute to the
> Kernel some of
> the current SoCs and boards from VIA Embedded.
> 
> That being a big task (understatement), I'm just starting off with a
> checking existing
> things out around the vt8500 areas, and other SoCs to learn the style.

Ah, very nice.

> The style of march-v8500 is not quite like the ones I've seen in e.g.
> Thomas Petazzoni
> & Free Electrons' (very cool) guides, and started off with updating
> things according
> to that a bit. I'm just not sure whether this warrant any patches on
> their own, hence the
> Request for Comments.
> 
> The changes I've made (breaking out the #define sections into a
> header, and doing
> explicit typecast for the vt8500 map_desc) are in this repo with via-header tag.

Using a separate header file is only useful if the header is shared between
multiple .c files, which is not the case here.

The explicit typecast in other board files is used because VT8500_REGS_VIRT_BASE
is supposed to be of type 'void __iomem *', which is isn't here.

> https://github.com/viaembedded/arm-soc/tree/via-header
> 
> Should this be part of a larger patchset later on, or is it okay just
> to send any time like
> this? Are these changes worth doing if the functionality itself did
> not really change,
> just probably the style improves?

I think a good start would be to split out the reset code into a
proper device driver. The register used for reset is part of the
"pmc" device that is used in the clock driver, so you can
add a reboot/poweroff handler there and register it with arm_pm_restart/
pm_power_off.

It would be nice to also move the VT8500_GPIO_MUX_REG handling out
of the mach-* code into drivers/pinctrl/vt8500/, but there may be
a good reason why it isn't already done that way.

For anything you do, please coordinate with Tony Prisk, who is
maintaining the platform.

	Arnd
