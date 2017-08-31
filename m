From: james.morse@arm.com (James Morse)
Date: Thu, 31 Aug 2017 18:44:21 +0100
Subject: [PATCH v6 1/7] arm64: cpufeature: Detect CPU RAS Extentions
In-Reply-To: <1503916701-13516-2-git-send-email-gengdongjiu@huawei.com>
References: <1503916701-13516-1-git-send-email-gengdongjiu@huawei.com>
 <1503916701-13516-2-git-send-email-gengdongjiu@huawei.com>
Message-ID: <59A84AF5.3000104@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 28/08/17 11:38, Dongjiu Geng wrote:
> From: Xie XiuQi <xiexiuqi@huawei.com>
> 
> ARM's v8.2 Extentions add support for Reliability, Availability and
> Serviceability (RAS). On CPUs with these extensions system software
> can use additional barriers to isolate errors and determine if faults
> are pending.
> 
> Add cpufeature detection and a barrier in the context-switch code.
> There is no need to use alternatives for this as CPUs that don't
> support this feature will treat the instruction as a nop.
> 
> Platform level RAS support may require additional firmware support.
> 
> Signed-off-by: Xie XiuQi <xiexiuqi@huawei.com>
> [Rebased, added esb and config option, reworded commit message]
> Signed-off-by: James Morse <james.morse@arm.com>

Nit: when re-posting patches from the list you need to add your signed-off-by.
See Documentation/process/submitting-patches.rst 'Developer's Certificate of
Origin 1.1'

This goes for your patch 2 as well.


> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c845c8c04d95..7a17b4a1bd9e 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -370,6 +370,9 @@ __notrace_funcgraph struct task_struct *__switch_to(struct task_struct *prev,
>  	 */
>  	dsb(ish);
>  
> +	/* Deliver any pending SError from prev */
> +	esb();
> +

This patch was sitting on top of the SError rework. As the cover-letter
describes that was all there to make sure SError is unmasked when we execute
this esb(). Without it any pending SError will be deferred, its ESR is written
to DISR_EL1, which this patch doesn't check.

On its own, this patch is actively harmful to systems that don't have
firmware-first handling.

We probably need to produce a combined series...


Thanks,

James
