From: will.deacon@arm.com (Will Deacon)
Date: Tue, 11 Nov 2014 17:51:33 +0000
Subject: [PATCH] Correct the race condition in
 aarch64_insn_patch_text_sync()
In-Reply-To: <546221BD.8000207@redhat.com>
References: <1415637362-30754-1-git-send-email-wcohen@redhat.com>
 <20141110170846.GH23942@arm.com> <546113F4.1050304@redhat.com>
 <20141111112844.GC16265@arm.com> <546221BD.8000207@redhat.com>
Message-ID: <20141111175132.GI16265@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 11, 2014 at 02:48:29PM +0000, William Cohen wrote:
> On 11/11/2014 06:28 AM, Will Deacon wrote:
> > On Mon, Nov 10, 2014 at 07:37:24PM +0000, William Cohen wrote:
> >> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> >> index e007714..4fdddf1 100644
> >> --- a/arch/arm64/kernel/insn.c
> >> +++ b/arch/arm64/kernel/insn.c
> >> @@ -151,10 +151,13 @@ struct aarch64_insn_patch {
> >>  static int __kprobes aarch64_insn_patch_text_cb(void *arg)
> >>  {
> >>  	int i, ret = 0;
> >> +	int count = num_online_cpus();
> >>  	struct aarch64_insn_patch *pp = arg;
> >>  
> >> -	/* The first CPU becomes master */
> >> -	if (atomic_inc_return(&pp->cpu_count) == 1) {
> >> +	/* Make sure all the processors are in this function
> >> +	   before patching the code. The last CPU to this function
> >> +	   does the update. */
> >> +	if (atomic_inc_return(&pp->cpu_count) == count) {
> > 
> > Actually, you can leave this hunk alone and leave the first CPU to do the
> > patching.
> 
> If it doesn't matter which processor is doing the update, do the
> processors all need to wait for the last one to get to this function
> before continuing on?  Or would it be acceptable to allow processors to
> continue once the first processor completes the patch operation?  That
> could reduce the amount of time that processors spin waiting for other
> processors to enter arch64_insn_patch_text_cb.

I don't think it will make a lot of difference, given the stop_machine
completion.

> Attached is a patch that addresses the current comment.

Thanks, Will.

> From 41c728aeee2185fd30ec6a8ba223a2caec875f47 Mon Sep 17 00:00:00 2001
> From: William Cohen <wcohen@redhat.com>
> Date: Tue, 11 Nov 2014 09:41:27 -0500
> Subject: [PATCH] Correct the race condition in aarch64_insn_patch_text_sync()
> 
> When experimenting with patches to provide kprobes support for aarch64
> smp machines would hang when inserting breakpoints into kernel code.
> The hangs were caused by a race condition in the code called by
> aarch64_insn_patch_text_sync().  The first processor in the
> aarch64_insn_patch_text_cb() function would patch the code while other
> processors were still entering the function and incrementing the
> cpu_count field.  This resulted in some processors never observing the
> exit condition and exiting the function.  Thus, processors in the
> system hung.
> 
> The first processor to enter the patching function performs the
> patching and signals that the patching is complete with an increment
> of the cpu_count field. When all the processors have incremented the
> cpu_count field the cpu_count will be num_cpus_online()+1 and they
> will return to normal execution.
> 
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  arch/arm64/kernel/insn.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Catalin -- can you pick this into the fixes branch please?

Will

> diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
> index e007714..8cd27fe 100644
> --- a/arch/arm64/kernel/insn.c
> +++ b/arch/arm64/kernel/insn.c
> @@ -163,9 +163,10 @@ static int __kprobes aarch64_insn_patch_text_cb(void *arg)
>  		 * which ends with "dsb; isb" pair guaranteeing global
>  		 * visibility.
>  		 */
> -		atomic_set(&pp->cpu_count, -1);
> +		/* Notify other processors with an additional increment. */
> +		atomic_inc(&pp->cpu_count);
>  	} else {
> -		while (atomic_read(&pp->cpu_count) != -1)
> +		while (atomic_read(&pp->cpu_count) <= num_online_cpus())
>  			cpu_relax();
>  		isb();
>  	}
> -- 
> 1.8.3.1
