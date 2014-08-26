From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 26 Aug 2014 11:59:13 -0600
Subject: [PATCH v3 1/5] of: Add NVIDIA Tegra Legacy Interrupt Controller
 binding
In-Reply-To: <1409035264-16999-1-git-send-email-thierry.reding@gmail.com>
References: <1409035264-16999-1-git-send-email-thierry.reding@gmail.com>
Message-ID: <53FCCAF1.9050504@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/26/2014 12:41 AM, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
>
> The Legacy Interrupt Controller found on NVIDIA Tegra SoCs is used by
> the AVP coprocessor and can also serve as a backup for the ARM Cortex
> CPU's local interrupt controller (GIC).
>
> The LIC is subdivided into multiple identical units, each handling 32
> possible interrupt sources.

If I apply this series without patch 2, which is necessary to test the 
support for compatibility with old DTs, then I get the following very 
early on in boot:

Other than that, I would apply this.

> [    0.000000] Preemptible hierarchical RCU implementation.
> [    0.000000] NR_IRQS:16 nr_irqs:16 16
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at drivers/soc/tegra/fuse/tegra-apbmisc.c:42 tegra_get_chip_id+0x30/0x44()
> [    0.000000] Tegra Chip ID not yet available
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 3.17.0-rc2-00016-g6a550998848e #32
> [    0.000000] [<c00157a0>] (unwind_backtrace) from [<c0011344>] (show_stack+0x10/0x14)
> [    0.000000] [<c0011344>] (show_stack) from [<c06045e8>] (dump_stack+0x84/0xd0)
> [    0.000000] [<c06045e8>] (dump_stack) from [<c0024f44>] (warn_slowpath_common+0x64/0x88)
> [    0.000000] [<c0024f44>] (warn_slowpath_common) from [<c0024ffc>] (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0024ffc>] (warn_slowpath_fmt) from [<c0267acc>] (tegra_get_chip_id+0x30/0x44)
> [    0.000000] [<c0267acc>] (tegra_get_chip_id) from [<c08576a8>] (tegra_init_irq+0xb0/0x2d0)
> [    0.000000] [<c08576a8>] (tegra_init_irq) from [<c0857d60>] (tegra_dt_init_irq+0x8/0x14)
> [    0.000000] [<c0857d60>] (tegra_dt_init_irq) from [<c08525a8>] (init_IRQ+0x28/0x7c)
> [    0.000000] [<c08525a8>] (init_IRQ) from [<c0850a48>] (start_kernel+0x21c/0x3a8)
> [    0.000000] [<c0850a48>] (start_kernel) from [<80008074>] (0x80008074)
> [    0.000000] ---[ end trace cb88537fdc8fa200 ]---
> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at arch/arm/mach-tegra/irq.c:343 tegra_init_irq+0x184/0x2d0()
> [    0.000000] Found 5 interrupt controllers; expected 4.
> [    0.000000] Modules linked in:
> [    0.000000] CPU: 0 PID: 0 Comm: swapper/0 Tainted: G        W      3.17.0-rc2-00016-g6a550998848e #32
> [    0.000000] [<c00157a0>] (unwind_backtrace) from [<c0011344>] (show_stack+0x10/0x14)
> [    0.000000] [<c0011344>] (show_stack) from [<c06045e8>] (dump_stack+0x84/0xd0)
> [    0.000000] [<c06045e8>] (dump_stack) from [<c0024f44>] (warn_slowpath_common+0x64/0x88)
> [    0.000000] [<c0024f44>] (warn_slowpath_common) from [<c0024ffc>] (warn_slowpath_fmt+0x30/0x40)
> [    0.000000] [<c0024ffc>] (warn_slowpath_fmt) from [<c085777c>] (tegra_init_irq+0x184/0x2d0)
> [    0.000000] [<c085777c>] (tegra_init_irq) from [<c0857d60>] (tegra_dt_init_irq+0x8/0x14)
> [    0.000000] [<c0857d60>] (tegra_dt_init_irq) from [<c08525a8>] (init_IRQ+0x28/0x7c)
> [    0.000000] [<c08525a8>] (init_IRQ) from [<c0850a48>] (start_kernel+0x21c/0x3a8)
> [    0.000000] [<c0850a48>] (start_kernel) from [<80008074>] (0x80008074)
> [    0.000000] ---[ end trace cb88537fdc8fa201 ]---
