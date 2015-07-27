From: will.deacon@arm.com (Will Deacon)
Date: Mon, 27 Jul 2015 12:58:22 +0100
Subject: [PATCH v2 02/20] documentation: Clarify failed cmpxchg memory
 ordering semantics
In-Reply-To: <1437734531-10698-3-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-3-git-send-email-will.deacon@arm.com>
Message-ID: <20150727115822.GH3358@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:41:53AM +0100, Will Deacon wrote:
> A failed cmpxchg does not provide any memory ordering guarantees, a
> property that is used to optimise the cmpxchg implementations on Alpha,
> PowerPC and arm64.
> 
> This patch updates atomic_ops.txt and memory-barriers.txt to reflect
> this.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Will Deacon <will.deacon@arm.com>
> ---
>  Documentation/atomic_ops.txt      | 4 +++-
>  Documentation/memory-barriers.txt | 6 +++---
>  2 files changed, 6 insertions(+), 4 deletions(-)

Peter: are you ok with me taking this via the arm64 tree (along with the
rest of the series), or would you prefer this patch routed through -tip?

Will

> diff --git a/Documentation/atomic_ops.txt b/Documentation/atomic_ops.txt
> index dab6da3382d9..b19fc34efdb1 100644
> --- a/Documentation/atomic_ops.txt
> +++ b/Documentation/atomic_ops.txt
> @@ -266,7 +266,9 @@ with the given old and new values. Like all atomic_xxx operations,
>  atomic_cmpxchg will only satisfy its atomicity semantics as long as all
>  other accesses of *v are performed through atomic_xxx operations.
>  
> -atomic_cmpxchg must provide explicit memory barriers around the operation.
> +atomic_cmpxchg must provide explicit memory barriers around the operation,
> +although if the comparison fails then no memory ordering guarantees are
> +required.
>  
>  The semantics for atomic_cmpxchg are the same as those defined for 'cas'
>  below.
> diff --git a/Documentation/memory-barriers.txt b/Documentation/memory-barriers.txt
> index 13feb697271f..18fc860df1be 100644
> --- a/Documentation/memory-barriers.txt
> +++ b/Documentation/memory-barriers.txt
> @@ -2383,9 +2383,7 @@ about the state (old or new) implies an SMP-conditional general memory barrier
>  explicit lock operations, described later).  These include:
>  
>  	xchg();
> -	cmpxchg();
>  	atomic_xchg();			atomic_long_xchg();
> -	atomic_cmpxchg();		atomic_long_cmpxchg();
>  	atomic_inc_return();		atomic_long_inc_return();
>  	atomic_dec_return();		atomic_long_dec_return();
>  	atomic_add_return();		atomic_long_add_return();
> @@ -2398,7 +2396,9 @@ explicit lock operations, described later).  These include:
>  	test_and_clear_bit();
>  	test_and_change_bit();
>  
> -	/* when succeeds (returns 1) */
> +	/* when succeeds */
> +	cmpxchg();
> +	atomic_cmpxchg();		atomic_long_cmpxchg();
>  	atomic_add_unless();		atomic_long_add_unless();
>  
>  These are used for such things as implementing ACQUIRE-class and RELEASE-class
> -- 
> 2.1.4
> 
