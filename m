From: khilman@kernel.org (Kevin Hilman)
Date: Fri, 23 Oct 2015 08:21:44 -0700
Subject: [PATCH] drivers: psci: make PSCI 1.0 functions initialization
 version dependent
In-Reply-To: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
 (Lorenzo Pieralisi's message of "Fri, 23 Oct 2015 15:46:50 +0100")
References: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <7h611xr4on.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lorenzo Pieralisi <lorenzo.pieralisi@arm.com> writes:

> The PSCI specifications [1] and the SMC calling convention mandate
> that unimplemented functions ids must return NOT_SUPPORTED (0xffffffff)
> if a function id is called but it is not implemented.
>
> Consequently, PSCI 1.0 function ids that require the 1.0 PSCI_FEATURES
> call to be initialized:
>
> CPU_SUSPEND (psci_init_cpu_suspend())
> SYSTEM_SUSPEND (psci_init_system_suspend())
>
> call the PSCI_FEATURES function id independently of the detected
> PSCI firmware version, since, if the PSCI_FEATURES function id is not
> implemented, it must return NOT_SUPPORTED according to the PSCI
> specifications, causing the initialization functions to fail as expected.
>
> Some existing PSCI implementations (ie Qemu PSCI emulation), do not
> comply with the SMC calling convention and fail if function ids that are
> not implemented are called from the OS, causing boot failures.
>
> To solve this issue, this patch adds code that checks the PSCI firmware
> version before calling PSCI 1.0 initialization functions so that the
> OS makes sure that it is calling 1.0 functions only if the firmware
> version detected is 1.0 or greater, therefore avoiding PSCI calls
> that are bound to fail and might cause system boot failures owing
> to non-compliant PSCI firmware implementations.
>
> [1] http://infocenter.arm.com/help/topic/com.arm.doc.den0022c/DEN0022C_Power_State_Coordination_Interface.pdf
>
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
> Arnd, Kevin, Olof,
>
> this applies to current arm-soc drivers/psci branch, and solves the
> issue Kevin detected through kernelci with Qemu emulation:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2015-October/380304.html
>
> Tested on:
>
> - Juno host
> - AMD Seattle host
> - kvmtool arm64 guest (on Juno arm64 defconfig host)
> - Qemu x86 host (aarch64 emulation)
>
> A run on kernelci and consequent tested-by tags would be much appreciated,
> thanks for spotting this and for your help.

I tested manually on my local qemu that was failing without this patch,
and it works:

Tested-by: Kevin Hilman <khilman@linaro.org>

We'll add this onto arm-soc drivers/psci and then it will have a spin through
kernelci.

Thanks for the quick fix,

Kevin
