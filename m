From: will.deacon@arm.com (Will Deacon)
Date: Wed, 12 Feb 2014 12:27:28 +0000
Subject: [PATCH] arm64: smp: Add a memory barrier before we start
 secondary cores
In-Reply-To: <1392205594-29186-1-git-send-email-broonie@kernel.org>
References: <1392205594-29186-1-git-send-email-broonie@kernel.org>
Message-ID: <20140212122727.GB29132@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 11:46:34AM +0000, Mark Brown wrote:
> From: Mark Brown <broonie@linaro.org>
> 
> Ensure that memory writes will be visible to the newly started core by
> inserting a write barrier prior to starting. This adds robustness against
> possible incomplete synchronisation of state.

This is very vague. I still don't understand what this is being used for.

> Suggested-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  arch/arm64/kernel/smp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> index 9660750f34ba..f5520d8fafab 100644
> --- a/arch/arm64/kernel/smp.c
> +++ b/arch/arm64/kernel/smp.c
> @@ -160,6 +160,11 @@ asmlinkage void secondary_start_kernel(void)
>  	smp_store_cpu_info(cpu);
>  
>  	/*
> +	 * Ensure memory writes are visible before we start.
> +	 */
> +	smp_wmb();
> +
> +	/*
>  	 * OK, now it's safe to let the boot CPU continue.  Wait for
>  	 * the CPU migration code to notice that the CPU is online
>  	 * before we continue.

So right after this comment we complete(&cpu_running), which implies a write
barrier if we wake somebody up. The secondary coming up should be waiting on
that completion, so *that* is how synchronisation is achieved.

Without a concrete example of precisely why this is required, I'm not at all
happy taking patches adding random memory barriers.

Will
