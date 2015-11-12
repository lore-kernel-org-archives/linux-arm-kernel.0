From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 12 Nov 2015 13:38:28 +0100
Subject: [PATCH] pwm: sun4i: fix a possible NULL dereference
In-Reply-To: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
References: <1447314132-29458-1-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20151112123828.GB31671@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 12, 2015 at 08:42:12AM +0100, LABBE Corentin wrote:
> of_match_device could return NULL, and so cause a NULL pointer
> dereference later.
> 
> Reported-by: coverity (CID 1324139)
> Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> ---
>  drivers/pwm/pwm-sun4i.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/pwm/pwm-sun4i.c b/drivers/pwm/pwm-sun4i.c
> index cd9dde5..3011fcc 100644
> --- a/drivers/pwm/pwm-sun4i.c
> +++ b/drivers/pwm/pwm-sun4i.c
> @@ -291,6 +291,8 @@ static int sun4i_pwm_probe(struct platform_device *pdev)
>  	const struct of_device_id *match;
>  
>  	match = of_match_device(sun4i_pwm_dt_ids, &pdev->dev);
> +	if (!match)
> +		return -ENODEV;

I explained this in a reply to another similar patch, but that was a
different audience, so here goes again: the driver core will use the
same device ID table to match on the driver, so the case where NULL
would be returned is the same case in which sun4i_pwm_probe() would
never have been called in the first place.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151112/044c5813/attachment.sig>
