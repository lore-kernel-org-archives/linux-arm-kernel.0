From: akpm@linux-foundation.org (Andrew Morton)
Date: Mon, 29 Feb 2016 16:49:56 -0800
Subject: [PATCH 0/4] improvements to the nmi_backtrace code
In-Reply-To: <1456782024-7122-1-git-send-email-cmetcalf@ezchip.com>
References: <1456782024-7122-1-git-send-email-cmetcalf@ezchip.com>
Message-ID: <20160229164956.8613016895bef966b6460081@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Feb 2016 16:40:20 -0500 Chris Metcalf <cmetcalf@ezchip.com> wrote:

> This patch series modifies the trigger_xxx_backtrace() NMI-based
> remote backtracing code to make it more flexible, and makes a few
> small improvements along the way.
> 
> The motivation comes from the task isolation code, where there are
> scenarios where we want to be able to diagnose a case where some cpu
> is about to interrupt a task-isolated cpu.  It can be helpful to
> see both where the interrupting cpu is, and also an approximation
> of where the cpu that is being interrupted is.  The nmi_backtrace
> framework allows us to discover the stack of the interrupted cpu.
> 
> The first change adds support for trigger_single_cpu_backtrace(), and
> as an "API side-effect", trigger_cpumask_backtrace().  The underlying
> abstraction is changed to use cpumasks instead of a "bool except_self".
> 
> The second and third changes provide small improvements to the
> behavior of the existing nmi_backtrace code: omitting full backtrace
> dumps for idle cores, and doing local dump_stack backtraces when we
> try to do a "remote" dump of the local core.  Some of this reflects
> changes from integrating the arch/tile code into the generic code.
> 
> The fourth change hooks the arch/tile backtrace mechanism into
> the nmi_backtrace code to share code and take advantage of other
> improvements of nmi_backtrace not present in the original arch/tile
> code, like co-opting printk to use local buffers instead of just
> spewing to the console and hoping for the best.
> 
> The changes have been runtime tested on tile, and build-tested on
> x86 and arm.

The patchset looks rather nice but unfortuntely conflicts pretty
significantly with Petr's "Cleaning printk stuff in NMI context"
patchset:

http://ozlabs.org/~akpm/mmots/broken-out/printk-nmi-generic-solution-for-safe-printk-in-nmi.patch
http://ozlabs.org/~akpm/mmots/broken-out/printk-nmi-use-irq-work-only-when-ready.patch
http://ozlabs.org/~akpm/mmots/broken-out/printk-nmi-warn-when-some-message-has-been-lost-in-nmi-context.patch
http://ozlabs.org/~akpm/mmots/broken-out/printk-nmi-increase-the-size-of-nmi-buffer-and-make-it-configurable.patch

Could we please have a think about what to do about this?

Petr's patchset does have a few outstanding issues (a bug reported by
Sergey Senozhatsky and noncommittal review comments from Daniel
Thompson) so one approach would be to merge this (Chris's) patchset
(which looks rather more straightforward) and to ask Petr to rebase
things on top once he gets back onto his work.

Thanks.
