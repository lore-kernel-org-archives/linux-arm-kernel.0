From: robh@kernel.org (Rob Herring)
Date: Thu, 14 Jan 2016 20:50:30 -0600
Subject: [PATCH v4 1/1] ARM: perf: Set ARMv7 SDER SUNIDEN bit
In-Reply-To: <20160114043626.GA45778@gandalf.middle.earth.net>
References: <20140805144831.25462.18149.stgit@localhost>
 <20140805144833.25462.46011.stgit@localhost>
 <20140806104947.GD25953@arm.com> <53E22E0B.7080907@parkeon.com>
 <20140807173316.GH31101@arm.com>
 <20160106145500.GA92797@gandalf.middle.earth.net>
 <20160112171109.GJ15737@arm.com>
 <20160114043626.GA45778@gandalf.middle.earth.net>
Message-ID: <20160115025030.GA8883@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 13, 2016 at 11:36:26PM -0500, George G. Davis wrote:
> From: Martin Fuzzey <mfuzzey@parkeon.com>
> 
> ARMv7 counters other than the CPU cycle counter only work if the Secure
> Debug Enable Register (SDER) SUNIDEN bit is set.
> 
> Since access to the SDER is only possible in secure state, it will
> only be done if the device tree property "secure-reg-access" is set.
> 
> Without this:
> # perf stat -e cycles,instructions sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>           14606094 cycles                    #    0.000 GHz
>                  0 instructions              #    0.00  insns per cycle
> 
> After applying:
> # perf stat -e cycles,instructions sleep 1
> 
>  Performance counter stats for 'sleep 1':
> 
>            5843809 cycles
>            2566484 instructions              #    0.44  insns per cycle
> 
>        1.020144000 seconds time elapsed
> 
> Some platforms (eg i.MX53) may also need additional platform specific
> setup.
> 
> Signed-off-by: Martin Fuzzey <mfuzzey@parkeon.com>
> Signed-off-by: Pooya Keshavarzi <Pooya.Keshavarzi@de.bosch.com>
> Signed-off-by: George G. Davis <george_davis@mentor.com>
> ---
> Changes in v4:
> - Reword commit message to clarify that this change is ARMv7 specific.
> - Clarify that secure-reg-access property is only valid for ARMv7 CPUs
>   and is not supported on anything else (in particular, the arm64
>   port requires you to boot in non-secure mode).
> - Convert on_each_cpu(armv7pmu_enable_secure_access, NULL, 1) call in
>   armv7pmu_init() to in-lined code in ->reset callback, since that is
>   called off the back of a CPU hotplug notifier when the PMU may need
>   to be reinitialised.
> Changes in v3:
> - Pooya Keshavarzi:
>   * v2 review comment fixups
>   * Use on_each_cpu() to set SUNIDEN on all CPUs
>   * Move armv7pmu_enable_secure_access() call from armv7pmu_start() to
>     armv7_a8_map_event() such that is called only once instead of each
>     time `perf` is executed
> - George G. Davis:
>   * Fixup to apply after file renames due to commit fa8ad78 (arm: perf:
>     factor arm_pmu core out to drivers)
>   * Fix checkpatch 'CHECK: Prefer using the BIT macro' issue
> ---
>  Documentation/devicetree/bindings/arm/pmu.txt | 10 ++++++++++

Acked-by: Rob Herring <robh@kernel.org>

Rob
