From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Feb 2018 12:52:01 +0000
Subject: revisit arm64 per-task stack canaries
In-Reply-To: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
References: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
Message-ID: <20180213125201.otz3cse4wftcq4fe@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 13, 2018 at 12:36:02PM +0000, Ard Biesheuvel wrote:
> Hello all,

Hi,

> In summary, the default aarch64 way of using a single value for the
> stack canary for all threads sharing an address space severely limits
> the kernel's ability to implement stack canaries in a meaningful way.
> 
> Originally, we assumed that the only way to overcome this was to
> implement per-CPU stack canaries, where each CPU loads the stack
> canary of the task it executes at context switch. This is racy and
> cumbersome in the presence of kernel support of VHE, which means the
> per-CPU thread ID register is not fixed at compile time.
> 
> Instead, I have proposed a proof of concept [0] where the compiler
> emits an instruction sequence that loads the canary directly from the
> task struct, which is the per-thread data structure maintained by the
> kernel. Accessing that can be done safely without any of the
> limitations per-CPU variables have. The task struct pointer is kept in
> system register sp_el0 while running in the kernel.

My major concern here is being tied to using sysregs in a particular
way. We might want to fiddle with that in future (e.g. using the
platform register as an optimization, or switching to a different sysreg
due to architectural extensions).

> The purpose of this email to reach agreement between the various
> stakeholders (mainly the arm64 linux maintainers and the ARM GCC
> maintainers) on a way to proceed with implementing this in GCC.

Would it be possible to have an always inline function to get the
canary, which GCC would implicitly fold into functions as necessary?

... then we could have something in a header, like:

static __always_inline unsigned long get_task_canary(void)
{
	return current->canary;
}

... which we could change in future as needs change.

Thanks,
Mark.
