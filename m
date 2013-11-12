From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 12 Nov 2013 15:06:03 -0700
Subject: [RFC PATCH dtc] C-based DT schema checker integrated into dtc
In-Reply-To: <20131110110043.GB21328@voom.fritz.box>
References: <1382651488-9696-1-git-send-email-swarren@wwwdotorg.org>
 <20131025232951.GD17659@voom.redhat.com> <5272C773.2030901@wwwdotorg.org>
 <20131110110043.GB21328@voom.fritz.box>
Message-ID: <5282A64B.3020706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/10/2013 04:00 AM, David Gibson wrote:
> On Thu, Oct 31, 2013 at 03:11:15PM -0600, Stephen Warren wrote:
>> On 10/25/2013 05:29 PM, David Gibson wrote:
>>> On Thu, Oct 24, 2013 at 10:51:28PM +0100, Stephen Warren
>>> wrote:
>>>> From: Stephen Warren <swarren@nvidia.com>
>>>> 
>>>> This is a very quick proof-of-concept re: how a DT schema
>>>> checker might look if written in C, and integrated into dtc.
>> 
>>>> diff --git a/schemas/schema.c b/schemas/schema.c
>> 
>>>> +int schema_check_node(struct node *node)
>> ...
>>>> +	if (!best_checker) { +		printf("WARNING: no schema for
>>>> node %s\n", node->fullpath); +		return 0; +	} + +
>>>> printf("INFO: Node %s selected checker %s\n", node->fullpath,
>>>> + best_checker->name); + +	best_checker->checkfn(node);
>>> 
>>> IMO, thinking in terms of "the" schema for a node is a mistake.
>>>  Instead, think in terms of a bunch of schemas, which "known"
>>> what nodes they're relevant for.  Often that will be determined
>>> by compatible, but it could also be determined by other things 
>>> (presence of 'interrupts', parent node, explicitly implied by 
>>> another schema).
>> 
>> I don't agree here.
>> 
>> Each node represents a single specific type of object, and the 
>> representation uses a single specific overall schema.
>> 
>> I'll admit that sometimes that schema is picked via the
>> compatible value (most cases), and other times via the node
>> name/path (e.g. /chosen, /memory).
>> 
>> In particular, I don't think it's correct to say that e.g. both
>> a "Tegra I2C controller" schema and an "interrupt" schema apply
>> equally to a "Tegra I2C DT node".
> 
> Why not?  Both are mandatory.

No. The interrupt schema isn't mandatory unless the Tegra I2C schema
actively opts in to interrupt usage.

>> Instead, I think that the "interrupt" schema only applies because
>> the "Tegra I2C controller" schema happens to inherit from, or
>> aggregate, the "interrupt" schema.
> 
> So, explicit inheritence makes sense in many cases, but I don't
> like seeing these universal rules as inheritence based.  They
> should be just that - universal - not opt-in for any particular
> device binding.

There isn't /an/ interrupt schema, there's a framework for interrupt
schemas, where the specific "final" schema parameterizes the interrupt
schema. It's impossible to fully evaluate whether an interrupts
property conforms to the requirements unless you evaluate it in the
context of a particular "final" schema.

Also, while it would be silly, I've never seen a rule specifically
stated that common properties such as interrupts, reg, *-gpios,
*-supply, pinctrl-* are absolutely reserved for their typical meaning,
and that no binding can ever use them for other local purposes. It
would make sense to explicitly state this though.

In practical terms, what this means is that, without any knowledge of
the final binding, you can check that an interrupts property conforms
to some general rules such as: it's a list of phandle + specifier, and
the specifier length must match the interrupt parent, and the number
of entries in interrupts an interrupt-names (if present) must match.

However, you can't check any of the following without specific
knowledge of the final binding:

* Some bindings don't use interrupts, and hence
interrupts/interrupt-names/interrupt-parent must /not/ be present in
the node.

* The specific (range of) number of entries that must be present in
interrupts.

* The specific set of entries that must exist in interrupt-names.

* Any ordering requirements on the names in interrupt-names (say the
binding was first defined to use interrupts by index, then later
extended to look up additional entries by name via interrupt-names).

I don't think it makes sense to check the base interrupts syntax
alone, then those other rules later. Instead, it makes sense to check
all the interrupt-related rules at once, when you have enough
knowledge of all the requirements.

Also, interrupts is an easy case because the property name is static.
What about GPIOs or regulators. Do the base GPIO/regulator schema
checkers search for all properties name *-gpios and *-supply and check
those? How would one avoid collisions with other bindings that happen
to use those same property names. Explicitly disallowing property name
collisions for single property names like interrupts seems reasonable.
Disallowing whole patterns of property names seems a bit harder, and
less reasonable.

>> I see two important results from this distinction:
>> 
>> 1) We should only allow properties from the "interrupt" schema
>> to exist within a node /if/ the top-level schema for the node
>> actually does make use of the "interrupt" schema". This is
>> important since it disallows e.g.:
>> 
>> battery: smart-battery at b { compatible = "ti,bq20z45",
>> "sbs,sbs-battery"; reg = <0xb>; interrupt-parent = <&gpio>; 
>> interrupts = <5 4>; };
>> 
>> ... since the ti,bq20z45/sbs,sbs-battery don't actually have an 
>> interrupt output (assuming that the current binding doc for that 
>> compatible value accurately reflects the HW here anyway).
>> 
>> If we allowed the "interrupt" schema to match the node simply
>> because it saw an "interrupts" property there, that'd allow this
>> unused property to exist in the DT, whereas we really do want to
>> throw an error here, so the DT author is aware they made a
>> mistake.
> 
> So.  To clarify my proposal of multiple applied schemas: in order
> for the node to "pass" the checks, it must satisfy all constraints
> of all applicable schemas - they don't override each other.
> Furthermore, I'm not seeing any specific property as being owned by
> a particular schema - multiple schemas applying to a node can place
> overlapping constraints on the same property.
> 
> So in this case, the interrupt schema describes what the
> interrupts property needs to look like if it exists, but the device
> schema says that there should be no interrupts.  The only way to
> satisfy both is to have no interrupts property, which is the right
> answer.

A big issue here is that if a node actually has an interrupts
property, but the final schema says it shouldn't, the only way to
check for that is for every schema that doesn't use interrupts to
specifically check that no interrupts property is present. That
explicit negative check has to be added for every common/generic/base
schema. That doesn't seem scalable.

Going back to the GPIOs/regulators case, if a base GPIO/regulator
schema has "blessed" property xxx-gpios as being OK, how does the
final schema for a node undo that; must it explicitly enumerate every
property that's present in the node and check it against the list of
valid properties? I had envisaged something more like:

for each node:
    mark each property as invalid
    run all the schema checks
      (marking properties as valid as they're checked)
    for all properties in node:
        if property is not marked valid, error out

If we run the various schema checkers at unrelated times, because
they're separate checks, then we end up with either:

for each node:
    run lots of sub-checkers
    mark each property as invalid
    run just the final schema checker
      (marking properties as valid as they're checked)
    for all properties in node:
        if property is not marked valid, error out

I don't like the special case for the final checker there.

If the schema checkers start to run on the same node in parallel, or
in any undefined order, then things start getting worse.

> Actually, rather than a global "interrupts" schema here, more
> useful would be a schema provided by the interrupt controller (and
> so selected by the interrupt-parent property) which could validate
> the internal format of the interrupt descriptors.  But, again,
> this doesn't prevent the device schema from validating the number
> of interrupt descriptors for this device.

interrupts is a bit special here because there's historically only
been one parent. However, not all "base" schemas have this benefit,
and even with interrupts, the interrupts-extend property breaks this
assumption. This means that n different "parent" (provider/supplier)
nodes end up defining the format of a single property in a consumer
node, which feels a bit messy. Having a single "check the entire
interrupts property" function/schema, which goes and gets a little
information from the provider/supplier (i.e. #interrupt-cells) feels a
lot cleaner.

>> 2) Some inheritance or aggregation of schemas is parameterized,
>> e.g. on property name. For example, GPIO properties are named
>> ${xxx}-gpios. However, I don't believe there's any hard rule that
>> absolutely mandates that an /unrelated/ property cannot exist
>> that matches the same naming rule. Admittedly, it would be
>> suboptimal if such a conflicting property name were used, but if
>> there's no hard rule against it, I don't think we should design
>> our schema checker to assume that.
> 
> The schema checker, no.  The schemas themselves, maybe.  At least
> for really well established things, like interrupts, I think it's 
> reasonable that the schemas enforce best practice, not merely
> minimal correctness.

True. It sounds like we want a schema checker for the schemas, so that
schema X can't (re-)define a property that schema Y defines the global
meaning of!

>> If the GPIO schema checker simply searched for any properties
>> named according to that pattern, it might end up attempting to
>> check properties that weren't actually generic GPIO specifiers.
>> Instead, I'd prefer the node's top-level schema to explicitly
>> state which properties should be checked according to which
>> inherited schema(s).
> 
> So, in the case of GPIOs, I tend to agree.  For the case of 
> interrupts, not so much.

Surely we want to deal with everything in a uniform way though, rather
than having some techniques that work for interrupts, and a different
set of techniques that work for GPIOs.

>> In particular, perhaps this conflict could occur in a slightly
>> generic binding for a series of similar I2C GPIO expander chips,
>> some of which have 4 GPIOs and others 8. Someone might choose a
>> "count-gpios" or "number-of-gpios" property to represent that
>> aspect of the HW.
>> 
>> So overall, I believe it's actually very important to first
>> determine *the* exact schema for a node, then apply that one
>> top-level checker, with it then invoking various (potentially
>> parameterized) sub-checkers for any inherited/aggregated
>> schemas.
> 
> So, I certainly think we want explicitly invoked subcheckers.  But
> I think we want multiple independently applied schemas for a single
> node too.
