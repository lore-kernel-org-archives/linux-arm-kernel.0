From: davidb@codeaurora.org (David Brown)
Date: Fri,  1 Jun 2012 09:21:59 -0700
Subject: [PATCH] ARM: two possible fixes for the KALLSYMS build problem
Message-ID: <1338567721-19514-1-git-send-email-davidb@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In trying to build numerous targets, I've managed to reproduce the
problem with KALLSYMS enough to come up with some ideas for a fix.
Neither of these fixes affects the size of the kernel.  I've compile
tested all of the defconfigs that are present in the kernel, and
neither causes any new compilation failures (several don't build).

The first fix adjusts the alignment of the per-cpu section, in the
cases where it is blank.  If it has the same alignment as the
following section, there won't be inconsistencies in the position when
the kallsyms data is inserted.

The second fix just eliminates the per_cpu section on non-smp builds.

Either case only affects the position of an empty section, and should
have no effect on the position or size of anything else.

I think the second patch (eliminate the per-cpu section) is cleaner,
but I'm concerned about something I've missed or changed.

The second patch does make the per-cpu section smaller (since some
symbols are left out).  It also affects the position of init_end, and
may need a page alignment before it.  But, this would also suggest
that currently, on SMP, there might be a page that isn't being freed.

David Brown (1):
  ARM: Prevent KALLSYM size mismatch on ARM.

 arch/arm/kernel/vmlinux.lds.S |    3 +++
 1 file changed, 3 insertions(+)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
