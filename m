From: atomlin@redhat.com (Aaron Tomlin)
Date: Thu, 14 Apr 2016 16:19:33 +0100
Subject: [PATCH v5 2/4] nmi_backtrace: do a local dump_stack() instead of
 a self-NMI
In-Reply-To: <1459877208-15119-3-git-send-email-cmetcalf@mellanox.com>
References: <1459877208-15119-1-git-send-email-cmetcalf@mellanox.com>
 <1459877208-15119-3-git-send-email-cmetcalf@mellanox.com>
Message-ID: <20160414151933.GF20425@atomlin.usersys.redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 2016-04-05 13:26 -0400, Chris Metcalf wrote:
> Currently on arm there is code that checks whether it should call
> dump_stack() explicitly, to avoid trying to raise an NMI when the
> current context is not preemptible by the backtrace IPI.  Similarly,
> the forthcoming arch/tile support uses an IPI mechanism that does
> not support generating an NMI to self.
> 
> Accordingly, move the code that guards this case into the generic
> mechanism, and invoke it unconditionally whenever we want a
> backtrace of the current cpu.  It seems plausible that in all cases,
> dump_stack() will generate better information than generating a
> stack from the NMI handler.  The register state will be missing,
> but that state is likely not particularly helpful in any case.
> 
> Or, if we think it is helpful, we should be capturing and emitting
> the current register state in all cases when regs == NULL is passed
> to nmi_cpu_backtrace().
> 
> Signed-off-by: Chris Metcalf <cmetcalf@mellanox.com>
> ---
>  arch/arm/kernel/smp.c | 9 ---------
>  lib/nmi_backtrace.c   | 9 +++++++++
>  2 files changed, 9 insertions(+), 9 deletions(-)

Thanks Chris.

Acked-by: Aaron Tomlin <atomlin@redhat.com>

-- 
Aaron Tomlin
