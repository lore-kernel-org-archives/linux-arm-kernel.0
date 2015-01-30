From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 30 Jan 2015 10:17:09 +0000
Subject: [PATCH 2/7] pm: at91: pm_suspend: add the WFI support for ARMv7
In-Reply-To: <B256D81BAE5131468A838E5D7A243641BFD3A0C2@penmbx01>
References: <1422266617-24381-1-git-send-email-wenyou.yang@atmel.com>
 <1422266761-24487-1-git-send-email-wenyou.yang@atmel.com>
 <20150128112551.GA13253@e102568-lin.cambridge.arm.com>
 <B256D81BAE5131468A838E5D7A243641BFD38E3C@penmbx01>
 <20150129122223.GA3937@red-moon>
 <B256D81BAE5131468A838E5D7A243641BFD3A0C2@penmbx01>
Message-ID: <20150130101709.GB8787@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 30, 2015 at 07:23:21AM +0000, Yang, Wenyou wrote:

[...]

> > > > > + * Put the processor to enter the WFI state  */
> > > > > +	.macro _do_wfi
> > > >
> > > > You will have to explain why you need this, really.
> > > I don't understand your meaning.
> > 
> > I want to understand why this assembly snippet (that can be rewritten in C BTW):
> > 
> > /* Disable the processor's clock */
> > mov	tmp1, #AT91_PMC_PCK
> > str	tmp1, [pmc, #AT91_PMC_SCDR]
> > 
> > +
> > 
> > cpu_do_idle()
> > 
> > is not sufficient for you, or put it differently, why do you need this macro.
> This assembly snippet will be copied and run in the SRAM, in the period the DDR is in the self-refresh state.
> So, it can't invoke other functions generally. 

Ok, thanks for explaining, I will have a look again to check where you
use the macro to verify the code flow.

> 
> > 
> > >
> > > >
> > > > > +
> > > > > +#if defined(CONFIG_CPU_V7)
> > > > > +	/*
> > > > > +	 * Execute an ISB instruction to flush the pipeline to ensure
> > > > > +	 * that all of operations have beem completed.
> > > >
> > > > s/beem/been
> > > Thanks.
> > >
> > > >
> > > > > +	 */
> > > > > +	isb
> > 
> > This isb should not be there, unless you know a reason why it should and you
> > explain it to me.
> I encountered system lock during verifying the pm function. 
> Anyway, I will tested again whether it works after removing it. 

See above, I have to check when you switch to SRAM execution to see
if an isb is appropriate there, it is not self-explanatory.

Thank you,
Lorenzo

> 
> > 
> > > > > +
> > > > > +	/*
> > > > > +	 * Execute an ISB instruction to ensure that all of the
> > > > > +	 * CP15 register changes have been committed.
> > > > > +	 */
> > > > > +	dsb
> > > >
> > > > This is a dsb not an isb.
> > > Changed in the v2.0
> > 
> > Yes, but I still do not understand why you want to execute it before disabling the
> > clocks (I really hope that by "disabling the clocks" you mean "set the power
> > controller to a state when, on wfi execution, the clocks are gated").
> Are you meaning to execute dsb and wfi after disabling the clocks?
> 
> > 
> > >
> > > >
> > > > > +	dmb
> > > >
> > > > You have to explain why you need every single one of these barriers,
> > > > otherwise I am NAKing this patch.
> > > No need this one?
> > 
> > No, remove it.
> OK, thanks
> 
> > 
> > >
> > > >
> > > > > +
> > > > > +	/* Disable the processor's clock */
> > > > > +	mov	tmp1, #AT91_PMC_PCK
> > > > > +	str	tmp1, [pmc, #AT91_PMC_SCDR]
> > > > > +
> > > > > +	/* Execute a WFI instruction */
> > > > > +	wfi	@ Wait For Interrupt
> > > >
> > > > This one looks ok :)
> > > >
> > > > > +
> > > > > +	/*
> > > > > +	 * CPU can specualatively prefetch the instructions
> > > > > +	 * so add NOPs after WFI. Sixteen NOPs as Cortex-A5 pipeline.
> > > >
> > > > So what ? I suspect your issue is related to wfi completion on
> > > > pending IRQ. I would like to know the details that describe the
> > > > issue you are trying to solve here please.
> > > Honestly, I referred to others, I will dig more, and test it.
> > 
> > You should not copy and paste code, because:
> > 
> > 1) it might be broken
> > 2) and/or unoptimized
> > 3) and/or does not apply to your platform
> > 
> > See my suggestion above, if it does not work for you, you will report the issue and
> > we will take it from there.
> OK, thanks.
> 
> > 
> > Thanks,
> > Lorenzo
> > 
> > >
> > > >
> > > > > +	 */
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +	nop
> > > > > +#else
> > > > > +	mcr	p15, 0, tmp1, c7, c0, 4
> > > > > +#endif
> > > >
> > > > Tell us what's the problem you have to solve, first, then we will see how to fix it.
> > > >
> > > > Thanks,
> > > > Lorenzo
> > > >
> > > > > +
> > > > > +	.endm
> > > > > +
> > > > >  	.text
> > > > >
> > > > >  /*
> > > > > @@ -181,7 +233,7 @@ sdr_sr_done:
> > > > >
> > > > >  skip_disable_main_clock:
> > > > >  	/* Wait for interrupt */
> > > > > -	mcr	p15, 0, tmp1, c7, c0, 4
> > > > > +	_do_wfi
> > > > >
> > > > >  	tst	mode, #AT91_PM_SLOW_CLOCK
> > > > >  	beq	skip_enable_main_clock
> > > > > --
> > > > > 1.7.9.5
> > > > >
> > > > > --
> > > > > To unsubscribe from this list: send the line "unsubscribe
> > > > > linux-kernel" in the body of a message to
> > > > > majordomo at vger.kernel.org More majordomo info at
> > > > > http://vger.kernel.org/majordomo-info.html
> > > > > Please read the FAQ at  http://www.tux.org/lkml/
> > > > >
> > >
> > > Best Regards,
> > > Wenyou Yang
> > >
> 
> Best Regards,
> Wenyou Yang
> 
