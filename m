From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 27 Nov 2014 09:28:38 +0100
Subject: [PATCH 1/2] ARM: tegra: irq: fix buggy usage of irq_data irq field
In-Reply-To: <1417024532-5777-2-git-send-email-marc.zyngier@arm.com>
References: <1417024532-5777-1-git-send-email-marc.zyngier@arm.com>
 <1417024532-5777-2-git-send-email-marc.zyngier@arm.com>
Message-ID: <20141127082836.GA19323@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 26, 2014 at 05:55:31PM +0000, Marc Zyngier wrote:
> The crazy gic_arch_extn thing that Tegra uses contains multiple
> references to the irq field in struct irq_data, and uses this
> to directly poke hardware register.
> 
> But irq is the *virtual* irq number, something that has nothing
> to do with the actual HW irq (stored in the hwirq field). And once
> we put the stacked domain code in action, the whole thing explodes,
> as these two values are *very* different:

Do you have follow-up patches to use stacked domains on Tegra? I tried
to move this driver out to drivers/irqchip at some point and that caused
a bit of pain because of gic_arch_extn and probe order. At the time I
was told that work was in progress to provide a more generic solution
that could replace gic_arch_extn, which I'm assuming this stacked domain
code is.

> root at bacon-fat:~# cat /proc/interrupts
>             CPU0       CPU1
>  16:      25801       2075       GIC  29  twd
>  17:          0          0       GIC  73  timer0
> 112:          0          0      GPIO  58  c8000600.sdhci cd
> 123:          0          0      GPIO  69  c8000200.sdhci cd
> 279:       1126          0       GIC 122  serial
> 281:          0          0       GIC  70  7000c000.i2c
> 282:          0          0       GIC 116  7000c400.i2c
> 283:          0          0       GIC 124  7000c500.i2c
> 284:        300          0       GIC  85  7000d000.i2c
> [...]
> 
> Just replacing all instances of irq with hwirq fixes the issue.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  arch/arm/mach-tegra/irq.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)

This looks correct to me. Do you need this to base subsequent patches on
or shall I just take those through the Tegra tree? I'm not sure if the
ARM SoC maintainers will take a follow-up pull request for 3.19, so let
me know if there's a hurry to get this in if it's going to make stacked
domain code difficult to merge.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141127/551a4aa8/attachment.sig>
