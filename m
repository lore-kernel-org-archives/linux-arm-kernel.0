From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Feb 2018 10:33:38 +0000
Subject: [PATCH] irqchip/gic-v3: Use wmb() instead of smb_wmb() in
 gic_raise_softirq()
In-Reply-To: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
References: <1517443422-30693-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <20180201103337.GA13705@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On Wed, Jan 31, 2018 at 06:03:42PM -0600, Shanker Donthineni wrote:
> A DMB instruction can be used to ensure the relative order of only
> memory accesses before and after the barrier. Since writes to system
> registers are not memory operations, barrier DMB is not sufficient
> for observability of memory accesses that occur before ICC_SGI1R_EL1
> writes.
> 
> A DSB instruction ensures that no instructions that appear in program
> order after the DSB instruction, can execute until the DSB instruction
> has completed.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
>  drivers/irqchip/irq-gic-v3.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index b56c3e2..980ae8e 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -688,7 +688,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	 * Ensure that stores to Normal memory are visible to the
>  	 * other CPUs before issuing the IPI.
>  	 */
> -	smp_wmb();
> +	wmb();

I think this is the right thing to do and the smp_wmb() was accidentally
pulled in here as a copy-paste from the GICv2 driver where it is sufficient
in practice.

Did you spot this by code inspection, or did the DMB actually cause
observable failures? (trying to figure out whether or not this need to go
to -stable).

Anyway:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
