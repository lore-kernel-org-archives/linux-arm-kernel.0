From: khilman@ti.com (Kevin Hilman)
Date: Mon, 02 Apr 2012 22:04:43 -0700
Subject: [PATCH 0/3] OMAP4: CPUidle: Add coupled idle support
References: <1333114048-26136-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <87obr9s8wk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Santosh,

Santosh Shilimkar <santosh.shilimkar@ti.com> writes:

> The series adds the coupled cpuidle support for OMAP4 based on the v2
> series posted [1]. This makes OMAP4 to support SMP cpuidle and also
> removes the hard dependency of off-lining CPU1 to trigger deeper
> C-states.
>
> I have put together a branch which is based on 3.3 kernel with
> Len Browns next branch [2] which has time keeping and other cpuidle
> patches which will mostly get merged by 3.4-rc1 and rebased coupled
> idle series from [1].

Thanks for rebasing this.

> git://gitorious.org/omap-sw-develoment/linux-omap-dev.git
> for_3.5/omap4_coupled_cpuidle-rebase

This branch by itself seems to work fine.  However, when combining with
other stuff that has merged for v3.4, it hangs during boot.  I haven't
yet isolated the problem, but it's easy to reproduce by combining your
branch with v3.4-rc1:

  git checkout -b test/coupled-v3.4 v3.4-rc1
  git merge -s recursive -X ours santosh/for_3.5/omap4_coupled_cpuidle-rebase [1]

This hangs on boot, and it seems like a coupled state deadlock because
commenting out the coupled states in the C-state creation of
cpuidle44xx.c makes it boot just fine.

Kevin


[1] There were a couple conflicts in your branch with ACPI stuff from
    v3.4-rc1 (maybe Len updated his branch?), so I just threw them
    away with a recursive/ours merge.
