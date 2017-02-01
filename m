From: will.deacon@arm.com (Will Deacon)
Date: Wed, 1 Feb 2017 14:16:57 +0000
Subject: [PATCH] arm64: Improve parking of stopped CPUs
In-Reply-To: <1485942532-2643-1-git-send-email-jnair@caviumnetworks.com>
References: <1485942532-2643-1-git-send-email-jnair@caviumnetworks.com>
Message-ID: <20170201141656.GB8177@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 01, 2017 at 09:48:52AM +0000, Jayachandran C wrote:
> The current code puts the stopped cpus in an 'yield' instruction loop.
> Using a busy loop here is unnecessary, we can use the cpu_park_loop()
> function here to do a wfi/wfe.
> 
> Signed-off-by: Jayachandran C <jnair@caviumnetworks.com>
> ---
>  arch/arm64/kernel/smp.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index cbaab44..0691d2f 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -829,8 +829,7 @@ static void ipi_cpu_stop(unsigned int cpu)
>  
>  	local_irq_disable();
>  
> -	while (1)
> -		cpu_relax();
> +	cpu_park_loop();
>  }

Hmm, so we actually added the yield for QEMU's benefit iirc, where QEMU
will trap the yield and schedule a different vCPU. Should we be adding
a yield to cpu_park_loop instead?

Will
