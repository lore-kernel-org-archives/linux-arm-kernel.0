From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Thu, 1 Mar 2018 11:03:28 +0100
Subject: [PATCH 1/3] dt-bindings: Add a binding for the sunxi message box
In-Reply-To: <d124c54f-7ac1-2305-0e69-94bc33c6eafe@arm.com>
References: <20180228022714.30068-1-samuel@sholland.org>
 <20180228022714.30068-2-samuel@sholland.org>
 <20180228082843.fga47gfrv2g5kmiz@flea>
 <d124c54f-7ac1-2305-0e69-94bc33c6eafe@arm.com>
Message-ID: <20180301100328.3w36zdadeaqums44@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 05:17:03PM +0000, Andre Przywara wrote:
> Hi Samuel,
> 
> thank you very much for writing and posting this!
> 
> On 28/02/18 08:28, Maxime Ripard wrote:
> > Hi,
> > 
> > On Tue, Feb 27, 2018 at 08:27:12PM -0600, Samuel Holland wrote:
> >> This mailbox hardware is present in several Allwinner sun8i and sun50i
> >> SoCs. Add a device tree binding for it.
> >>
> >> Signed-off-by: Samuel Holland <samuel@sholland.org>
> >> ---
> >>  .../devicetree/bindings/mailbox/sunxi-msgbox.txt   | 40 ++++++++++++++++++++++
> >>  1 file changed, 40 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> >>
> >> diff --git a/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> >> new file mode 100644
> >> index 000000000000..3b3ed7f870a0
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/mailbox/sunxi-msgbox.txt
> >> @@ -0,0 +1,40 @@
> >> +Allwinner sunxi Message Box
> >> +===========================
> >> +
> >> +The hardware message box on sunxi SoCs is a two-user mailbox controller
> >> +containing 8 unidirectional FIFOs bonded into 4 bidirectional mailbox channels.
> >> +An interrupt is raised for received messages, but software must poll to know
> >> +when a transmitted message has been acknowledged by the remote user.
> >> +
> >> +Refer to ./mailbox.txt for generic information about mailbox device-tree
> >> +bindings.
> >> +
> >> +Mailbox Device Node:
> >> +====================
> >> +
> >> +Required properties:
> >> +--------------------
> >> +- compatible:		Must be "allwinner,sunxi-msgbox".
> > 
> > The IP change quite often in the Allwinner SoCs, so it would be better
> > to use a more specific compatible there. IIRC that IP was introduced
> > with the A31, so what about sun6i-a31-msgbox?
> 
> As much as I like generic compatible strings ;-) I agree with Maxime
> here. Can you change this to something like:
> 
> - compatible: Must contain at least "allwinner,sun6i-a31-msgbox".
>               Should also contain one of the more specific strings, when
> 	      used on other SoCs which are compatible:
> 
> And then list the strings for the SoCs which we know of, ideally have
> been tested also?
> 
> The rationale behind this is that by listing those strings here we
> reserve them, to cover for future extensions or bugs found in those
> SoCs. So even though the driver would only match on
> "allwinner,sun6i-a31-msgbox" right now, we can extend it in the future.
> The actual DTs would always use:
> 	compatible = "allwinner,sun50i-a64-msgbox",
> 		     "allwinner,sun6i-a31-msgbox";
> Right now the first string would not match anything, but the second
> would. The driver would use the generic driver functionality.
> Should we find a bug or speciality in the A64, we can add the a64 string
> to the driver and connect it to the workaround, and the actual DTs would
> not need to be touched.
> Does this make sense?

It does to me :)

> >> +- reg:			Contains the mailbox register address range (base
> >> +			address and length).
> >> +- clocks:		phandle for the clock controller and specifier.
> >> +- clock-names:		Must be "bus".
> 
> Maxime:
> Out of curiosity: There is only one clock, and just to gate the APB
> clock to the MMIO registers. So do we need clock-names?

We don't.

> Or is this good practise these days to allow extending the clocks
> later in a compatible manner? (Thinking of the sunxi pinctrl here.)

This is always doable, since if you ever have multiple clocks, you
will have clock-names, so any newer clock will have a name, and the
first one will usually be the first in the index. This is not as nice
as having it from the start, but it's definitely something we can have
in the binding as well.

> And is "bus" the correct naming? I see "apb" being used as well, is this
> legacy?

So we were using apb/ahb at the beginning, but we've had some IPs
moving from one generation to the other from the APB to AHB bus iirc
(or the other way around, this was quite some time ago).

Having some more generic name will also help to have genpd handle the
clocks and resets lines, which is something I've wanted to have for
quite some time, but is very low on my TODO-list...

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180301/19aad8d7/attachment-0001.sig>
