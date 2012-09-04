From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 4 Sep 2012 15:37:44 +0200
Subject: [PATCH 01/11] input: ambakmi: Add missing clk_[un]prepare() calls
In-Reply-To: <1346689531-7212-2-git-send-email-pawel.moll@arm.com>
References: <1346689531-7212-1-git-send-email-pawel.moll@arm.com>
 <1346689531-7212-2-git-send-email-pawel.moll@arm.com>
Message-ID: <20120904153744.10e07940@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Pawel,

Le Mon,  3 Sep 2012 17:25:21 +0100,
Pawel Moll <pawel.moll@arm.com> a ?crit :

> Clocks must be prepared before enabling and unprepared
> after disabling. Without that clk_enable() fails with
> warning.
> 
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
>  drivers/input/serio/ambakmi.c |    9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/input/serio/ambakmi.c b/drivers/input/serio/ambakmi.c
> index 2ffd110..ab2d25b 100644
> --- a/drivers/input/serio/ambakmi.c
> +++ b/drivers/input/serio/ambakmi.c
> @@ -72,10 +72,14 @@ static int amba_kmi_open(struct serio *io)
>  	unsigned int divisor;
>  	int ret;
>  
> -	ret = clk_enable(kmi->clk);
> +	ret = clk_prepare(kmi->clk);
>  	if (ret)
>  		goto out;
>  
> +	ret = clk_enable(kmi->clk);
> +	if (ret)
> +		goto clk_unprepare;
> +

What about using clk_prepare_enable() here?

>  	free_irq(kmi->irq, kmi);
>  	clk_disable(kmi->clk);
> +	clk_unprepare(kmi->clk);

And clk_disable_unprepare() here?

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
