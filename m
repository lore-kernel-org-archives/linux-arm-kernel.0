From: will.deacon@arm.com (Will Deacon)
Date: Mon, 3 Apr 2017 10:42:38 +0100
Subject: [PATCH] arm64: ptrace: Crystallise the pt_regs->syscallno = ~0UL
 idiom
In-Reply-To: <1490370933-24057-1-git-send-email-Dave.Martin@arm.com>
References: <1490370933-24057-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20170403094237.GB5706@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Fri, Mar 24, 2017 at 03:55:33PM +0000, Dave Martin wrote:
> Assigning ~0UL to pt_regs->syscallno to indicate that a task is not
> executing a syscall is a little obscure.
> 
> This patch defines a helper zap_syscall() to make users of this
> idiom and its intent a bit more readable.  This concept allows
> relaxations to the system call ABI whereby not all userspace state
> need be preserved by the kernel around an explicit syscall.  The
> Scalable Vector Extension ABI will make use of this with regard
> to the extra register state added by SVE.
> 
> No relaxation of the _existing_ system call ABI is implied here.

Whilst I'm not against this cleanup, I'm also not sure that it goes far
enough.  For example, lib/syscall.c treats syscall_get_nr returning '-1L' as
"not in syscall" and it also looks like negative values can propagate into
seccomp and audit via the same "syscall_get_nr" interface.

So I worry that wrapping this up in "zap_syscall" hides the fact that
the value being set is so important (it's even used in entry.S!), but
without changing the code that actually reads and checks against the magic
value. I'd sooner add zap_syscall to asm/syscall.h alongside something
like "in_syscall", which can be used instead of open-coded checks.

What do you reckon?

Will
