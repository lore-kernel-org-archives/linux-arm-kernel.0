From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 9 Sep 2014 10:00:42 +0200
Subject: [PATCH] GICv3: Fixing 32 bit compatibility
In-Reply-To: <1410185480-5153-1-git-send-email-rric@kernel.org>
References: <1410185480-5153-1-git-send-email-rric@kernel.org>
Message-ID: <20140909080042.GO23009@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Robert,

On Mon, Sep 08, 2014 at 04:11:19PM +0200, Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Fixing 32 bit compatibility by using ULL for u64 constants.
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> ---
>  drivers/irqchip/irq-gic-v3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
> index 57eaa5a0b1e3..9e13c87c7dfe 100644
> --- a/drivers/irqchip/irq-gic-v3.c
> +++ b/drivers/irqchip/irq-gic-v3.c
> @@ -441,7 +441,7 @@ static u16 gic_compute_target_list(int *base_cpu, const struct cpumask *mask,
>  
>  		mpidr = cpu_logical_map(cpu);
>  
> -		if (cluster_id != (mpidr & ~0xffUL)) {
> +		if (cluster_id != (mpidr & ~0xffULL)) {
>  			cpu--;
>  			goto out;
>  		}
> @@ -479,7 +479,7 @@ static void gic_raise_softirq(const struct cpumask *mask, unsigned int irq)
>  	smp_wmb();
>  
>  	for_each_cpu_mask(cpu, *mask) {
> -		u64 cluster_id = cpu_logical_map(cpu) & ~0xffUL;
> +		u64 cluster_id = cpu_logical_map(cpu) & ~0xffULL;
This doesn't change anything, does it?

I wonder if it would be cleaner to use (u64)0xff here. Or still better
put the determination of the current cluster id(?) into a static inline
function?

Further, apart from arm and arm64 all other arch defining
cpu_logical_map (m32r, mips, mn10300, parisc, sh, sparc, um,
xtensa) return an int. (Three of them return just the cpu parameter
which at least for irq-gic-v3 is an int, too.)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
