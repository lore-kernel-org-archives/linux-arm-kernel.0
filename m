From: jacopo@jmondi.org (jacopo mondi)
Date: Thu, 17 May 2018 10:25:52 +0200
Subject: [PATCH 2/6] dt-bindings: media: rcar-vin: Document data-active
In-Reply-To: <20180516215538.GC17948@bigcity.dyn.berto.se>
References: <1526488352-898-1-git-send-email-jacopo+renesas@jmondi.org>
 <1526488352-898-3-git-send-email-jacopo+renesas@jmondi.org>
 <20180516215538.GC17948@bigcity.dyn.berto.se>
Message-ID: <20180517082552.GU5956@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Wed, May 16, 2018 at 11:55:38PM +0200, Niklas S?derlund wrote:
> Hi Jacopo,
>
> Thanks for your work.
>
> On 2018-05-16 18:32:28 +0200, Jacopo Mondi wrote:
> > Document 'data-active' property in R-Car VIN device tree bindings.
> > The property is optional when running with explicit synchronization
> > (eg. BT.601) but mandatory when embedded synchronization is in use (eg.
> > BT.656) as specified by the hardware manual.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> >  Documentation/devicetree/bindings/media/rcar_vin.txt | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > index c53ce4e..17eac8a 100644
> > --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> > +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > @@ -63,6 +63,11 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
> >  	If both HSYNC and VSYNC polarities are not specified, embedded
> >  	synchronization is selected.
> >
> > +        - data-active: active state of data enable signal (CLOCKENB pin).
>
> I'm not sure what you mean by active state here. video-interfaces.txt
> defines data-active as 'similar to HSYNC and VSYNC, specifies data line
> polarity' so I assume this is the polarity of the CLOCKENB pin?

Yes, I can change this if it feels confusing to you.
>
> > +          0/1 for LOW/HIGH respectively. If not specified, use HSYNC as
> > +          data enable signal. When using embedded synchronization this
> > +          property is mandatory.
>
> I'm confused, why is this mandatory if we have no embedded sync (that is
> hsync-active and vsync-active not defined)? I can't find any reference
> to this in the Gen2 datasheet but I'm sure I'm just missing it :-)
>

Not exactly, it becomes mandatory IF we have embedded sync.
Here it is my reasoning:

In the documentation of CHS bit of Vn_DMR2 register [1] the following
is specified:

"When using ITU-R BT.601, BT.709, BT.1358 interface, and the
VIn_CLKENB pin is unused, the CHS bit must be set to 1."

And setting the CHS bit to 1:

"HSYNC signal (VIn_HSYNC#) input from the pin is internally used
as the clock enable signal"

So, if 'data-active' property is not specified I assume CLCKENB is not
used, and set the CHS bit. What if we are using BT656 and there is no
HSYNC? Then specifying 'data-active' becomes mandatory, as otherwise we
set the CHS bit and wait for HSYNC pin transitions that won't happen.

This is probably wrong, as in the Koelsch case, there is no guarantee
that CLKENB is connected, and what I should have done is probably set
the CHS bit only when running on V4L2_MBUS_PARALLEL, and leave CHS
(and CES, if 'data-active' is not specified) untouched, as we're doing
today when running on V4L2_MBUS_BT656. Does this work better in your
opinion?

This also makes patch [6/6] (where I was adding 'data-active' to Gen-2
boards) not required.

Thanks
   j


[1] 26.2.18 Video n Data Mode Register 2 (VnDMR2) Datasheet version,
R19UH0105EJ0100 Rev.1.00 Apr 30, 2018

> > +
> >      - port 1 - sub-nodes describing one or more endpoints connected to
> >        the VIN from local SoC CSI-2 receivers. The endpoint numbers must
> >        use the following schema.
> > --
> > 2.7.4
> >
>
> --
> Regards,
> Niklas S?derlund
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180517/6971752f/attachment.sig>
