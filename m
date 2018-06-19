From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 19 Jun 2018 14:15:24 +0100
Subject: [PATCHv3 10/19] arm64: convert native/compat syscall entry to C
In-Reply-To: <20180619121814.GR22983@e103592.cambridge.arm.com>
References: <20180618120310.39527-1-mark.rutland@arm.com>
 <20180618120310.39527-11-mark.rutland@arm.com>
 <20180619121814.GR22983@e103592.cambridge.arm.com>
Message-ID: <20180619130932.ww53s5rnragcodha@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 01:18:17PM +0100, Dave Martin wrote:
> On Mon, Jun 18, 2018 at 01:03:01PM +0100, Mark Rutland wrote:
> > +static inline void sve_user_reset(void)
> > +{
> 
> Can we call this "sve_user_discard" please?
> 
> "Reset" is a reasonable name for the concept, but the "discard"
> terminology has been used elsewhere.

Sure; done.

> > +	if (!system_supports_sve())
> > +		return;
> > +
> > +	/*
> > +	 * task_fpsimd_load() won't be called to update CPACR_EL1 in
> > +	 * ret_to_user unless TIF_FOREIGN_FPSTATE is still set, which only
> > +	 * happens if a context switch or kernel_neon_begin() or context
> > +	 * modification (sigreturn, ptrace) intervenes.
> > +	 * So, ensure that CPACR_EL1 is already correct for the fast-path case.
> > +	 */
> 
> This comment should go after clear_thead_flag(), since it describes not
> the purpose of this function but the presence of sve_user_disable().
> 
> > +	clear_thread_flag(TIF_SVE);
> > +	sve_user_disable();
> > +}

Good point. I've moved the clear_thread_flag(TIF_SVE) above the comment
(with a blank line before the comment).

Thanks,
Mark.
