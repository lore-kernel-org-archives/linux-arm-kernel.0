From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 26 Mar 2014 15:38:05 +0100
Subject: [PATCH v7 2/3] ARM: sun7i/sun6i: dts: Add NMI irqchip support
In-Reply-To: <5332A62D.90302@redhat.com>
References: <1395256879-8475-1-git-send-email-carlo@caione.org>
 <1395256879-8475-3-git-send-email-carlo@caione.org>
 <53329243.8090604@redhat.com> <20140326093946.GE6120@lukather>
 <5332A62D.90302@redhat.com>
Message-ID: <5332E64D.6040908@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 03/26/2014 11:04 AM, Hans de Goede wrote:
> Hi,
> 
> On 03/26/2014 10:39 AM, Maxime Ripard wrote:
>> On Wed, Mar 26, 2014 at 09:39:31AM +0100, Hans de Goede wrote:
>>> Hi,
>>>
>>> On 03/19/2014 08:21 PM, Carlo Caione wrote:
>>>> This patch adds DTS entries for NMI controller as child of GIC.
>>>>
>>>> Signed-off-by: Carlo Caione <carlo@caione.org>
>>>
>>> Note this breaks the kernel on sun6i / A31 since we don't have a
>>> pmic driver there yet, and thus the nmi gets constantly fired without
>>> anything clearing it.
>>>
>>> So the sun6i section needs a status = "disabled"; until we actually have pmic
>>> support.
>>
>> I guess it also applies to the A20, since the PMIC patches will
>> probably get merged later on?
> 
> Could be I've never tried it on the A20 without also having the pmic driver
> build into the kernel. Thinking more about this, I think this actually is
> a bug in the nmi irqchip driver, it should not unmask the gic irq until
> it gets an unmask for its child irq itself.
> 
> Otherwise we can still get the same problem if ie the pmic driver is
> a module, etc.
> 
> Hmm, looking at the code I see that it already masks (sets enable to 0)
> the irq in sunxi_sc_nmi_irq_init. Note that this really should be
> done before the irq_set_chained_handler call though, as from then on
> the gic irq is unmasked, so we may get spurious irqs until the
> sunxi_sc_nmi_write calls are done.
> 
> I don't think this will solve the A31 problem though, I wonder if
> the enable reg-offset we've for the A31 is correct, maybe it should
> be 8 like with the A20 ?
> 
> I'll give this a try when I can find some time for this.

Ok, so I've spend some time debugging this, and the problem is not the
disabling of the NMI in the NMI controller itself. The problem is that
the irq line used in the sun6i-a31.dtsi is wrong, irq 0 is for uart0
the nmi uses irq 32. So this fixes this hang due to unhandled irqs
I've been seeing:

--- a/arch/arm/boot/dts/sun6i-a31.dtsi
+++ b/arch/arm/boot/dts/sun6i-a31.dtsi
@@ -603,8 +603,7 @@
                        interrupt-controller;
                        #interrupt-cells = <2>;
                        reg = <0x01f00c0c 0x38>;
-                       interrupt-parent = <&gic>;
-                       interrupts = <0 0 4>;
+                       interrupts = <0 32 4>;
                };

                cpucfg at 01f01c00 {

Note I also remove the interrupt-parent as the gic is the
default interrupt-parent, and we don't explicitly set that
anywhere else either.

Besides that after having looked into this more, I strongly
believe that we should disable the NMI before registering the
irq handler, as registering the irq handler unmasks the irq
on the gic, so if u-boot has left the NMI enabled, and the NMI pin
is active we will immediately get an interrupt, before any
driver has claimed the downstream interrupt of the NMI.

IOW I strongly believe we should do this:

--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -179,12 +179,12 @@ static int __init sunxi_sc_nmi_irq_init(struct device_node *node,
        gc->chip_types[1].regs.type             = reg_offs->ctrl;
        gc->chip_types[1].handler               = handle_edge_irq;

-       irq_set_handler_data(irq, domain);
-       irq_set_chained_handler(irq, sunxi_sc_nmi_handle_irq);
-
        sunxi_sc_nmi_write(gc, reg_offs->enable, 0);
        sunxi_sc_nmi_write(gc, reg_offs->pend, 0x1);

+       irq_set_handler_data(irq, domain);
+       irq_set_chained_handler(irq, sunxi_sc_nmi_handle_irq);
+
        return 0;

 fail_irqd_remove:


So it looks like we need a v8, sorry for not spotting this sooner.

Regards,

Hans
