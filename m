From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 23 May 2014 18:49:14 +0800
Subject: [PATCH v2] mm, compaction: properly signal and act upon lock and
 need_sched() contention
In-Reply-To: <537F082F.50501@suse.cz>
References: <1399904111-23520-1-git-send-email-vbabka@suse.cz>
 <1400233673-11477-1-git-send-email-vbabka@suse.cz>
 <CAGa+x87-NRyK6kUiXNL_bRNEGm+DR6M3HPSLYEoq4t6Nrtnd_g@mail.gmail.com>
 <CAAQ0ZWQDVxAzZVm86ATXd1JGUVoLXj_Y5Ske7htxH_6a4GPKRg@mail.gmail.com>
 <537F082F.50501@suse.cz>
Message-ID: <20140523104911.GA7306@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:34:55AM +0200, Vlastimil Babka wrote:
> From: Vlastimil Babka <vbabka@suse.cz>
> Date: Fri, 23 May 2014 10:18:56 +0200
> Subject: mm-compaction-properly-signal-and-act-upon-lock-and-need_sched-contention-fix2
> 
> Step 1: Change function name and comment between v1 and v2 so that the return
>         value signals the opposite thing.
> Step 2: Change the call sites to reflect the opposite return value.
> Step 3: ???
> Step 4: Make a complete fool of yourself.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: Shawn Guo <shawn.guo@linaro.org>

> ---
>  mm/compaction.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/mm/compaction.c b/mm/compaction.c
> index a525cd4..5175019 100644
> --- a/mm/compaction.c
> +++ b/mm/compaction.c
> @@ -237,13 +237,13 @@ static inline bool compact_should_abort(struct compact_control *cc)
>  	if (need_resched()) {
>  		if (cc->mode == MIGRATE_ASYNC) {
>  			cc->contended = true;
> -			return false;
> +			return true;
>  		}
>  
>  		cond_resched();
>  	}
>  
> -	return true;
> +	return false;
>  }
>  
>  /* Returns true if the page is within a block suitable for migration to */
> -- 
> 1.8.4.5
> 
> 
