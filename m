From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Apr 2011 09:12:57 +0100
Subject: [PATCH v2 5/5] driver core: let dev_set_drvdata return int
	instead of void as it can fail
In-Reply-To: <1303285486-28598-5-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110420074248.GS31131@pengutronix.de>
	<1303285486-28598-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1303285486-28598-5-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <20110429081257.GW17290@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 20, 2011 at 09:44:46AM +0200, Uwe Kleine-K?nig wrote:
> Before commit
> 
> 	b402843 (Driver core: move dev_get/set_drvdata to drivers/base/dd.c)
> 
> calling dev_set_drvdata with dev=NULL was an unchecked error. After some
> discussion about what to return in this case removing the check (and so
> producing a null pointer exception) seems fine.
> 
> Signed-off-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/base/dd.c      |    7 +++----
>  include/linux/device.h |    2 +-
>  2 files changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/base/dd.c b/drivers/base/dd.c
> index da57ee9..f9d69d7 100644
> --- a/drivers/base/dd.c
> +++ b/drivers/base/dd.c
> @@ -408,17 +408,16 @@ void *dev_get_drvdata(const struct device *dev)
>  }
>  EXPORT_SYMBOL(dev_get_drvdata);
>  
> -void dev_set_drvdata(struct device *dev, void *data)
> +int dev_set_drvdata(struct device *dev, void *data)
>  {
>  	int error;
>  
> -	if (!dev)
> -		return;
>  	if (!dev->p) {
>  		error = device_private_init(dev);
>  		if (error)
> -			return;
> +			return error;
>  	}
>  	dev->p->driver_data = data;
> +	return 0;

Who is going to modify all the thousands of drivers we have in the kernel
tree to check this return value?

If the answer is no one, its pointless returning an error value in the
first place (which I think is what the original author already thought
about.)
