From: rob.lee@linaro.org (Rob Lee)
Date: Thu, 1 Mar 2012 14:42:32 -0600
Subject: [PATCH v7 1/9] cpuidle: Add common time keeping and irq enabling
In-Reply-To: <4F4EF7FC.9040403@linux.vnet.ibm.com>
References: <1330562578-3410-1-git-send-email-rob.lee@linaro.org>
 <1330562578-3410-2-git-send-email-rob.lee@linaro.org>
 <4F4EF7FC.9040403@linux.vnet.ibm.com>
Message-ID: <CAMXH7KHn-bLckyXKv3mWM6GY8DQ7yJY9kLteM-xRCFWFTH1Gew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Deepthi,

On Wed, Feb 29, 2012 at 10:15 PM, Deepthi Dharwar
<deepthi@linux.vnet.ibm.com> wrote:
> Hi Rob,
>
> On 03/01/2012 06:12 AM, Robert Lee wrote:
>
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. ?This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>
>
> The generic cpuidle changes look good, but is there a reason as
> to why these changes are enabled only for ARM and not other
> archs ?
>

Besides ARM, this patchset also enables some of this new consolidation
functionality on arch/SH and for archs that use the
CONFIG_ARCH_HAS_CPU_RELAX (maybe x86 uses this?).

For the powerpc P-series, it could probably could be modified to use
the consolidated timekeeping but I didn't feel comfortable making that
change myself for a couple of reasons.  First, the common wrapper also
includes the local_irq_enable() call, but the p-series cpuidle code
doesn't include this call, as instead, it relies on the
local_irq_enable() call in the cpu_idle() function in
arch/powerpc/kernel/idle.c.  Is it OK to remove this
local_irq_enable() once the wrapper is used?  Second, is there any
special coordination needed with the timekeeping functions and the
mfspr() calls?

Looking at the intel and acpi cpuidle implementations, their current
organization does seem to be able to use the common time keeping / irq
enabling wrapper.  Upon first glance, it appears that there are
special timer/timekeeping requirements for x86 that aren't required by
other platforms.  But that may not be correct.

If you look back at v4 of this patch series, you'll see an attempt at
a common timekeeping that could be used by x86 and acpi , but it
causes other compromises that to me aren't worth the extra gain from a
100% common timekeeping / irq enable solution.  I requested
feedback/opinions on this issue after v4 but didn't hear anything
about changes made to the intel or acpi implementations.  So I
continued on with the common wrapper direction from v3 when making v5.

Ultimately, even if the consolidated code only can be used by most and
not all arch or platform cpuidle implementations, it still reduces
some platform cpuidle fragmentation and duplicated code and hopefully
improves the maintainability of the core cpuidle.
