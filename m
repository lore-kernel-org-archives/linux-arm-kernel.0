From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 21 Feb 2017 12:03:34 +0000
Subject: [PATCH v4 10/11] drivers: perf: hisi: Handle counter overflow
 IRQ in MN PMU
In-Reply-To: <58AC2966.3060200@gmail.com>
References: <1487530282-42731-1-git-send-email-anurup.m@huawei.com>
 <20170220112918.GG9003@leverpostej> <58AC2966.3060200@gmail.com>
Message-ID: <20170221120334.GB8605@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 05:19:58PM +0530, Anurup M wrote:
> On Monday 20 February 2017 04:59 PM, Mark Rutland wrote:
> >On Sun, Feb 19, 2017 at 01:51:22PM -0500, Anurup M wrote:

> >>+			/* Clear the IRQ status flag */
> >>+			hisi_djtag_writereg(module_id, MN1_BANK_SELECT,
> >>+				MN1_INTC_REG_OFF, (1 << bit_pos), client);
> >>+
> >>+			/* Get the corresponding event struct */
> >>+			event = mn_pmu->hw_perf_events[bit_pos];
> >>+			if (!event)
> >>+				continue;
> >Do we expect to take interrupts for an event which does not exist?
> 
> Here I ignore if the event does not exist. I have seen it is handled
> in arm_pmu and other reference
> implementations to ignore if there is no event.
> The event is cleared in .del. So if .del is called before the IRQ
> handler, this check is required right?
> Please comment.

If there's a particular case whre we'd see the overflow bit set for an
event, please add a comment describing that case here.

[...]

> >>+static int hisi_mn_init_irqs_fdt(struct device *dev,
> >>+				struct hisi_pmu *mn_pmu)
> >>+{
> >>+	struct hisi_mn_data *mn_data = mn_pmu->hwmod_data;
> >>+	struct hisi_djtag_client *client = mn_data->client;
> >>+	int irq = -1, num_irqs, i;
> >>+
> >>+	num_irqs = of_irq_count(dev->of_node);
> >Surely we expect a specific number of interrupts?
> >
> >>+	for (i = 0; i < num_irqs; i++) {
> >>+		irq = of_irq_get(dev->of_node, i);
> >>+		if (irq < 0)
> >>+			dev_info(dev, "No IRQ resource!\n");
> >>+	}
> >Why are we throwing these away?
> >
> >>+
> >>+	if (irq < 0)
> >>+		return 0;
> >>+
> >>+	/* The last entry in the IRQ list to be chosen
> >>+	 * This is as per mbigen-v2 IRQ mapping
> >>+	 */
> >>+	return hisi_mn_init_irq(irq, mn_pmu, client);
> >I don't understand this comment.
> >
> >Why do we only use the list IRQ?
> >
> >What does this have to do with the mbigen?
> >
> >No ordering requirement was described in the DT binding.
> 
> There is a defect in the mbigen hardware to handle the IRQ mapping
> for MN.
> Due to this the IRQ property
> of MN is made as a list and we read all IRQs and use only the last one.
> I shall mention it in the comment and also add note in the DT bindings.

You'll need to elaborate on that a bit further; I don't understand.

If the interrupts aren't usable, there's arguably not much point listing
them in the DT.

Regardless, the order of the list *must* be specified in the DT binding.

Thanks,
Mark.
