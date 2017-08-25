From: panand@redhat.com (Pratyush Anand)
Date: Fri, 25 Aug 2017 11:35:40 +0530
Subject: [PATCH v3 0/5] ARM64: disable irq between breakpoint and step
 exception
In-Reply-To: <cover.1501496603.git.panand@redhat.com>
References: <cover.1501496603.git.panand@redhat.com>
Message-ID: <a9263c7e-032a-93b5-af77-b6099642d426@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark, James and Will,

What is the take on this series?

Just to summarize:

- James took first three patches of the series and replaced 4th and 5th patch 
with his 3 patch series [3].
- My patchset disables interrupt while exiting from HW breakpoint/watchpoint 
and SW breakpoint handlers, and re-enables after single step handling..but it 
will work reliably for single stepping even if an interrupt is generated 
during  breakpoint/watchpoint handler execution.
- James's approach keeps interrupt enabled, but it might fail if a hardware 
breakpoint is instrumented on an ISR called between breakpoint and step exception.

@James, I understand there would be other things on priority..do you have a 
plan to fix the pitfall and send a new series. If not, can I address Peter's 
concern on patch 1/5 and send v4?

[3] https://www.spinics.net/lists/arm-kernel/msg598214.html

On Monday 31 July 2017 04:10 PM, Pratyush Anand wrote:
> v2 -> v3
> - Moved step_needed from uapi structure to kernel only structure
> - Re-enable interrupt if stepped instruction faults
> - Modified register_wide_hw_breakpoint() to accept step_needed arg
> v2 was here: http://marc.info/?l=linux-arm-kernel&m=149942910730496&w=2
> 
> v1 -> v2:
> - patch 1 of v1 has been modified to patch 1-3 of v2.
> - Introduced a new event attribute step_needed and implemented
>    hw_breakpoint_needs_single_step() (patch 1)
> - Replaced usage of is_default_overflow_handler() with
>    hw_breakpoint_needs_single_step(). (patch 2)
> - Modified sample test to set set step_needed bit field (patch 3)
> v1 was here: http://marc.info/?l=linux-arm-kernel&m=149910958418708&w=2
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
> Since, it also takes care of SW breakpoint, so I hope kgdb should also be
> fine. However, I have not tested that.
> @Takahiro: Will it be possible to test these patches for kgdb.
> 
> [1] http://marc.info/?l=linux-arm-kernel&m=149580777524910&w=2
> [2] http://lists.infradead.org/pipermail/linux-arm-kernel/2016-April/425266.html
> 
> 
> Pratyush Anand (5):
>    hw_breakpoint: Add step_needed event attribute
>    arm64: use hw_breakpoint_needs_single_step() to decide if step is
>      needed
>    register_wide_hw_breakpoint(): modify to accept step_needed arg
>    arm64: disable irq between breakpoint and step exception
>    arm64: fault: re-enable irq if it was disabled for single stepping
> 
>   arch/arm64/kernel/debug-monitors.c      |  3 +++
>   arch/arm64/kernel/hw_breakpoint.c       | 10 +++++-----
>   arch/arm64/mm/fault.c                   | 28 ++++++++++++++++++++++++----
>   arch/x86/kernel/kgdb.c                  |  2 +-
>   include/linux/hw_breakpoint.h           | 10 ++++++++--
>   include/linux/perf_event.h              |  6 ++++++
>   kernel/events/core.c                    |  2 ++
>   kernel/events/hw_breakpoint.c           |  4 +++-
>   samples/hw_breakpoint/data_breakpoint.c |  3 ++-
>   9 files changed, 54 insertions(+), 14 deletions(-)
> 

-- 
Regards
Pratyush
