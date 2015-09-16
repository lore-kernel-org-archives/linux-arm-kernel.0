From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 16 Sep 2015 11:00:26 +0200 (CEST)
Subject: [PATCH v3 2/8] genirq: irqdomain: Remove irqdomain dependency
 on struct device_node
In-Reply-To: <55F91F07.3040807@arm.com>
References: <1442249047-21182-1-git-send-email-marc.zyngier@arm.com>
 <2330801.UsQO8cZmqT@vostro.rjw.lan> <55F7E268.1040302@arm.com>
 <2173233.CY7mtnyU1M@vostro.rjw.lan> <55F91F07.3040807@arm.com>
Message-ID: <alpine.DEB.2.11.1509161040590.3951@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 16 Sep 2015, Marc Zyngier wrote:
> On 16/09/15 02:53, Rafael J. Wysocki wrote:
> > I've just seen quite a few bugs where a pointer to something completely invalid
> > have been silently passed via (void *) which often results in very interesting
> > breakage (that is really hard to debug for that matter).
> 
> I actually tried to prototype this yesterday, and ended up in hell. The
> main issue is the point where the generic irqdomain code meets the DT
> subsystem (which is basically any interrupt controller, including those
> being ACPI driven). The domain_token to of_node path is dead easy, but
> you cannot do the reverse conversion, so this would have to spread
> around like a cancer. I gave up.
> 
> At this stage, I see two options: sticking with (void *) with the risk
> of breakage and subtle bugs which we all love to track down (not!), or
> do a major U-turn and make device_node a strict requirement for domain
> lookup.
> 
> After the above experiment, I now see some value in actually keeping
> device_node around, using it as the token, and allocating it when
> required (the typical case being those interrupt controllers that are
> both DT and ACPI). I'll play with it a bit more.

Right. We already have the fwnode_type in struct device_node, so we
can reuse it. If you care about the size of the struct, then you can
make some of the struct members conditional on CONFIG_OF.

Thanks,

	tglx
