From: Dave.Martin@arm.com (Dave Martin)
Date: Mon, 3 Apr 2017 11:45:01 +0100
Subject: [PATCH] arm64: ptrace: Crystallise the pt_regs->syscallno = ~0UL
 idiom
In-Reply-To: <20170403094237.GB5706@arm.com>
References: <1490370933-24057-1-git-send-email-Dave.Martin@arm.com>
 <20170403094237.GB5706@arm.com>
Message-ID: <20170403104500.GO3750@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 03, 2017 at 10:42:38AM +0100, Will Deacon wrote:
> Hi Dave,
> 
> On Fri, Mar 24, 2017 at 03:55:33PM +0000, Dave Martin wrote:
> > Assigning ~0UL to pt_regs->syscallno to indicate that a task is not
> > executing a syscall is a little obscure.
> > 
> > This patch defines a helper zap_syscall() to make users of this
> > idiom and its intent a bit more readable.  This concept allows
> > relaxations to the system call ABI whereby not all userspace state
> > need be preserved by the kernel around an explicit syscall.  The
> > Scalable Vector Extension ABI will make use of this with regard
> > to the extra register state added by SVE.
> > 
> > No relaxation of the _existing_ system call ABI is implied here.
> 
> Whilst I'm not against this cleanup, I'm also not sure that it goes far
> enough.  For example, lib/syscall.c treats syscall_get_nr returning '-1L' as
> "not in syscall" and it also looks like negative values can propagate into
> seccomp and audit via the same "syscall_get_nr" interface.
> 
> So I worry that wrapping this up in "zap_syscall" hides the fact that
> the value being set is so important (it's even used in entry.S!), but

I can at least add a comment to say that -1UL has a specific meaning
to the core code and can't be changed without breaking things elsewhere.

> without changing the code that actually reads and checks against the magic
> value. I'd sooner add zap_syscall to asm/syscall.h alongside something
> like "in_syscall", which can be used instead of open-coded checks.

I'm happy to move this to asm/syscall.h, and use it for the syscallno
poisoning in entry.S:kernel_entry.  (This is zap_syscall, but trying to
unify this between C and asm seems going a step too far.)

Cheers
---Dave
