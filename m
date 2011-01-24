From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jan 2011 16:18:17 -0000
Subject: [RFC][PATCH] ARM: ptrace: remove single-step emulation code
In-Reply-To: <84r5c2hbpo.fsf@sauna.l.org>
References: <1295449635-4292-1-git-send-email-will.deacon@arm.com>
	<84r5c2hbpo.fsf@sauna.l.org>
Message-ID: <000501cbbbe2$4fb55d00$ef201700$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Timo,

> I agree that decoding ARM instruction in kernel space is really
> funky. Perhaps my best be would be to copy the old kernel code to my
> own userland tool and use PTRACE_POKETEXT to set breakpoints? The only
> drawbacks I see are:

You could copy the old code, but it may need updating to support ARMv7.
It also doesn't handle Thumb instructions as it stands.
 
> 1) I need more syscalls per instruction: PTRACE_GETREGS +
> PTRACE_SINGLESTEP vs. PTRACE_GETREGS + PTRACE_PEEKTEXT +
> PTRACE_POKETEXT * (number of potential branch targets) +
> PTRACE_CONTINUE but I guess I can live with this.

Ok.

> 2) itrace does not know where user helpers are. Parsing
> /proc/config.gz at runtime for CONFIG_VECTORS_BASE is probably not a
> good idea. If this location does not change often it is not a problem
> to hardcode it in itrace.
> 
> > GDB, for example, uses PTRACE_POKETEXT and PTRACE_PEEKTEXT to manage
> > breakpoints itself and does not require any kernel assistance.
> 
> I was going to say that GDB does not work either with user helpers but
> it seems that in
> 
> commit 52d6c8167d4e91d89bc5c26cf0bacc2200272f96
> Author: Julian Brown <julian@codesourcery.com>
> Date:   Thu Jul 30 23:05:00 2009 +0000
> 
> the function arm_catch_kernel_helper_return was added to GDB. They
> hard code 0xffff0000 but I guess that is ok?

I think it's always mapped at the high address if you have an MMU, so
you might need to detect the uclinux case.

Will
