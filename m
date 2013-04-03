From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Apr 2013 19:04:43 +0100
Subject: [PATCH] arm64: Fix task tracing
In-Reply-To: <1365012061-31660-1-git-send-email-cov@codeaurora.org>
References: <1365012061-31660-1-git-send-email-cov@codeaurora.org>
Message-ID: <20130403180443.GB21167@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christopher,

On Wed, Apr 03, 2013 at 07:01:01PM +0100, Christopher Covington wrote:
> For accurate accounting call contextidr_thread_switch before a
> task is scheduled, rather than after.
> 
> Signed-off-by: Christopher Covington <cov@codeaurora.org>
> ---
>  arch/arm64/kernel/process.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index 0337cdb..c2cc249 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -311,11 +311,11 @@ struct task_struct *__switch_to(struct task_struct *prev,
>  	fpsimd_thread_switch(next);
>  	tls_thread_switch(next);
>  	hw_breakpoint_thread_switch(next);
> +	contextidr_thread_switch(next);
>  
>  	/* the actual thread switch */
>  	last = cpu_switch_to(prev, next);
>  
> -	contextidr_thread_switch(next);
>  	return last;
>  }

Catalin and I wondered about this and decided to go with the current
approach in case a debugger, in response to the contextidr write, decided to
go off and mine information about the *new* task using the sp.

If we update the register before we've switched the registers, there's a
sizeable window where the debugger will get confused.

Do you have a real use-case that has triggered this patch?

Cheers,

Will
