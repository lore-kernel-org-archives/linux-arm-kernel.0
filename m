From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Fri, 09 Nov 2012 09:26:23 +0000
Subject: [PATCH] ARM: kprobes: use BUG_ON where possible
In-Reply-To: <1352406191-14303-4-git-send-email-sasha.levin@oracle.com>
References: <1352406191-14303-1-git-send-email-sasha.levin@oracle.com>
 <1352406191-14303-4-git-send-email-sasha.levin@oracle.com>
Message-ID: <1352453183.3236.5.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2012-11-08 at 15:23 -0500, Sasha Levin wrote:
> Just use BUG_ON() instead of constructions such as:
> 
> 	if (...)
> 		BUG()
> 
> A simplified version of the semantic patch that makes this transformation
> is as follows: (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> - if (e) BUG();
> + BUG_ON(e);
> // </smpl>
> 
> Signed-off-by: Sasha Levin <sasha.levin@oracle.com>

I'm not sure that trivial changes like this are worth it, but equally,
they're not worth having a discussion about, so...

Acked-by: Jon Medhurst <tixy@linaro.org>

> ---
>  arch/arm/kernel/kprobes-test.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm/kernel/kprobes-test.c b/arch/arm/kernel/kprobes-test.c
> index 1862d8f..0fb370d 100644
> --- a/arch/arm/kernel/kprobes-test.c
> +++ b/arch/arm/kernel/kprobes-test.c
> @@ -1212,8 +1212,7 @@ static int register_test_probe(struct test_probe *probe)
>  {
>  	int ret;
>  
> -	if (probe->registered)
> -		BUG();
> +	BUG_ON(probe->registered);
>  
>  	ret = register_kprobe(&probe->kprobe);
>  	if (ret >= 0) {
