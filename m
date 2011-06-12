From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 16:14:22 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring
	proc_info structs
In-Reply-To: <20110612082220.GB10283@n2100.arm.linux.org.uk>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
	<20110609173836.GF24424@n2100.arm.linux.org.uk>
	<20110610085752.GA2129@arm.com>
	<20110612082220.GB10283@n2100.arm.linux.org.uk>
Message-ID: <20110612151422.GJ10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 12, 2011 at 09:22:21AM +0100, Russell King - ARM Linux wrote:
> On Fri, Jun 10, 2011 at 09:57:52AM +0100, Dave Martin wrote:
> > On Thu, Jun 09, 2011 at 06:38:36PM +0100, Russell King - ARM Linux wrote:
> > > It does look very much like a sledge hammer to me.  All we're really
> > > after is whether the size of the region is what we expect it to be -
> > > which will tell us whether there's a T2 instruction in there.
> > 
> > True, although the intent was no to solve just that one problem,
> > but to show how to avoid a whole variety of trivial mistakes.
> > Since proc_info structs don't tend to get changed much after
> > they're initially written, I guess that such mistakes don't actually
> > occur very often, though.
> 
> We have several other structures encoded in assembly - and to do this
> for every one would be excessive.  The amount of churn produced too
> would be large.
> 
> Historically we've had little problem with these structs being wrong -
> about once or twice pre-Thumb for a decade IIRC (where at least one was
> down to "using an old patch but didn't update it properly for the new
> proc-*.S files".)

What may be worth doing is something like this, where all entries follow
a well defined naming scheme:

	.macro	processor_functions, name, dabort, pabort, suspend, nommu
	.type	\name\()_processor_functions, #object
ENTRY(\name\()_processor_functions)
	.word	\dabort\()_abort
	.word	\pabort\()_pabort
	.word	cpu_\name\()_proc_init
	.word	cpu_\name\()_proc_fin
	.word	cpu_\name\()_reset
	.word	cpu_\name\()_do_idle
	.word	cpu_\name\()_dcache_clean_area
	.word	cpu_\name\()_switch_mm
	.ifne \nommu
	.word	0
	.else
	.word	cpu_\name\()_set_pte_ext
	.endif
	.ifne \suspend
	.word	cpu_\name\()_suspend_size
	.word	cpu_\name\()_do_suspend
	.word	cpu_\name\()_do_resume
	.else
	.word	0
	.word	0
	.word	0
	.endif
	.size	\name\()_processor_functions, . - \name\()_processor_functions
	.endm

and this has great value to ensuring that the structure in assembly
matches what is in the headers as it means that instead of having N
places to update these structures, we're down to its header and one
macro - and also ensures that proc files which miss out on the update
won't link to an apparantly working kernel.

The cache and tlb structures follow a very similar naming scheme to
the above.

The proc_info structures are much harder to deal with because they
don't contain such commonality, but I'm sure it may be possible to
come up with something along these lines.
