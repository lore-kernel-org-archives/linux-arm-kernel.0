From: jacopo@jmondi.org (jacopo mondi)
Date: Tue, 12 Jun 2018 15:29:49 +0200
Subject: [PATCH v3 6/8] dt-bindings: rcar-vin: Add 'hsync-as-de' custom
 prop
In-Reply-To: <20180604121933.GG19674@bigcity.dyn.berto.se>
References: <1527606359-19261-1-git-send-email-jacopo+renesas@jmondi.org>
 <1527606359-19261-7-git-send-email-jacopo+renesas@jmondi.org>
 <20180604121933.GG19674@bigcity.dyn.berto.se>
Message-ID: <20180612132949.GB4952@w540>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Niklas,

On Mon, Jun 04, 2018 at 02:19:33PM +0200, Niklas S?derlund wrote:
> Hi Jacopo,
>
> Thanks for your work.
>
> On 2018-05-29 17:05:57 +0200, Jacopo Mondi wrote:
> > Document the boolean custom property 'renesas,hsync-as-de' that indicates
> > that the HSYNC signal is internally used as data-enable, when the
> > CLKENB signal is not connected.
> >
> > As this is a VIN specificity create a custom property specific to the R-Car
> > VIN driver.
> >
> > Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> > ---
> > v3:
> > - new patch
> > ---
> >  Documentation/devicetree/bindings/media/rcar_vin.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/media/rcar_vin.txt b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > index ff53226..024c109 100644
> > --- a/Documentation/devicetree/bindings/media/rcar_vin.txt
> > +++ b/Documentation/devicetree/bindings/media/rcar_vin.txt
> > @@ -60,6 +60,9 @@ from local SoC CSI-2 receivers (port1) depending on SoC.
> >          - vsync-active: see [1] for description. Default is active high.
> >          - data-enable-active: polarity of CLKENB signal, see [1] for
> >            description. Default is active high.
> > +        - renesas,hsync-as-de: a boolean property to indicate that HSYNC signal
> > +          is internally used as data-enable when the CLKENB signal is
> > +          not available.
>
> I'm not sure I like this, is there really a need to add a custom
> property for this? The datasheet states that when the CLKENB pin is not
> connected the driver should enable 'Clock Enable Hsync Select (CHS)'.
> With the new generic property 'data-enable-active' which describes the
> polarity of the CLKENB pin we also gain the knowledge if the CLKENB pin
> is connected or not.

That was my first proposal, we discussed that in
Re: [PATCH 3/6] media: rcar-vin: Handle data-active property
Re: [PATCH 2/6] dt-bindings: media: rcar-vin: Document data-active

Let's sum it up in this way:
Instead of having to deal again with the "what happens if there is no
data-enable-active and we're running on BT.656 where there is no HSYNC signal"[1]
I decided to go with a custom property.

>
> I propose we drop this custom property and instead let the driver check
> if the CLKENB polarity is described or not and use that to determine if
> CHS bit should be set or not. IMHO that is much simpler then having two
> properties describing the same pin.
>

It is my understanding that both Gen2 and Gen3 boards CVBS input are
BT.656 and none of them has CLKENB input. So 'data-enable-active' is
never there but in this case we should not set CHS. So the absence of
'data-enable-active' has different consequences if we're running on
parallel or BT.656 bus, and that feels confusing to me, so I decided
to make it an explicit property.

Also, as the interface manual describes the "use HSYNC in place of CLKENB"
when on parallel bus as a design choice, that should imo be documented.

Again, this is very minor stuff. I'll leave this out from next
version, maybe we can talk about this f2f next week.

Thanks
  j

> >
> >          If both HSYNC and VSYNC polarities are not specified, embedded
> >          synchronization is selected.
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180612/d1d7273b/attachment.sig>
