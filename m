From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 9 Sep 2014 12:03:00 +0100
Subject: [PATCH 1/2 V4] irqchip: gic: Add supports for ARM GICv2m MSI(-X)
In-Reply-To: <540E3639.5080807@amd.com>
References: <1407942041-3291-1-git-send-email-suravee.suthikulpanit@amd.com>
 <1407942041-3291-2-git-send-email-suravee.suthikulpanit@amd.com>
 <20140814175525.GI24018@leverpostej> <540E3639.5080807@amd.com>
Message-ID: <20140909110300.GD27786@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> >> @@ -1009,6 +1012,16 @@ gic_of_init(struct device_node *node, struct device_node *parent)
> >>          if (of_property_read_u32(node, "cpu-offset", &percpu_offset))
> >>                  percpu_offset = 0;
> >>
> >> +       gic_data[gic_cnt].irq_chip = &gic_chip;
> >> +
> >> +       /* Currently, we only support one v2m subnode. */
> >> +       child = of_get_child_by_name(node, "v2m");
> >> +       if (child) {
> >> +               ret = gicv2m_of_init(child, &gic_data[gic_cnt]);
> >> +               if (ret)
> >> +                       return ret;
> >> +       }
> >
> > I can't see how you'd sanely expand this to multiple children, which was
> > the main point of having a separate node for the M block.
> >
> > Give the M block a compatible string and look for children with that
> > string.
> 
> Mark,
> 
> I am making change in the struct gic_chip_data to contain "v2m_list" (instead of just
> a single struct v2m_data). This way, it is clear on how we should handle multiple v2m nodes
> within a GIC.

Ok.

> As for the device tree binding, in order to handle multiple v2m nodes within a GIC,
> it should not require adding another compatibility ID as it seems too complicate
> to have GIC node with multiple compat IDs).

I don't follow.

How does each sub-node having a compatible string complicate the GIC
node?

Mark.
