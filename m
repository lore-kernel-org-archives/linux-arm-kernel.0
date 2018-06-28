From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jun 2018 10:40:02 +0200
Subject: [PATCH 1/5] kernel/jump_label: abstract jump_entry member
 accessors
In-Reply-To: <20180627160604.8154-2-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-2-ard.biesheuvel@linaro.org>
Message-ID: <20180628084002.GZ2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 06:06:00PM +0200, Ard Biesheuvel wrote:

> diff --git a/kernel/jump_label.c b/kernel/jump_label.c
> index 01ebdf1f9f40..c3524c9b3004 100644
> --- a/kernel/jump_label.c
> +++ b/kernel/jump_label.c
> @@ -38,10 +38,12 @@ static int jump_label_cmp(const void *a, const void *b)
>  	const struct jump_entry *jea = a;
>  	const struct jump_entry *jeb = b;
>  
> -	if (jea->key < jeb->key)
> +	if ((unsigned long)jump_entry_key(jea) <
> +	    (unsigned long)jump_entry_key(jeb))
>  		return -1;
>  
> -	if (jea->key > jeb->key)
> +	if ((unsigned long)jump_entry_key(jea) >
> +	    (unsigned long)jump_entry_key(jeb))
>  		return 1;

I think you can ditch the unsigned long cast and directly compare
pointers. That leads to much prettier code:

	if (jump_entry_key(jea) < jump_entry_key(jeb))
		return -1;

etc..
