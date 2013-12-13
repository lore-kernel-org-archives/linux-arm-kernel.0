From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 16:46:46 +0000
Subject: [PATCH 2/5] arm64: Fix the soft_restart routine
In-Reply-To: <fbf47d394de6bd7332b00bc706a9f38cd7a68327.1386879684.git.geoff@infradead.org>
References: <cover.1386879684.git.geoff@infradead.org>
 <fbf47d394de6bd7332b00bc706a9f38cd7a68327.1386879684.git.geoff@infradead.org>
Message-ID: <20131213164646.GN19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 08:39:46PM +0000, Geoff Levand wrote:
> Change the soft_restart() routine to call cpu_reset() at its identity mapped
> physical address.
> 
> The cpu_reset() routine must be called at its identity mapped physical address
> so that when the MMU is turned off the instruction pointer will be at the correct
> location in physical memory.
> 
> Signed-off-by: Geoff Levand <geoff@infradead.org> for Huawei, Linaro
> ---
>  arch/arm64/kernel/process.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index de17c89..985eb42 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -72,7 +72,13 @@ static void setup_restart(void)
>  void soft_restart(unsigned long addr)
>  {
>  	setup_restart();
> -	cpu_reset(addr);
> +
> +	/*
> +	 * cpu_reset turns the MMU off, so must be called at its identity
> +	 * mapped physical address.
> +	 */
> +
> +	(*(void(*)(unsigned long))virt_to_phys(cpu_reset))(addr);

This isn't right; although cpu_reset *does* need to run from the idmap,
actually the idmap only includes __turn_mmu_on. You just get lucky because
its section-mapped and happens to include the code you want.

The cast is also cleaner if you define a phys_reset_t type, like we do for
arch/arm/.

Will
