From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 17 Jan 2018 18:24:04 +0000
Subject: per-task stack canaries for arm64
Message-ID: <CAKv+Gu_rdDEQeBYabZCOywws96mTWF4F=JEpVNXEW76tAwo1Rw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is a followup to a discussion I had with Ramana in San Francisco
5 months ago. Apologies for the tardiness.

The topic of the discussion was compiler support for per-task stack
cookies in the arm64 kernel. From the compiler side, this would simply
entail offsetting the address of __stack_chk_guard with value held in
tpidr_el1, so we can make it a per-CPU variable. On the kernel side,
we would need fairly straight-forward plumbing to detect the compiler
support, and switching to a per-CPU variable when supported. Beyond
that, we need to update the per-CPU value at context switch time, and
perhaps some handling of the initial state when per-CPU variables are
initialized.

Ramana indicated at the time that he would be up for adding, e.g.,
-fstack-protector-linux-kernel as a command line option, and add the
contents of tpidr_el1 to every reference of __stack_chk_guard when
set.

Would this be sufficient to implement this from the kernel side? Am I
missing anything here? I am missing the cross-arch context entirely,
so are there things we should take into account and/or learn from?

Comments welcome.
