From: eduardo.valentin@ti.com (Eduardo Valentin)
Date: Mon, 3 Jun 2013 10:59:36 -0400
Subject: [PATCH] thermal: thermal_core: policy store via sysfs is broken
In-Reply-To: <1370267943-13297-1-git-send-email-shawn.guo@linaro.org>
References: <1370267943-13297-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <51ACAF58.9060301@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shawn,

On 03-06-2013 09:59, Shawn Guo wrote:
> When function __find_governor() gets called from policy_store(), the
> argument 'buf' has a '\n' character at the end.  This causes strnicmp()
> mismatches all the time.  Consequently, policy_store() will always
> return -EINVAL, and hence the policy store via sysfs will always fail
> even when users store a correct policy name.
> 
> Fix the problem by using strncasecmp() for policy name matching in
> __find_governor().
> 
Thanks for your patch, but Andy has fixed this issue already here:

http://git.kernel.org/cgit/linux/kernel/git/rzhang/linux.git/commit/?h=next&id=42a5bf507d7f7ecbf606eb392dd9d2e4d009c36b

Patch is present in thermal/next.


> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  drivers/thermal/thermal_core.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
> index d755440..6ba869f 100644
> --- a/drivers/thermal/thermal_core.c
> +++ b/drivers/thermal/thermal_core.c
> @@ -57,9 +57,10 @@ static struct thermal_governor *__find_governor(const char *name)
>  {
>  	struct thermal_governor *pos;
>  
> -	list_for_each_entry(pos, &thermal_governor_list, governor_list)
> -		if (!strnicmp(name, pos->name, THERMAL_NAME_LENGTH))
> +	list_for_each_entry(pos, &thermal_governor_list, governor_list) {
> +		if (!strncasecmp(name, pos->name, strlen(pos->name)))
>  			return pos;
> +	}
>  
>  	return NULL;
>  }
> 


-- 
You have got to be excited about what you are doing. (L. Lamport)

Eduardo Valentin

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 295 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130603/85efb595/attachment.sig>
