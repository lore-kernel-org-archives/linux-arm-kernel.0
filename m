From: timo.lindfors@iki.fi (Timo Juhani Lindfors)
Date: Mon, 24 Jan 2011 11:50:43 +0200
Subject: [RFC][PATCH] ARM: ptrace: remove single-step emulation code
In-Reply-To: <1295449635-4292-1-git-send-email-will.deacon@arm.com> (Will
	Deacon's message of "Wed\, 19 Jan 2011 15\:07\:15 +0000")
References: <1295449635-4292-1-git-send-email-will.deacon@arm.com>
Message-ID: <84r5c2hbpo.fsf@sauna.l.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will Deacon <will.deacon@arm.com> writes:
> We could try to fix this code, but it turns out that nobody uses it anyway.

Very few people use it since it does not work :-)

I tried to use PTRACE_SINGLESTEP on ARM last year but pretty soon
noticed that it doesn't work with user helpers. I sent a patch

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-November/030832.html

and added ARM support to my really simple instruction level execution
tracing tool

http://iki.fi/lindi/git/itrace.git/

originally written mainly for my own debugging needs. The major
limitation of valgrind is that it can't attach to an already running
process and I guess it's too resource intensive to run my processes
constantly under valgrind on an embedded system.

I agree that decoding ARM instruction in kernel space is really
funky. Perhaps my best be would be to copy the old kernel code to my
own userland tool and use PTRACE_POKETEXT to set breakpoints? The only
drawbacks I see are:

1) I need more syscalls per instruction: PTRACE_GETREGS +
PTRACE_SINGLESTEP vs. PTRACE_GETREGS + PTRACE_PEEKTEXT +
PTRACE_POKETEXT * (number of potential branch targets) +
PTRACE_CONTINUE but I guess I can live with this.

2) itrace does not know where user helpers are. Parsing
/proc/config.gz at runtime for CONFIG_VECTORS_BASE is probably not a
good idea. If this location does not change often it is not a problem
to hardcode it in itrace.

> GDB, for example, uses PTRACE_POKETEXT and PTRACE_PEEKTEXT to manage
> breakpoints itself and does not require any kernel assistance.

I was going to say that GDB does not work either with user helpers but
it seems that in

commit 52d6c8167d4e91d89bc5c26cf0bacc2200272f96
Author: Julian Brown <julian@codesourcery.com>
Date:   Thu Jul 30 23:05:00 2009 +0000

the function arm_catch_kernel_helper_return was added to GDB. They
hard code 0xffff0000 but I guess that is ok?
