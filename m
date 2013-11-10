From: david@gibson.dropbear.id.au (David Gibson)
Date: Sun, 10 Nov 2013 22:00:43 +1100
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <5272C773.2030901@wwwdotorg.org>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <20131025232951.GD17659@voom.redhat.com>
 <5272C773.2030901@wwwdotorg.org>
Message-ID: <20131110110043.GB21328@voom.fritz.box>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 31, 2013 at 03:11:15PM -0600, Stephen Warren wrote:
> On 10/25/2013 05:29 PM, David Gibson wrote:
> > On Thu, Oct 24, 2013 at 10:51:28PM +0100, Stephen Warren wrote:
> >> From: Stephen Warren <swarren@nvidia.com>
> >> 
> >> This is a very quick proof-of-concept re: how a DT schema checker
> >> might look if written in C, and integrated into dtc.
> 
> >> diff --git a/schemas/schema.c b/schemas/schema.c
> 
> >> +int schema_check_node(struct node *node)
> ...
> >> +	if (!best_checker) { +		printf("WARNING: no schema for node
> >> %s\n", node->fullpath); +		return 0; +	} + +	printf("INFO: Node
> >> %s selected checker %s\n", node->fullpath, +
> >> best_checker->name); + +	best_checker->checkfn(node);
> > 
> > IMO, thinking in terms of "the" schema for a node is a mistake. 
> > Instead, think in terms of a bunch of schemas, which "known" what 
> > nodes they're relevant for.  Often that will be determined by 
> > compatible, but it could also be determined by other things
> > (presence of 'interrupts', parent node, explicitly implied by
> > another schema).
> 
> I don't agree here.
> 
> Each node represents a single specific type of object, and the
> representation uses a single specific overall schema.
> 
> I'll admit that sometimes that schema is picked via the compatible
> value (most cases), and other times via the node name/path (e.g.
> /chosen, /memory).
> 
> In particular, I don't think it's correct to say that e.g. both a
> "Tegra I2C controller" schema and an "interrupt" schema apply equally
> to a "Tegra I2C DT node".

Why not?  Both are mandatory.

> Instead, I think that the "interrupt" schema
> only applies because the "Tegra I2C controller" schema happens to
> inherit from, or aggregate, the "interrupt" schema.

So, explicit inheritence makes sense in many cases, but I don't like
seeing these universal rules as inheritence based.  They should be
just that - universal - not opt-in for any particular device binding.

> I see two important results from this distinction:
> 
> 1) We should only allow properties from the "interrupt" schema to
> exist within a node /if/ the top-level schema for the node actually
> does make use of the "interrupt" schema". This is important since it
> disallows e.g.:
> 
>                 battery: smart-battery at b {
>                         compatible = "ti,bq20z45", "sbs,sbs-battery";
>                         reg = <0xb>;
>                         interrupt-parent = <&gpio>;
>                         interrupts = <5 4>;
>                 };
> 
> ... since the ti,bq20z45/sbs,sbs-battery don't actually have an
> interrupt output (assuming that the current binding doc for that
> compatible value accurately reflects the HW here anyway).
> 
> If we allowed the "interrupt" schema to match the node simply because
> it saw an "interrupts" property there, that'd allow this unused
> property to exist in the DT, whereas we really do want to throw an
> error here, so the DT author is aware they made a mistake.

So.  To clarify my proposal of multiple applied schemas: in order for
the node to "pass" the checks, it must satisfy all constraints of all
applicable schemas - they don't override each other.  Furthermore, I'm
not seeing any specific property as being owned by a particular schema
- multiple schemas applying to a node can place overlapping
constraints on the same property.

So in this case, the interrupt schema describes what the interrupts
property needs to look like if it exists, but the device schema says
that there should be no interrupts.  The only way to satisfy both is
to have no interrupts property, which is the right answer.

Actually, rather than a global "interrupts" schema here, more useful
would be a schema provided by the interrupt controller (and so
selected by the interrupt-parent property) which could validate the
internal format of the interrupt descriptors.  But, again, this
doesn't prevent the device schema from validating the number of
interrupt descriptors for this device.

> 2) Some inheritance or aggregation of schemas is parameterized, e.g.
> on property name. For example, GPIO properties are named ${xxx}-gpios.
> However, I don't believe there's any hard rule that absolutely
> mandates that an /unrelated/ property cannot exist that matches the
> same naming rule. Admittedly, it would be suboptimal if such a
> conflicting property name were used, but if there's no hard rule
> against it, I don't think we should design our schema checker to
> assume that.

The schema checker, no.  The schemas themselves, maybe.  At least for
really well established things, like interrupts, I think it's
reasonble that the schemas enforce best practice, not merely minimal
correctness.

> If the GPIO schema checker simply searched for any properties named
> according to that pattern, it might end up attempting to check
> properties that weren't actually generic GPIO specifiers. Instead, I'd
> prefer the node's top-level schema to explicitly state which
> properties should be checked according to which inherited schema(s).

So, in the case of GPIOs, I tend to agree.  For the case of
interrupts, not so much.

> In particular, perhaps this conflict could occur in a slightly generic
> binding for a series of similar I2C GPIO expander chips, some of which
> have 4 GPIOs and others 8. Someone might choose a "count-gpios" or
> "number-of-gpios" property to represent that aspect of the HW.
> 
> So overall, I believe it's actually very important to first determine
> *the* exact schema for a node, then apply that one top-level checker,
> with it then invoking various (potentially parameterized) sub-checkers
> for any inherited/aggregated schemas.

So, I certainly think we want explicitly invoked subcheckers.  But I
think we want multiple independently applied schemas for a single node
too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131110/9a5971e3/attachment.sig>
