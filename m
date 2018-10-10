From: robh@kernel.org (Rob Herring)
Date: Wed, 10 Oct 2018 13:51:24 -0500
Subject: [PATCH 13/36] dt-bindings: arm: Convert PMU binding to json-schema
In-Reply-To: <20181010165048.GB16512@arm.com>
References: <20181005165848.3474-1-robh@kernel.org>
 <20181005165848.3474-14-robh@kernel.org>
 <20181009115713.GE6248@arm.com>
 <CAL_JsqLeG3WUa2peOWFGUoMuonWaWJoU-7A6d8cqXp-_e3B3XA@mail.gmail.com>
 <20181010165048.GB16512@arm.com>
Message-ID: <CAL_Jsq+NExxsksmhA6z5_eTutVkm_NFthayvHz-vvq1gkSeXNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 11:50 AM Will Deacon <will.deacon@arm.com> wrote:
>
> On Tue, Oct 09, 2018 at 01:14:02PM -0500, Rob Herring wrote:
> > On Tue, Oct 9, 2018 at 6:57 AM Will Deacon <will.deacon@arm.com> wrote:
> > >
> > > Hi Rob,
> > >
> > > On Fri, Oct 05, 2018 at 11:58:25AM -0500, Rob Herring wrote:
> > > > Convert ARM PMU binding to DT schema format using json-schema.
> > > >
> > > > Cc: Will Deacon <will.deacon@arm.com>
> > > > Cc: Mark Rutland <mark.rutland@arm.com>
> > > > Cc: linux-arm-kernel at lists.infradead.org
> > > > Cc: devicetree at vger.kernel.org
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  Documentation/devicetree/bindings/arm/pmu.txt | 70 --------------
> > > >  .../devicetree/bindings/arm/pmu.yaml          | 96 +++++++++++++++++++
> > > >  2 files changed, 96 insertions(+), 70 deletions(-)
> > > >  delete mode 100644 Documentation/devicetree/bindings/arm/pmu.txt
> > > >  create mode 100644 Documentation/devicetree/bindings/arm/pmu.yaml
> > >
> > > [...]
> > >
> > > > -- interrupts : 1 combined interrupt or 1 per core. If the interrupt is a per-cpu
> > > > -               interrupt (PPI) then 1 interrupt should be specified.
> > >
> > > [...]
> > >
> > > > +  interrupts:
> > > > +    oneOf:
> > > > +      - maxItems: 1
> > > > +      - minItems: 2
> > > > +        maxItems: 8
> > > > +        description: 1 interrupt per core.
> > > > +
> > > > +  interrupts-extended:
> > > > +    $ref: '#/properties/interrupts'
> > >
> > > This seems like a semantic different between the two representations, or am
> > > I missing something here? Specifically, both the introduction of
> > > interrupts-extended and also dropping any mention of using a single per-cpu
> > > interrupt (the single combined case is no longer support by Linux; not sure
> > > if you want to keep it in the binding).
> >
> > 'interrupts-extended' was implied before as it is always supported and
> > outside the scope of the binding. But now it is needed to validate
> > bindings. There must be some use of it and that's why I added it.
> > However, thinking some more about this, I think it may be better to
> > have the tools add this in automatically whenever we have an
> > interrupts property.
>
> To be honest, if you'd included that in the commit message I'd have been
> happy :)
>
> > I guess the single interrupt case is less obvious now with no
> > description (it's the first list item of 'oneOf'). The schema If the
> > single interrupt is not supported, then we can drop it here.
>
> Well the description says "1 interrupt per core" which is incorrect.

You are reading the schema wrong. There are 2 cases supported as
defined by each '-'. The 2nd case is all the keywords until the
indentation decreases. So 'description' is just description of the 2nd
case. The first case is just "maxItems: 1". I probably didn't put a
description because why write in free form text what the schema says
(other than of course no one knows json-schema...).

YAML combines the best of Makefiles and python. You can't have tabs
and Indentation is significant. :)

> I also
> don't understand why maxItems is 8.

Humm, I probably just made that up based on GICv2 limitations. What
should it be? If there's not any inherit maximum, can we put something
reasonable? There's not really any way to express that it should match
the number of cores in the system.

Rob
