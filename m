From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 27 Jun 2011 09:02:07 -0600
Subject: [RFC PATCH 3/4] ARM: dt: add GIC bindings and driver support
In-Reply-To: <4E085B2E.5030605@arm.com>
References: <1308924659-31894-1-git-send-email-marc.zyngier@arm.com>
	<1308924659-31894-4-git-send-email-marc.zyngier@arm.com>
	<20110626080135.GC15026@ponder.secretlab.ca>
	<4E085B2E.5030605@arm.com>
Message-ID: <BANLkTin5q7uVCAobvoaBqsUHHn7zJs-x_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2011 at 4:27 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> On 26/06/11 09:01, Grant Likely wrote:
>> I see what you're doing here, but I don't think it is the best
>> approach in the long run. ?Rather than walking all the
>> interrupt-controller nodes looking for primary and secondary gics
>> while ignoring all others, I think there needs to be a function that
>> finds all the interrupt controller nodes, sorts them based on
>> dependencies, and calls their initialization hook in order. ?Other
>> architectures will use such a thing. ?I've been intending to do it for
>> powerpc for quite a while node.
>>
>> Would you be willing to tackle such a beast? ?I've got a fairly good
>> idea what it needs to look like, but I just haven't had the time to do
>> it.
>
> I can give it a go.

Awesome, thanks.

Okay, here is the general description of what needs to happen in ugly
pseudo code:

typedef void (*irq_init_cb_t)(struct intc_desc *intc_desc);

of_irq_init(struct of_device_id *irq_init)
{
        struct device_node *np;
        struct intc_desc *intc_desc;

        for_each_matching_node(np, match_table) {
                if (!of_find_property(np, "interrupt-controller"))
                        continue;
                /* Here, we allocate and populate an intc_desc with
the node pointer, interrupt-parent device_node etc. */
                intc_desc = of_alloc_intc_desc(np);
                list_add(&intc_desc->list, intc_desc_list);
        }

        /* The root irq controller is the one without an
interrupt-parent.  That one
         * goes first, followed by the controllers that reference it,
followed by the
         * ones that reference the 2nd level controllers, etc
         */
        of_irq_sort_descs();

        list_for_each_entry(intc_desc, intc_desc_list, list) {
                irq_init_cb_t *irq_init_cb;
                match = of_match_node(matches, desc->np);
                irq_init_cb = match->data;
                irq_init_cp(intc_desc);
        }
}

There's some ugliness in there with using of_device_id to get the
callback pointer because there is no typechecking when doing it that
way, but that just reflects the current infrastructure in
include/linux/of.h.  It doesn't have to be that way.

This doesn't work for all irq controllers, nor does it have to.
Anything on GPIO lines for instance can probably be deferred to
regular platform devices.  The main thing that is interesting here is
to get the core interrupt controllers bootstrapped so that other core
hardware, like timers, can use it immediately.

g.
