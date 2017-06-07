From: rostedt@goodmis.org (Steven Rostedt)
Date: Wed, 7 Jun 2017 11:46:37 -0400
Subject: [PATCH v2 2/2] arm64: ftrace: add support for far branches to
 dynamic ftrace
In-Reply-To: <20170605171535.GP21944@arm.com>
References: <20170530135220.20759-1-ard.biesheuvel@linaro.org>
 <20170530135220.20759-3-ard.biesheuvel@linaro.org>
 <20170605171535.GP21944@arm.com>
Message-ID: <20170607114637.1a717019@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jun 2017 18:15:35 +0100
Will Deacon <will.deacon@arm.com> wrote:


> > +		tramp = (unsigned long *)mod->arch.ftrace_trampoline->sh_addr;
> > +		if (tramp[0] != addr) {
> > +			if (tramp[0] != 0) {
> > +				pr_err("ftrace: far branches to multiple entry points unsupported inside a single module\n");
> > +				return AARCH64_BREAK_FAULT;
> > +			}
> > +
> > +			/* point the trampoline to our ftrace entry point */
> > +			module_disable_ro(mod);
> > +			tramp[0] = addr;
> > +			module_enable_ro(mod, true);  
> 
> I'm not sure what the barrier semantics are for module_enable_ro, but I'd be
> inclined to stick in a smp_wmb() here to order the write of the trampoline
> data before the writing of the branch instruction.

I would assume that module_disable/enable_ro() has proper barriers for
modifying the page tables with respect to code around it, otherwise it
would probably be an issues elsewhere in the kernel. Specifically in
the module code itself.

I don't see how a smp_wmb() would be needed here, especially since this
is serialized code, and not something done by multiple CPUs.

-- Steve

> 
> Will
> 
> > +		}
> > +		addr = (unsigned long)&tramp[1];
> > +	}
> > +	return aarch64_insn_gen_branch_imm(pc, addr, AARCH64_INSN_BRANCH_LINK);
> > +}
> > +  
