From: kmcmarti@redhat.com (Kyle McMartin)
Date: Thu, 15 May 2014 12:45:52 -0400
Subject: [PATCH] arm64: don't set READ_IMPLIES_EXEC for EM_AARCH64
In-Reply-To: <20140515090535.GB27594@arm.com>
References: <20140514185720.GI26038@redacted.bos.redhat.com>
 <20140515090535.GB27594@arm.com>
Message-ID: <20140515164552.GB15570@redacted.bos.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 15, 2014 at 10:05:35AM +0100, Will Deacon wrote:
> Unfortunately, my understanding is that GCC currently requires this for
> nested functions, so this is an effective ABI breakage. On the plus side,
> the GCC guys are planning to fix that, so we should see PT_GNU_STACK getting
> used more frequently in the future.
> 

nested functions are a GNU extension, and aside from grub, I don't
think anyone really uses them. (At least, I certainly hope not.) Also,
ld.so already has a different idea from the kernel:
master at glibc:.% git grep DEFAULT_STACK_PERMS -- sysdeps/aarch64
(kyle at dreadnought:~/src/glibc)
sysdeps/aarch64/stackinfo.h:#define DEFAULT_STACK_PERMS (PF_R|PF_W)

ppc64 also does similarly, where they use the EXSTACK_DEFAULT in the
compat case, but their 64-bit ABI doesn't.

108 # define elf_read_implies_exec(ex, exec_stk) (is_32bit_task() ? \
109                 (exec_stk == EXSTACK_DEFAULT) : 0)

I've submitted a gcc patch to emit .note.GNU-stack on AArch64 (which I
suspect was just an oversight initially.) Which will mean that anything
that puts code on the stack will be annotated to require executable
stacks.

And, frankly, I think it's kind of strange to have any of the personality
bits set by default.

regards, Kyle
