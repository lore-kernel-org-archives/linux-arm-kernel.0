From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 25 Nov 2013 00:42:13 +0000
Subject: ACPI
In-Reply-To: <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <CACRpkdbNxxNK0GM28H_nDLu6EpbQ-EYAdEeTp5fnXW5mkEPkgw@mail.gmail.com>
Message-ID: <CACxGe6uHuWPh7d9NaVuPRBWq0Fh1BmDV190KEN4C4uaq4KjS8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 Nov 2013 17:14, "Linus Walleij" <linus.walleij@linaro.org> wrote:
>
> On Mon, Nov 18, 2013 at 7:42 PM, Jon Masters <jonathan@jonmasters.org> wrote:
>
> > Could we articulate a series of useful asks that would help with moving
> > forward with ACPI? For example, it is clear that there needs to be
> > more involvement in the standardization of ACPI (...)
>
> One thing I think a bit about is ontology[1], what is written in that
> spec and under what assumptions. I noticed from DSDT fragments
> here and there that ACPI has no concept of pin control, but instead
> adhere to the old fallacy of mixing this up with GPIO in the examples
> I saw, and this would be good to have clarified, maybe I as a
> subsystem maintainer need to go read some spec and provide
> feedback on it?
>
> For devicetree we have a bit of standardization in
> Documentation/devicetree/bindings/pinctrl and if I'm not mistaken,
> nothing of the sort exist in the ACPI spec.

No, none of that exists in ACPI. We're looking at entirely new
territory for ACPI.

It seems there are two ways we can approach ACPI. 1) we could treat
ACPI exactly like DT and expect DT bindings to carry over verbatim
into the ACPI namespace. That means everything we've done with DT we
expect to show up in ACPI trees including clocks, regulators, pin
control, etc. Or, 2) assume that if ACPI is being used, then the
intent is to push responsibility for the platform as a whole
(system-wide details as opposed to individual devices) out of the
kernel.

The first option has the advantage of possibly being able to use DT
device drivers virtually unchanged because ACPI provides exactly the
same data. However, I expect that OEM vendors are actually after #2.
They are wanting the ability to abstract the platform sufficiently
enough that new hardware can be supported without explicitly working
with upstream[1][2].

I really don't know which is best here. Describing all the hardware
blocks is absolutely the right thing to do with DT. If ACPI does the
same, then I think a very strong requirement is for the bindings to be
*identical* to the DT ones (with the exception that cross-node
references will be of a different format).

If ACPI has to have different bindings, then I think we should push
back hard to not implement bindings for all of the platform
integration stuff (clock, regulators, etc). Don't even model them
since it would appear that the platform wants to be responsible for
all of them. Of course the downside here is that Linux gets to know
very little about the underlying platform. Things like i2c lmsensor
busses will possibly be unavailable.

[1] I'm Ignoring the other motivation which is that ACPI is the only
interface that Microsoft wants to use.
[2] The assumption being that new IP blocks for clocks or regulators
(for example) could be manipulated by AML without explicit Linux
device drivers.


>
> The same can probably be said about slave DMA,
> Documentation/devicetree/bindings/pinctrl?
> Or regulators? Clocks? Runtime PM and D-states as
> Arnd mentioned?
>
> In which cases does the ACPI definitions of terms, paradigms and
> ontologies match those if the kernel subsystems, and where will
> we be shoehorned into somebody else's idea of the world, and
> is there something we can do about it (i.e. influcence this).

The plus side is we do have a lot of influence here. ARM servers are
being built to run Linux. I don't know of any Microsoft plans, but
even if they plan to release a server OS, Linux is currently in the
driver seat.

g.
