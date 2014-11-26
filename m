From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 25 Nov 2014 21:37:56 -0500
Subject: [PATCH] ARM: orion: convert the irq_reg_{readl,writel} calls
 to the new API
In-Reply-To: <1416928752-24529-1-git-send-email-gregory.clement@free-electrons.com>
References: <1416928752-24529-1-git-send-email-gregory.clement@free-electrons.com>
Message-ID: <20141126023756.GF22670@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Gregory,

+tglx: heads up.

On Tue, Nov 25, 2014 at 04:19:12PM +0100, Gregory CLEMENT wrote:
> The commit "genirq: Generic chip: Change irq_reg_{readl,writel}
> arguments" modified the API. In the same tome the
> arch/arm/plat-orion/gpio.c file received a fix with the use of the old
> API: "ARM: orion: Fix for certain sequence of request_irq can cause
> irq storm". This commit fixes the use of the API.
> 
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> Hi Jason,
> 
> This patch fix a build error in linux-next:
> 
> arch/arm/plat-orion/gpio.c:509:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:511:2: error: too few arguments to function 'irq_reg_writel'
> arch/arm/plat-orion/gpio.c:523:12: error: too few arguments to function 'irq_reg_readl'
> arch/arm/plat-orion/gpio.c:525:2: error: too few arguments to function 'irq_reg_writel'
> 
> But if we want to apply it on the mvebu branch we need to add a
> dependecy to "332fd7c4fef5 genirq: Generic chip: Change
> irq_reg_{readl,writel} arguments"
> 
> Thanks,
> 
> Gregory
> 
>  arch/arm/plat-orion/gpio.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)

Applied to irqchip/core (source of genirq API change) with a dependency
on tags/mvebu-fixes-3.18 (in mainline since v3.18-rc5) with Olof's Ack.

ThomasG, this means we'll be pulling in two patches not related to
irqchip, but this was the least offensive path I could come up with to
solve the issue.

bisection will fail iff building legacy plat-orion code, *and* it lands between

  19e1c15753d2 Merge tag 'tags/mvebu-fixes-3.18' into irqchip/core

and

  2f90bce7ff1f ARM: orion: convert the irq_reg_{readl,writel} calls to the new API

which is a one patch window.  I hope that's tolerable. :-/


Thanks for putting this together Gregory!

thx,

Jason.
