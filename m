From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Tue, 21 Jan 2014 13:31:48 +0000
Subject: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states bindings
In-Reply-To: <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
References: <1390240079-6495-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
 <CAKfTPtAbYXuis1bfyDLiHRaYwosre3RAG+iNQSz-y+cWfc3uQA@mail.gmail.com>
Message-ID: <20140121133148.GB28801@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 21, 2014 at 11:16:46AM +0000, Vincent Guittot wrote:

[...]

> > +- Dormant:
> > +       # Dormant mode is entered by executing wfi instructions and by sending
> > +         platform specific commands to the platform power controller (coupled
> > +         with processor specific SW/HW control sequences).
> > +         In dormant mode, most of the processor control and debug logic is
> > +         powered up but cache RAM can be put in retention state, providing
> 
> Base on your description, it's not clear for me what is on, what is
> lost and what is power down ?

Sorry, typo, "powered down", not powered up.

> My understand of the dormant mode that you described above is : the
> cache is preserved (and especially the cache RAM) but the processor
> state is lost (registers ...). Do I understand correctly ?

Yes.

> What about retention mode where the contents of processor and cache
> are preserved but the power consumption is reduced ? it can be seen as
> a special wfi mode which need specific SW/HW control sequences but i'm
> not sure to understand how to describe such state with your proposal.

True, and I omitted that on purpose so that it can be debated and to
keep it simple (well, so to speak) thanks for pointing that out.

The bindings allow a C-state to link to a power domain. Each device can
link itself to a power domain. Hence at least now we know what devices
are affected by a C-state (and by device I also mean arch timers, PMUs,
GIC, etc).

Now, retention vs. off. In theory we could link a device to a C-state
and define what mode would be that device on C-state entry, but honestly
it starts becoming looooots of data in the DT.

For instance, we could define for every device the max C-state index allowed
for the device context to be powered-up (or retained).

Or, find a way to describe it through the power domain specifier:

cache {
	power-domain = <&foo 0 &foo 1>:
	power-state = <1 0>;
};

which means that for the pair <&foo 0> cache is retained (1 == retained,
0 == lost) and for power domain <&foo 1> cache is lost.

I have no complete answer, certainly this adds complexity (but it is a very
complex problem, so..) and it is a bit horrible, ideas welcome.

[...]

> > +       - psci-power-state
> > +               Usage: Required if entry-method property value is set to
> > +                      "psci".
> > +               Value type: <u32>
> > +               Definition: power_state parameter to pass to the PSCI
> > +                           suspend call to enter the C-state.
> 
> Why psci has got a dedicated field and not vendor methods ? can't you
> make that more generic ?

If anyone provides me with an example usage why not, for now I know I
need that parameter for PSCI, I can call it differently, define it for PSCI
and leave it as optional for other methods.

Thanks,
Lorenzo
