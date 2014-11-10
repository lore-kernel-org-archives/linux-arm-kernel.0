From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Nov 2014 17:08:46 +0000
Subject: [PATCH] Correct the race condition in
 aarch64_insn_patch_text_sync()
In-Reply-To: <1415637362-30754-1-git-send-email-wcohen@redhat.com>
References: <1415637362-30754-1-git-send-email-wcohen@redhat.com>
Message-ID: <20141110170846.GH23942@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

Thanks for the tracking this down.

On Mon, Nov 10, 2014 at 04:36:02PM +0000, William Cohen wrote:
> When experimenting with patches to provide kprobes support for aarch64
> smp machines would hang when inserting breakpoints into kernel code.
> The hangs were caused by a race condition in the code called by
> aarch64_insn_patch_text_sync().  The first processor in the
> aarch64_insn_patch_text_cb() function would patch the code while other
> processors were still entering the function and decrementing the

s/decrementing/incrementing/

> cpu_count field.  This resulted in some processors never observing the
> exit condition and exiting the function.  Thus, processors in the
> system hung.
> 
> The patching function now waits for all processors to enter the
> patching function before changing code to ensure that none of the
> processors are in code that is going to be patched.  Once all the
> processors have entered the function, the last processor to enter the
> patching function performs the pathing and signals that the patching
> is complete with one last decrement of the cpu_count field to make it
> -1.
> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  arch/arm64/kernel/insn.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index e007714..e6266db 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -153,8 +153,10 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  	int i, ret = 0;
>  	struct aarch64_insn_patch *pp = arg;
>  
> -	/* The first CPU becomes master */
> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
> +	/* Make sure all the processors are in this function
> +	   before patching the code. The last CPU to this function
> +	   does the update. */
> +	if (atomic_dec_return(&pp->cpu_count) == 0) {
>  		for (i = 0; ret == 0 && i < pp->insn_cnt; i++)
>  			ret = aarch64_insn_patch_text_nosync(pp->text_addrs[i],
>  							     pp->new_insns[i]);
> @@ -163,7 +165,8 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  		 * which ends with "dsb; isb" pair guaranteeing global
>  		 * visibility.
>  		 */
> -		atomic_set(&pp->cpu_count, -1);
> +		/* Notifiy other processors with an additional decrement. */
> +		atomic_dec(&pp->cpu_count);
>  	} else {
>  		while (atomic_read(&pp->cpu_count) != -1)
>  			cpu_relax();
> @@ -185,6 +188,7 @@ int __kprobes aarch64_insn_patch_text_sync(void *addrs[], u32 insns[], int cnt)
>  	if (cnt <= 0)
>  		return -EINVAL;
>  
> +	atomic_set(&patch.cpu_count, num_online_cpus());

I think this is still racy with hotplug before stop_machine has done
get_online_cpus. How about we leave the increment in the callback and change
the exit condition to compare with num_online_cpus() instead?

Cheers,

Will
