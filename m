From: robh@kernel.org (Rob Herring)
Date: Sun, 7 Oct 2018 14:20:12 -0500
Subject: [PATCH 27/36] dt-bindings: arm: Convert Realtek board/soc
 bindings to json-schema
In-Reply-To: <41eb7b19-dd26-16e2-bd80-b8b7d6f52f94@suse.de>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-28-robh@kernel.org>
 <41eb7b19-dd26-16e2-bd80-b8b7d6f52f94@suse.de>
Message-ID: <CAL_Jsq+D7Hh6Ry+21Dvpp5YvPLjoLCur8x7r8xKpLUVv6ZoQ4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 6, 2018 at 5:54 AM Andreas F?rber <afaerber@suse.de> wrote:
>
> Am 05.10.18 um 18:58 schrieb Rob Herring:
> > Convert Realtek SoC bindings to DT schema format using json-schema.
>
> YAML (2x)

?

> > Cc: "Andreas F?rber" <afaerber@suse.de>
> > Cc: Mark Rutland <mark.rutland@arm.com>
> > Cc: linux-arm-kernel at lists.infradead.org
> > Cc: devicetree at vger.kernel.org
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  .../devicetree/bindings/arm/realtek.txt       | 22 ----------------
> >  .../devicetree/bindings/arm/realtek.yaml      | 25 +++++++++++++++++++
> >  2 files changed, 25 insertions(+), 22 deletions(-)
> >  delete mode 100644 Documentation/devicetree/bindings/arm/realtek.txt
> >  create mode 100644 Documentation/devicetree/bindings/arm/realtek.yaml
> >
> > diff --git a/Documentation/devicetree/bindings/arm/realtek.txt b/Documentation/devicetree/bindings/arm/realtek.txt
> > deleted file mode 100644
> > index 95839e19ae92..000000000000
> > --- a/Documentation/devicetree/bindings/arm/realtek.txt
> > +++ /dev/null
> > @@ -1,22 +0,0 @@
> > -Realtek platforms device tree bindings
> > ---------------------------------------
> > -
> > -
> > -RTD1295 SoC
> > -===========
> > -
> > -Required root node properties:
> > -
> > - - compatible :  must contain "realtek,rtd1295"
> > -
> > -
> > -Root node property compatible must contain, depending on board:
> > -
> > - - MeLE V9: "mele,v9"
> > - - ProBox2 AVA: "probox2,ava"
> > - - Zidoo X9S: "zidoo,x9s"
> > -
> > -
> > -Example:
> > -
> > -    compatible = "zidoo,x9s", "realtek,rtd1295";
> > diff --git a/Documentation/devicetree/bindings/arm/realtek.yaml b/Documentation/devicetree/bindings/arm/realtek.yaml
> > new file mode 100644
> > index 000000000000..9e3bb3249c77
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/arm/realtek.yaml
> > @@ -0,0 +1,25 @@
> > +# SPDX-License-Identifier: None
>
> What is the expected license for such bindings?

Good question. I'd meant to figure something out for this placeholder.
The default would be GPL-2 inheriting from the old doc. My preference
would be to dual license these with BSD as they're not just kernel
files, but I don't really want to track down copyright holders (also
not explicitly declared) to do that.

> You did not add such a line for actions.yaml.
>
> > +%YAML 1.2
> > +---
> > +$id: http://devicetree.org/schemas/bindings/arm/realtek.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Realtek platforms device tree bindings
> > +
> > +maintainers:
> > +  - Andreas F?rber <afaerber@suse.de>
> > +
> > +description: |+
>
> "|+"?

The '|'  means a literal block. The '+' is a block chomping indicator:

http://yaml.org/spec/1.2/spec.html#id2794534

This was all converted using my doc2yaml script and ruamel.yaml
decided it needed the '+'. I'm not sure exactly why. It may be based
on how many trailing newlines the text had.

> > +  RTD1295 SoC

In this case, this isn't really useful and we should just remove
description unless you want to add something.

> > +
> > +properties:
> > +  $nodename:
> > +    const: '/'
> > +  compatible:
> > +    items:
> > +      - enum:
> > +          - mele,v9
> > +          - probox2,ava
> > +          - zidoo,x9s
> > +      - const: realtek,rtd1295
> > +...
>
> That does not look like a full "PATCH" yet? It also confuses me whether
> or when leading dashes are necessary - for Actions Semi "items" had one.

'...' is the end of YAML document marker.

'-' means a list item (a YAML/JSON list, not to be confused with
'items' the json-schema keyword). Actions uses 'oneOf' (which is a
list of schemas) because there are multiple SoCs.

And also 'items' itself can be a list or dict, but we restrict it to
lists for the DT meta-schema.

> I have preparations on my GitHub staging tree for three more SoCs, so we
> should prepare the structure to ease adding SoCs and avoid re-indenting
> patches - adding SoCs was much easier in the original flat text format.
> Please also consider for other vendors.

Good point.

One option is always use 'oneOf' even if just 1 item. The problem is
that the use of oneOf/allOf/anyOf makes the error reporting pretty
vague.

Another option is to make each SoC a separate schema which could be
either separate docs or multiple yaml docs within a file. The downside
is just repeating all the top-level properties.

>
> Same comment as for Actions: We're losing a human description of the
> enum values.

I kept those as comments when there was meaningful information. I did
not feel that "MeLE V9" as a description of "mele,v9" added any value.
If you want to add 'model' schema that would be better than having
just comments, but I'm not going to find all the values of model which
aren't documented.

Rob
