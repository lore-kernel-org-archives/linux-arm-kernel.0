From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 13 Feb 2018 12:36:02 +0000
Subject: revisit arm64 per-task stack canaries
Message-ID: <CAKv+Gu9RAXhMAwKJgNAZEBZRMNfpyDNS-rxa+U2EpNxEVq77vQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello all,

I guess my most recent emails kind of got lost in the avalanche of
Meltdown/Spectre related activities.

Now that the dust seems to have settled a bit, may I kindly bring this
topic to your attention again?

In summary, the default aarch64 way of using a single value for the
stack canary for all threads sharing an address space severely limits
the kernel's ability to implement stack canaries in a meaningful way.

Originally, we assumed that the only way to overcome this was to
implement per-CPU stack canaries, where each CPU loads the stack
canary of the task it executes at context switch. This is racy and
cumbersome in the presence of kernel support of VHE, which means the
per-CPU thread ID register is not fixed at compile time.

Instead, I have proposed a proof of concept [0] where the compiler
emits an instruction sequence that loads the canary directly from the
task struct, which is the per-thread data structure maintained by the
kernel. Accessing that can be done safely without any of the
limitations per-CPU variables have. The task struct pointer is kept in
system register sp_el0 while running in the kernel.

The purpose of this email to reach agreement between the various
stakeholders (mainly the arm64 linux maintainers and the ARM GCC
maintainers) on a way to proceed with implementing this in GCC.

So please, do share your opinions and questions on this matter, so
that we can settle this matter asap.

Kind regards,
Ard.


[0] http://www.workofard.com/2018/01/per-task-stack-canaries-for-arm64/
