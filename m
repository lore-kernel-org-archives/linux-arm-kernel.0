From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 24 Aug 2016 14:39:11 +0200
Subject: [PATCH v3] pwm: sun4i: fix a possible NULL dereference
In-Reply-To: <1472039038-4047-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1472039038-4047-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160824123911.GC3714@ulmo.ba.sec>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2016 at 01:43:58PM +0200, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
> 
> For fixing this problem, we use of_device_get_match_data(), this will
> simplify the code a little by using a standard function for
> getting the match data.
> 
> Testing the return value of of_device_get_match_data is also necessary
> for avoiding a second NULL deref on pwm->data.
> 
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
> Changes since v2:
>  - Add a test on pwm->data for avoiding a second NULL deref.
> Changes since v1:
>  - Use of_device_get_match_data()
> 
>  drivers/pwm/pwm-sun4i.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index 03a99a5..fb76c55 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -309,9 +309,6 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	struct resource *res;
>  	u32 val;
>  	int i, ret;
> -	const struct of_device_id *match;
> -
> -	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
>  
>  	pwm = devm_kzalloc(&pdev->dev, sizeof(*pwm), GFP_KERNEL);
>  	if (!pwm)
> @@ -326,7 +323,9 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	if (IS_ERR(pwm->clk))
>  		return PTR_ERR(pwm->clk);
>  
> -	pwm->data = match->data;
> +	pwm->data = of_device_get_match_data(&pdev->dev);
> +	if (!pwm->data)
> +		return -EINVAL;

I don't see how this would ever be NULL. You'd have to add an entry to
the table that has a NULL data field, which is very unlikely to happen.
If you really want to check for this, which I think isn't necessary,
please wrap this in a WARN_ON() or something to make more noise when
this completely unexpected case happens.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160824/ee7378e7/attachment.sig>
