From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 23 Jan 2015 15:38:08 +0000
Subject: [PATCH v2] arm64: kernel: remove ARM64_CPU_SUSPEND config option
In-Reply-To: <1418896785-21929-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1418896785-21929-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20150123153808.GC9557@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 18, 2014 at 09:59:45AM +0000, Lorenzo Pieralisi wrote:
> ARM64_CPU_SUSPEND config option was introduced to make code providing
> context save/restore selectable only on platforms requiring power
> management capabilities.
> 
> Currently ARM64_CPU_SUSPEND depends on the PM_SLEEP config option which
> in turn is set by the SUSPEND config option.
> 
> The introduction of CPU_IDLE for arm64 requires that code configured
> by ARM64_CPU_SUSPEND (context save/restore) should be compiled in
> in order to enable the CPU idle driver to rely on CPU operations
> carrying out context save/restore.
> 
> The ARM64_CPUIDLE config option (ARM64 generic idle driver) is therefore
> forced to select ARM64_CPU_SUSPEND, even if there may be (ie PM_SLEEP)
> failed dependencies, which is not a clean way of handling the kernel
> configuration option.
> 
> For these reasons, this patch removes the ARM64_CPU_SUSPEND config option
> and makes the context save/restore dependent on CPU_PM, which is selected
> whenever either SUSPEND or CPU_IDLE are configured, cleaning up dependencies
> in the process.
> 
> This way, code previously configured through ARM64_CPU_SUSPEND is
> compiled in whenever a power management subsystem requires it to be
> present in the kernel (SUSPEND || CPU_IDLE), which is the behaviour
> expected on ARM64 kernels.
> 
> The cpu_suspend and cpu_init_idle CPU operations are added only if
> CPU_IDLE is selected, since they are CPU_IDLE specific methods and
> should be grouped and defined accordingly.
> 
> PSCI CPU operations are updated to reflect the introduced changes.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

Applied. Thanks.

-- 
Catalin
