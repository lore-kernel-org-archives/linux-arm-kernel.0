From: ludovic.desroches@atmel.com (ludovic.desroches)
Date: Thu, 23 Aug 2012 11:05:42 +0200
Subject: JFFS2 issue with v3.5.x and later on Atmel chips at least
In-Reply-To: <1345707689.2848.203.camel@sauron.fi.intel.com>
References: <5034B45A.5060107@atmel.com> <5034F3F8.9080802@atmel.com>
 <1345707689.2848.203.camel@sauron.fi.intel.com>
Message-ID: <5035F266.2040909@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Artem,

Le 08/23/2012 09:41 AM, Artem Bityutskiy a ?crit :
> From: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> Date: Thu, 23 Aug 2012 10:10:07 +0300
> Subject: [PATCH] JFFS2: fix unmount regression
>
> This patch fixes regression introduced by
> "8bdc81c jffs2: get rid of jffs2_sync_super". We submit a delayed work in order
> to make sure the write-buffer is synchronized at some point. But we do not
> flush it when we unmount, which causes an oops when we unmount the file-system
> and then the delayed work is executed.
>
> This patch fixes the issue by adding a "cancel_delayed_work_sync()" infocation
> in the '->sync_fs()' handler. This will make sure the delayed work is canceled
> on sync, unmount and re-mount. And because VFS always callse 'sync_fs()' before
> unmounting or remounting, this fixes the issue.
>
> Reported-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> Cc: stable at vger.kernel.org [3.5+]
> Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
> ---
>
> Ludovic, would you please give this patch a test? Also attached.
>

Thanks for your reactivity. I tested your patch on sam9m10g45 with 3.5 
and 3.5.2 and it fixes the issue.

Tested-by: Ludovic Desroches <ludovic.desroches@atmel.com>

>   fs/jffs2/super.c |    3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/fs/jffs2/super.c b/fs/jffs2/super.c
> index 61ea413..e385fa3 100644
> --- a/fs/jffs2/super.c
> +++ b/fs/jffs2/super.c
> @@ -100,6 +100,9 @@ static int jffs2_sync_fs(struct super_block *sb, int wait)
>   {
>   	struct jffs2_sb_info *c = JFFS2_SB_INFO(sb);
>
> +	if (IS_ENABLED(CONFIG_JFFS2_FS_WRITEBUFFER))
> +		cancel_delayed_work_sync(&c->wbuf_dwork);
> +
>   	mutex_lock(&c->alloc_sem);
>   	jffs2_flush_wbuf_pad(c);
>   	mutex_unlock(&c->alloc_sem);
>
