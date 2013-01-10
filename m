From: robherring2@gmail.com (Rob Herring)
Date: Wed, 09 Jan 2013 18:46:28 -0600
Subject: [PATCH 00/16] big.LITTLE low-level CPU and cluster power
 management
In-Reply-To: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
References: <1357777251-13541-1-git-send-email-nicolas.pitre@linaro.org>
Message-ID: <50EE0F64.8020009@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/09/2013 06:20 PM, Nicolas Pitre wrote:
> This is the initial public posting of the initial support for big.LITTLE.
> Included here is the code required to safely power up and down CPUs in a
> b.L system, whether this is via CPU hotplug, a cpuidle driver or the
> Linaro b.L in-kernel switcher[*] on top of this.  Only  SMP secondary
> boot and CPU hotplug support is included at this time.  Getting to this
> point already represents a significcant chunk of code as illustrated by
> the diffstat below.
> 
> This work was presented at Linaro Connect in Copenhagen by Dave Martin and
> myself.  The presentation slides are available here:
> 
> http://www.linaro.org/documents/download/f3569407bb1fb8bde0d6da80e285b832508f92f57223c
> 
> The code is now stable on both Fast Models as well as Virtual Express TC2
> and ready for public review.
> 
> Platform support is included for Fast Models implementing the
> Cortex-A15x4-A7x4 and Cortex-A15x1-A7x1 configurations.  To allow
> successful compilation, I also included a preliminary version of the
> CCI400 driver from Lorenzo Pieralisi.
> 
> Support for actual hardware such as Vexpress TC2 should come later,
> once the basic infrastructure from this series is merged.  A few DT
> bindings are used but not yet documented.
> 
> This series is made of the following parts:
> 
> Low-level support code:
> [PATCH 01/16] ARM: b.L: secondary kernel entry code
> [PATCH 02/16] ARM: b.L: introduce the CPU/cluster power API
> [PATCH 03/16] ARM: b.L: introduce helpers for platform coherency
> [PATCH 04/16] ARM: b.L: Add baremetal voting mutexes
> [PATCH 05/16] ARM: bL_head: vlock-based first man election

After a quick scan, I have a basic question. How are any of these
specific to big.LITTLE? Isn't all this just general multi-cluster support?

Rob
> 
> Adaptation layer to hook with the generic kernel infrastructure:
> [PATCH 06/16] ARM: b.L: generic SMP secondary bringup and hotplug
> [PATCH 07/16] ARM: bL_platsmp.c: close the kernel entry gate before
> [PATCH 08/16] ARM: bL_platsmp.c: make sure the GIC interface of a
> [PATCH 09/16] ARM: vexpress: Select the correct SMP operations at
> 
> Fast Models support:
> [PATCH 10/16] ARM: vexpress: introduce DCSCB support
> [PATCH 11/16] ARM: vexpress/dcscb: add CPU use counts to the power
> [PATCH 12/16] ARM: vexpress/dcscb: do not hardcode number of CPUs
> [PATCH 13/16] drivers: misc: add ARM CCI support
> [PATCH 14/16] ARM: TC2: ensure powerdown-time data is flushed from
> [PATCH 15/16] ARM: vexpress/dcscb: handle platform coherency
> [PATCH 16/16] ARM: vexpress/dcscb: probe via device tree
> 
> Here's the diffstat:
> 
>  .../big.LITTLE/cluster-pm-race-avoidance.txt    | 498 ++++++++++++++++++
>  Documentation/arm/big.LITTLE/vlocks.txt         | 211 ++++++++
>  arch/arm/Kconfig                                |   6 +
>  arch/arm/common/Makefile                        |   3 +
>  arch/arm/common/bL_entry.c                      | 278 ++++++++++
>  arch/arm/common/bL_head.S                       | 232 ++++++++
>  arch/arm/common/bL_platsmp.c                    |  85 +++
>  arch/arm/common/gic.c                           |   6 +
>  arch/arm/common/vlock.S                         | 108 ++++
>  arch/arm/common/vlock.h                         |  43 ++
>  arch/arm/include/asm/bL_entry.h                 | 189 +++++++
>  arch/arm/include/asm/hardware/gic.h             |   2 +
>  arch/arm/include/asm/mach/arch.h                |   3 +
>  arch/arm/kernel/setup.c                         |   5 +-
>  arch/arm/mach-vexpress/Kconfig                  |   9 +
>  arch/arm/mach-vexpress/Makefile                 |   1 +
>  arch/arm/mach-vexpress/core.h                   |   2 +
>  arch/arm/mach-vexpress/dcscb.c                  | 257 +++++++++
>  arch/arm/mach-vexpress/dcscb_setup.S            |  77 +++
>  arch/arm/mach-vexpress/platsmp.c                |  12 +
>  arch/arm/mach-vexpress/v2m.c                    |   2 +-
>  drivers/misc/Kconfig                            |   4 +
>  drivers/misc/Makefile                           |   1 +
>  drivers/misc/arm-cci.c                          | 124 +++++
>  include/linux/arm-cci.h                         |  30 ++
>  25 files changed, 2186 insertions(+), 2 deletions(-)
> 
> Review comments are welcome!
> 
> [*] General design information on the b.L switcher can be found here:
>     http://lwn.net/Articles/481055/
>     However the code is only accessible to Linaro members for the
>     time being.
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
