From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 27 Aug 2014 17:58:15 +0100
Subject: [PATCH 3/6] arm64: Add support for hooks to handle undefined
 instructions
In-Reply-To: <9hhy4ube1tz.fsf@arm.com>
References: <1409048930-21598-1-git-send-email-punit.agrawal@arm.com>
 <1409048930-21598-4-git-send-email-punit.agrawal@arm.com>
 <20140826131339.GO23445@arm.com> <9hhy4ube1tz.fsf@arm.com>
Message-ID: <20140827165815.GG13850@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 03:56:56PM +0100, Punit Agrawal wrote:
> Will Deacon <will.deacon@arm.com> writes:
> > On Tue, Aug 26, 2014 at 11:28:47AM +0100, Punit Agrawal wrote:
> >> Add support to register hooks for undefined instructions. The handlers
> >> will be called when the undefined instruction and the processor state
> >> (as contained in pstate) match criteria used at registration.
> >> 
> >> Note: The patch only deals with ARM instruction encodings and needs
> >> fixing to handle thumb instructions as well.
> >
> > [...]
> >
> >> +static int call_undef_hook(struct pt_regs *regs)
> >> +{
> >> +	struct undef_hook *hook;
> >> +	unsigned long flags;
> >> +	u32 instr;
> >> +	int (*fn)(struct pt_regs *regs, u32 instr) = NULL;
> >> +	void __user *pc = (void __user *)instruction_pointer(regs);
> >> +
> >> +	/*
> >> +	 * Currently, undefined instruction patching is only supported
> >> +	 * for user mode. Also, as we're not emulating any thumb
> >> +	 * instructions lets not add thumb instruction decoding until
> >> +	 * it is needed.
> >> +	 */
> >> +	if (!compat_user_mode(regs) || compat_thumb_mode(regs))
> >> +		return 1;

[...]

> > I don't see anything
> > in the mechanism that means this can't be reused for kernel code, then we
> > just register the SWP emulation hook for userspace only using the mode (like
> > we do for kgdb).
> 
> There's nothing in the mechanism to prevent it's use for kernel code. I
> was erring on the side of caution as I hadn't tested it.

I don't think we even have a guaranteed undefined instruction for
AArch64, so I don't see the point of undef hook for kernel. But we could
implement different entry paths rather than just one do_undefinstr:
do_aarch64_undef, do_aarch32_undef (or maybe kernel/user split where the
kernel one just panics).

-- 
Catalin
