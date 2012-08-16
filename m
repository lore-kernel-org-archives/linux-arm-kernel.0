From: matt@genesi-usa.com (Matt Sealey)
Date: Thu, 16 Aug 2012 12:39:09 -0500
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120816034506.GI2258@S2101-09.ap.freescale.net>
References: <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120815153107.GG2258@S2101-09.ap.freescale.net>
 <CAKGA1bkNEJbQgwcdZs8PozCgVyOfUE=bDCGkRkKV3VMfbvRMgw@mail.gmail.com>
 <20120816034506.GI2258@S2101-09.ap.freescale.net>
Message-ID: <CAKGA1bncgxP9WX=1K4wOC6ixyjwqLg4-FkUFTOaGgkW5+OOciw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 15, 2012 at 10:45 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Wed, Aug 15, 2012 at 11:49:01AM -0500, Matt Sealey wrote:
>> > Rather than betting how DTC will implement macro, we'd better make the
>> > the safest assumption - it will not support that syntax.
>>
>> It won't.
>
> There were a lot of pushing on macro support for DTC.  Though it's
> going to be very slow, I guess someday we will have it at least for
> those simple and straight-forward syntax.
>
> But right, we shouldn't make any assumption on that.

I'm not sure you'd want a "programmable" device tree that expanded itself out
using macros. Just imagine what one tiny mistake in syntax could do - stop a
board from booting, for example.

You never ran into this on real OF, you never needed it, why would precompiled
DTs need it?

>> iomuxc at 0x73f08000 {
>>   fsl,iomux-pins = <mux value ctrl value ipp value
>> /* MX53_PIN_SD4_CMD__SD4_CMD */
>>                             mux value ctrl value ipp value
>>        /* etc. */
>>                             ...>;
>
> I do not see problem with this approach either.  But, this is nothing
> IMX specific.  Essentially, this becomes a common binding for
> configuring a pin with arbitrary number of register/value pairs.

And indeed, I don't see how this could possibly be a bad thing when
multiple boards can share such a binding and ease device tree
generation by making it a task of "cross reference the manual" or
"read the automated tool output and copy it to the device tree". So
the name changes to something non-fsl-specific or something and all
the boards that support it this way can enable it this way, job done,
common binding for multiple systems?

Side nit: how do you propose in the device tree to enable certain bits
in certain IOMUXC registers on MX6 or so?

The current solution where pinctrl holds IOMUXC to ransom (it ioremaps
the register set until _remove) is fine for now, but what if I want to
change my ENET_CLK_CTL or MIPI_IPU1_MUX or USB_OTG_ID or OCRAM
pipeline control bits in IOMUXC_GPRn for correct board operation? Is
this a bootloader responsibility or device tree? It seems odd to make
pad mux and control a device tree job, but internal path or unit setup
a bootloader job.

If we're doing this to configure the correct internal paths in the
SoC, the "correct" place might be in the ethernet@ node, or ipu-csi@
node as they define the operation and paths of these units, but they
would be better served to be defined at the pinctrl level and not at
the unit, since pinctrl "owns" IOMUXC. But having iomuxc at foo contain a
lot of very strange internal path definitions seems too odd and
cluttered.

In this case, pinctrl-imx implementation is too generic in claiming
this entire unit for the purpose. Probably what needs to be done is
fsl,imx6q-iomuxc gets claimed by an MFD which allows setting these
feature bits, and pinctrl simply depends on it to implement a pinctrl@
node underneath it (like regulators are done now).

As for requiring drivers to fetch and use pinctrl data without
possibility of dummies to allow it to "fail gracefully", I would say
pinctrl in i.MX drivers at least should not be a requirement - by all
means, search for the pin definitions, instruct pinctrl to perform
these operations, but if it does not find a compatible property..
carry on regardless, maybe with a warning that you MUST have trusted
your bootloader. Or define a linux,pinctrl-already-done property (this
would be useful for MX51 uart1 which is muxed to ALT0 by default, so
pinctrl needn't bother doing anything - it was always there and always
correctly configured from mask rom time up to Linux anyway..) and as
such we can omit the warning and just carry on regardless.

-- 
Matt Sealey <matt@genesi-usa.com>
Product Development Analyst, Genesi USA, Inc.
