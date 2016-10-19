From: stephen.boyd@linaro.org (Stephen Boyd)
Date: Tue, 18 Oct 2016 18:53:07 -0700
Subject: [PATCH v5 11/23] usb: chipidea: Emulate OTGSC interrupt enable
 path
In-Reply-To: <20161019011535.GC6294@b29397-desktop>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-12-stephen.boyd@linaro.org>
 <20161019011535.GC6294@b29397-desktop>
Message-ID: <147684198705.24897.12451889548508263144@sboyd-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Peter Chen (2016-10-18 18:15:35)
> On Mon, Oct 17, 2016 at 06:56:24PM -0700, Stephen Boyd wrote:
> > In the case of an extcon-usb-gpio device being used with the
> > chipidea driver we'll sometimes miss the BSVIS event in the OTGSC
> > register. Consider the case where we don't have a cable attached
> > and the id pin is indicating "host" mode. When we plug in the usb
> > cable for "device" mode a gpio goes high and indicates that we
> > should do the role switch and that vbus is high. When we're in
> > "host" mode the OTGSC register doesn't have BSVIE set.
> 
> I have some questions for your description:
> 
> - Do you have any pending or related patches what this patch set
>   is based on? Afaik, the extcon-usb-gpio has no vbus event supported.

If you're asking if I've made modifications to extcon-usb-gpio, then the
answer is no. The branch on linaro.org git server from the cover-letter
is the branch I've used to test this with. This patch is specifically to
fix issues with that design on the db410c board that has only one pin
for ID and vbus detection. It's the schematic that we've discussed in
another thread.

extcon-usb-gpio sends two extcon events, EXTCON_USB_HOST (for the id
pin) and EXTCON_USB (for the vbus). So afaik it does support vbus
events.

> - When the ID from 0->1, the chipidea driver will do role switch, and
>   set BSVIE, why it does not occur for your case?

Right, that happens with this line in the sequence I describe below:

  hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE, OTGSC_BSVIS | OTGSC_BSVIE);

but that happens much later than when the extcon event happens so we
miss the interrupt. Technically, the driver isn't expecting the BSVIS
interrupt to happen until BSVIE is set, but the extcon can come whenever
it wants regardless of how the registers are configured in the
controller.  So we have to do some sort of 'caching' here to remember
that the vbus event happened and replay it when BSVIE is set. At least I
imagine this is how the hardware would work? Or if vbus goes high before
we enable the interrupt would it just be missed? It seems like polling
the BSV bit and then enabling BSVIE is sort of racy there.

Plus, we poll the BSV bit when we role switch, but in my case id bit
toggles and vbus goes high at exactly the same time because that is all
happening from a single cable being connected, so it's not possible for
BSV to go low and see it after the id pin from 0 to 1.

> 
> Peter
> > 
> > The following scenario can happen:
> > 
> > CPU0
> > ----
> > <extcon notifier chain>
> >  ci_cable_notifier()
> >   update id cable state
> >   ci_irq()
> >    if (ci->is_otg && (otgsc & OTGSC_IDIE) && (otgsc & OTGSC_IDIS)) { // true
> >     ci->id_event = true;
> >     ci_otg_queue_work()
> >      schedule()
> > 
> > <extcon notifier event> // same task as before
> >  ci_cable_notifier()
> >   update vbus cable state
> >    ci_irq()
> >     if (ci->is_otg && (otgsc & OTGSC_BSVIE) && (otgsc & OTGSC_BSVIS)) // false
> >    return IRQ_NONE
> > 
> > ci_otg_work() // switch task to the workqueue now
> >  if (ci->id_event)
> >   ci_handle_id_switch()
> >    ci_role_stop()
> >     host_stop()
> >    hw_wait_vbus_lower_bsv(ci); // this times out because vbus is already set
> >    ci_role_start()
> >     udc_id_switch_for_device()
> >      hw_write_otgsc(ci, OTGSC_BSVIS | OTGSC_BSVIE, OTGSC_BSVIS | OTGSC_BSVIE);
> > 
> > At this point, we don't replay the vbus connect event because the
> > vbus event has already happened. This causes things like gadget
> > instances to never see vbus appear, and thus the gadget is never
> > started. Furthermore, we see timeout messages like:
> > 
> >       timeout waiting for 0000800 in OTGSC
> > 
> > Let's workaround this by skiping the wait for BSV when we're
> > using an extcon for the vbus notification and let's properly
> > emulate the BSVIS event that would happen when we enable the
> > vbus interrupt while enabling "device" mode.
