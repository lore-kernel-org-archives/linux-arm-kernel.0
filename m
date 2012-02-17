From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2012 17:55:50 +0000
Subject: [PATCH v5 00/27] irq_domain generalization and rework
In-Reply-To: <4F3E9187.9080308@ti.com>
References: <1329383368-12122-1-git-send-email-grant.likely@secretlab.ca>
 <20120216145219.0f1c1b98.akpm@linux-foundation.org> <4F3E9187.9080308@ti.com>
Message-ID: <20120217175550.GQ27825@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 06:42:31PM +0100, Cousson, Benoit wrote:
> Hi Grant,
> 
> On 2/16/2012 11:52 PM, Andrew Morton wrote:
> > On Thu, 16 Feb 2012 02:09:01 -0700
> > Grant Likely<grant.likely@secretlab.ca>  wrote:
> > 
> >>
> >> This series generalizes the "irq_host" infrastructure from powerpc
> >> so that it can be used by all architectures and renames it to "irq_domain".
> > 
> > drivers/mfd/twl-core.c is fairly horked on i386 allmodconfig:
> > 
> > drivers/mfd/twl-core.c: In function 'twl_probe':
> > drivers/mfd/twl-core.c:1218: error: implicit declaration of function 'irq_alloc_descs'
> > drivers/mfd/twl-core.c:1226: error: implicit declaration of function 'irq_domain_add_legacy'
> > drivers/mfd/twl-core.c:1227: error: 'irq_domain_simple_ops' undeclared (first use in this function)
> > drivers/mfd/twl-core.c:1227: error: (Each undeclared identifier is reported only once
> > drivers/mfd/twl-core.c:1227: error: for each function it appears in.)
> > 
> > 
> > This is today's linux-next so it has rmk's "ARM: omap: fix broken
> > twl-core dependencies and ifdefs" in there, which looks like it
> > attempts to repair this stuff.
> 
> If we cannot assume this driver will be used only on architecture that does support IRQ_DOMAIN, we have to keep the #ifdef and then add the missing linux/irq.h.
> 
> Since this driver is using IRQ_DOMAIN only for Device Tree support, we can still avoid using irq_domain_add_legacy for the legacy non-DT case.
> That's too bad because I was expecting to use irq_domain to clean the cascading IRQ scheme used in that driver, but that can wait.
> 
> The fix is trivial, but here it is just in case.

...

> @@ -1237,8 +1238,10 @@ twl_probe(struct i2c_client *client, const struct i2c_device_id *id)
>  
>  	pdata->irq_base = status;
>  	pdata->irq_end = pdata->irq_base + nr_irqs;
> +#ifdef IRQ_DOMAIN
>  	irq_domain_add_legacy(node, nr_irqs, pdata->irq_base, 0,
>  			      &irq_domain_simple_ops, NULL);
> +#endif

Do you really need this?  If you've tested this, then apparantly the answer
is no, because it won't ever be built like that.  (You're missing a
CONFIG_ prefix.)

Maybe the only solution to the x86 problem is to ensure that the driver
includes linux/irq.h ?
