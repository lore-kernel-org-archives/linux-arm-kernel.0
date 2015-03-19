From: will.deacon@arm.com (Will Deacon)
Date: Thu, 19 Mar 2015 19:37:24 +0000
Subject: [PATCH v10 15/21] ARM64 / ACPI: Introduce ACPI_IRQ_MODEL_GIC and
 register device's gsi
In-Reply-To: <20150319101205.GB24556@red-moon>
References: <1426077587-1561-1-git-send-email-hanjun.guo@linaro.org>
 <1426077587-1561-16-git-send-email-hanjun.guo@linaro.org>
 <20150318184114.GL10863@arm.com> <550A465F.50701@huawei.com>
 <20150319101205.GB24556@red-moon>
Message-ID: <20150319193724.GF4751@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 19, 2015 at 10:12:05AM +0000, Lorenzo Pieralisi wrote:
> On Thu, Mar 19, 2015 at 03:45:35AM +0000, Hanjun Guo wrote:
> > >> +	if (trigger == ACPI_EDGE_SENSITIVE &&
> > >> +				polarity == ACPI_ACTIVE_LOW)
> > >> +		irq_type = IRQ_TYPE_EDGE_FALLING;
> > >> +	else if (trigger == ACPI_EDGE_SENSITIVE &&
> > >> +				polarity == ACPI_ACTIVE_HIGH)
> > >> +		irq_type = IRQ_TYPE_EDGE_RISING;
> > >> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> > >> +				polarity == ACPI_ACTIVE_LOW)
> > >> +		irq_type = IRQ_TYPE_LEVEL_LOW;
> > >> +	else if (trigger == ACPI_LEVEL_SENSITIVE &&
> > >> +				polarity == ACPI_ACTIVE_HIGH)
> > >> +		irq_type = IRQ_TYPE_LEVEL_HIGH;
> > >> +	else
> > >> +		irq_type = IRQ_TYPE_NONE;
> > >> +
> > >> +	/*
> > >> +	 * Since only one GIC is supported in ACPI 5.0, we can
> > >> +	 * create mapping refer to the default domain
> > >> +	 */
> > >> +	irq = irq_create_mapping(NULL, gsi);
> > >> +	if (!irq)
> > >> +		return irq;
> > >> +
> > >> +	/* Set irq type if specified and different than the current one */
> > >> +	if (irq_type != IRQ_TYPE_NONE &&
> > >> +		irq_type != irq_get_trigger_type(irq))
> > >> +		irq_set_irq_type(irq, irq_type);
> > >> +	return irq;
> > >> +}
> > >> +EXPORT_SYMBOL_GPL(acpi_register_gsi);
> > > I see you've still got this buried in the arch code. Is there any plan to
> > > move it out, as I moaned about this in the last version of the series and
> > > nothing seems to have changed?
> > 
> > Ah, sorry. Last time when I was in Hongkong for LCA this Feb, I
> > discussed with Lorenzo and he had a look into that too, he also met some
> > obstacles to do that, so Lorenzo said that he will talk to you about
> > this (Lorenzo, correct me if I'm wrong due to hearing problems of much
> > noise in that room where we were talking).
> > 
> > Anyway, if we move those functions to core code, such as irqdomain code,
> > which will be compiled for x86 too, we can only set those functions as
> > _weak, or we guard with them as #ifdef CONFIG_ARM64 ... #endif, so for
> > me, it's really not a big deal to move those code out of arch/arm64, but
> > I'm still open for suggestions if you can do that in a proper way.
> 
> You heard me clear and sound in HK, Will has a point and I looked into
> this. Code is generic but not enough to be useful on other arches at
> the moment, I need more time to look into this and see if we can move
> this code to acpi core in a way that makes sense, to have, as you say,
> a "default" implementation.

Yeah, just something guarded by a CONFIG option (probably not ARM64
though) would be enough, I think. Nothing too fancy.

Will
