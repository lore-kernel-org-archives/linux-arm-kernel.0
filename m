From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 24 Feb 2012 12:23:33 +0000
Subject: [PATCH-WIP 07/13] xen/arm: receive xen events on arm
In-Reply-To: <4F4770AD.6040703@citrix.com>
References: <alpine.DEB.2.00.1202231714590.23091@kaball-desktop>
 <1330019314-20865-7-git-send-email-stefano.stabellini@eu.citrix.com>
 <4F4770AD.6040703@citrix.com>
Message-ID: <alpine.DEB.2.00.1202241221440.23091@kaball-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 24 Feb 2012, David Vrabel wrote:
> On 23/02/12 17:48, Stefano Stabellini wrote:
> > Compile events.c and use IRQ 32 to receive events notifications.
> > 
> > Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>
> 
> > +#ifdef CONFIG_ARM
> > +#define IRQ_EVTCHN_CALLBACK 63
> > +irqreturn_t xen_arm_callback(int irq, void *arg)
> > +{
> > +	__xen_evtchn_do_upcall();
> > +	return 0;
> > +}
> > +
> > +int __init xen_init_IRQ_arm(void)
> > +{
> > +	int rc;
> > +	xen_init_IRQ();
> > +	rc = request_irq(IRQ_EVTCHN_CALLBACK, xen_arm_callback,
> > +			IRQF_DISABLED | IRQF_NOBALANCING | IRQF_TRIGGER_RISING,
> > +			"events", "events");	
> > +	if (rc) {
> > +		printk(KERN_ERR "Error requesting IRQ %d\n", IRQ_EVTCHN_CALLBACK);
> > +	}
> > +	return rc;
> > +}
> > +core_initcall(xen_init_IRQ_arm);
> > +#endif
> 
> You should (eventually) have a device tree binding for the event channel
> and use a OF (device tree) device driver instead of this core_initcall()
> to register the handler etc.
 
Yes, that is the idea, once we have better device tree support in Xen.
We should also pass the IRQ number to be used as event injection
mechanism through the device tree.
