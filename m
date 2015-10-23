From: olof@lixom.net (Olof Johansson)
Date: Fri, 23 Oct 2015 09:59:02 -0700
Subject: [PATCH] drivers: psci: make PSCI 1.0 functions initialization
 version dependent
In-Reply-To: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
References: <1445611610-12871-1-git-send-email-lorenzo.pieralisi@arm.com>
Message-ID: <20151023165902.GA2224@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 03:46:50PM +0100, Lorenzo Pieralisi wrote:
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

Bummer. It'd been nice to catch this before merging, especially since
the branch had been around a while.

Anyway, I applied this to a drivers/psci2 branch that builds on top of the
previous one. Please use psci2 as the base for other trees, so that mainline
won't regress in case they get merged before our stuff.


-Olof
