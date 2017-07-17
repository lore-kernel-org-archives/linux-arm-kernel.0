From: panand@redhat.com (Pratyush Anand)
Date: Mon, 17 Jul 2017 08:51:04 +0530
Subject: [PATCH V2 0/4] ARM64: Fix irq generation between breakpoint and
 step exception
In-Reply-To: <cover.1499416107.git.panand@redhat.com>
References: <cover.1499416107.git.panand@redhat.com>
Message-ID: <45e8f432-8786-2cb1-421e-e4093167c57a@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Friday 07 July 2017 05:33 PM, Pratyush Anand wrote:
> v1 was here http://marc.info/?l=linux-arm-kernel&m=149910958418708&w=2
>
> v1 -> v2:
> - patch 1 of v1 has been modified to patch 1-3 of v2.
> - Introduced a new event attribute step_needed and implemented
>   hw_breakpoint_needs_single_step() (patch 1)
> - Replaced usage of is_default_overflow_handler() with
>   hw_breakpoint_needs_single_step(). (patch 2)
> - Modified sample test to set set step_needed bit field (patch 3)
>
> samples/hw_breakpoint/data_breakpoint.c passes with x86_64 but fails with
> ARM64. Even though it has been NAKed previously on upstream [1, 2], I have
> tried to come up with patches which can resolve it for ARM64 as well.
>
> I noticed that even perf step exception can go into an infinite loop if CPU
> receives an interrupt while executing breakpoint/watchpoint handler. So,
> event though we are not concerned about above test, we will have to find a
> solution for the perf issue.
>
> This patchset attempts to resolve both the issue. Please review.

Any comments/feedback?

>
> [1] http://marc.info/?l=linux-arm-kernel&m=149580777524910&w=2
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425266.html
>
> Pratyush Anand (4):
>   hw_breakpoint: Add step_needed event attribute
>   arm64: use hw_breakpoint_needs_single_step() to decide if step is
>     needed
>   hw-breakpoint: sample test: set step_needed bit field
>   arm64: disable irq between breakpoint and step exception
>
>  arch/arm64/kernel/debug-monitors.c      |  3 +++
>  arch/arm64/kernel/hw_breakpoint.c       | 10 +++++-----
>  arch/arm64/mm/fault.c                   | 22 ++++++++++++++++++----
>  include/linux/hw_breakpoint.h           |  6 ++++++
>  include/uapi/linux/perf_event.h         |  3 ++-
>  kernel/events/core.c                    |  2 ++
>  samples/hw_breakpoint/data_breakpoint.c |  1 +
>  tools/include/uapi/linux/perf_event.h   |  3 ++-
>  8 files changed, 39 insertions(+), 11 deletions(-)
>

--
Pratyush
