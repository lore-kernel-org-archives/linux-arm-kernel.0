From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Dec 2013 16:00:41 +0000
Subject: [PATCH v6 7/7] jump_label: use defined macros instead of
 hard-coding for better readability
In-Reply-To: <1386691433-6827-8-git-send-email-liuj97@gmail.com>
References: <1386691433-6827-1-git-send-email-liuj97@gmail.com>
 <1386691433-6827-8-git-send-email-liuj97@gmail.com>
Message-ID: <20131213160041.GK19177@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 10, 2013 at 04:03:53PM +0000, Jiang Liu wrote:
> Use macro JUMP_LABEL_TRUE_BRANCH instead of hard-coding for better
> readability.
> 
> Signed-off-by: Jiang Liu <liuj97@gmail.com>
> ---
>  include/linux/jump_label.h | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)

Whilst this looks alright to me, I think we probably need an ack from Steve
in order to take changes to the core code.

Will


> diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
> index 3999977..192ccba 100644
> --- a/include/linux/jump_label.h
> +++ b/include/linux/jump_label.h
> @@ -81,18 +81,21 @@ struct module;
>  #include <linux/atomic.h>
>  #ifdef HAVE_JUMP_LABEL
>  
> -#define JUMP_LABEL_TRUE_BRANCH 1UL
> +#define JUMP_LABEL_TYPE_FALSE_BRANCH	0UL
> +#define JUMP_LABEL_TYPE_TRUE_BRANCH	1UL
> +#define JUMP_LABEL_TYPE_MASK		1UL
>  
>  static
>  inline struct jump_entry *jump_label_get_entries(struct static_key *key)
>  {
>  	return (struct jump_entry *)((unsigned long)key->entries
> -						& ~JUMP_LABEL_TRUE_BRANCH);
> +						& ~JUMP_LABEL_TYPE_MASK);
>  }
>  
>  static inline bool jump_label_get_branch_default(struct static_key *key)
>  {
> -	if ((unsigned long)key->entries & JUMP_LABEL_TRUE_BRANCH)
> +	if (((unsigned long)key->entries & JUMP_LABEL_TYPE_MASK) ==
> +	    JUMP_LABEL_TYPE_TRUE_BRANCH)
>  		return true;
>  	return false;
>  }
> @@ -123,9 +126,11 @@ extern void static_key_slow_dec(struct static_key *key);
>  extern void jump_label_apply_nops(struct module *mod);
>  
>  #define STATIC_KEY_INIT_TRUE ((struct static_key) \
> -	{ .enabled = ATOMIC_INIT(1), .entries = (void *)1 })
> +	{ .enabled = ATOMIC_INIT(1), \
> +	  .entries = (void *)JUMP_LABEL_TYPE_TRUE_BRANCH })
>  #define STATIC_KEY_INIT_FALSE ((struct static_key) \
> -	{ .enabled = ATOMIC_INIT(0), .entries = (void *)0 })
> +	{ .enabled = ATOMIC_INIT(0), \
> +	  .entries = (void *)JUMP_LABEL_TYPE_FALSE_BRANCH })
>  
>  #else  /* !HAVE_JUMP_LABEL */
>  
> -- 
> 1.8.1.2
> 
> 
