From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 25 Sep 2014 18:56:12 -0300
Subject: [PATCH 0/2] Marvell Armada 375/38x MPIC/MSI fixes
In-Reply-To: <1411643839-64925-1-git-send-email-jaz@semihalf.com>
References: <1411643839-64925-1-git-send-email-jaz@semihalf.com>
Message-ID: <20140925215612.GA3846@arch.cereza>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jason,

On 25 Sep 01:17 PM, Grzegorz Jaszczyk wrote:
> This patchset contains a set of fixes for issues found while doing some test
> with different interrupts configuration on Armada 375 and Armada 38x Marvell
> SoCs. The patches were tested and apply on v3.17-rc6.
> 
> Any feedback is welcome.
> 
> Grzegorz Jaszczyk (2):
>   irqchip: armada-370-xp: fix MSI interrupt handling
>   irqchip: armada-370-xp: fix MPIC interrupt handling

The second patch fixes an unhandled IRQ storm triggered by the mvpp2
ethernet driver, when the kernel is built with CONFIG_SMP=n.

When any network activity is attempted the kernel is interrupted by a per-cpu 
IRQ (which is not the one the driver expects). The interrupt is not mapped 
into Linux's virtual IRQ space, so the result is:

  irq 0, desc: ee004000, depth: 1, count: 0, unhandled: 0
  ->handle_irq():  c00466e8, handle_bad_irq+0x0/0x260
  ->irq_data.chip(): c1181460, 0xc1181460
  ->action():   (null)
     IRQ_NOPROBE set
   IRQ_NOREQUEST set

For both patches:

Fixes: bc69b8adfe22 ("irqchip: armada-370-xp: Setup a chained handler for the MPIC")
Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>

Thanks,
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
