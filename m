From: ben@trinity.fluff.org (Ben Dooks)
Date: Tue, 13 Oct 2009 21:19:45 +0100
Subject: [PATCH] s3c: Fix adc function exports
In-Reply-To: <4AD4E096.2060409@bluewatersys.com>
References: <4AD4E096.2060409@bluewatersys.com>
Message-ID: <20091013201945.GK28849@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 14, 2009 at 09:18:30AM +1300, Ryan Mallon wrote:
> A couple of mistakes were picked up in the s3c adc driver during the
> review of Christian Gagneraud's ep93xx adc patches.
 
> ---
> Make s3c_adc_start static since it is not used by any other driver, and
> fix the export of s3c_adc_read.

s3c_adc_start is used by ts driver which is under review, so please don't
remove it. The other part is correct, I'll chop and apply.
 
> Signed-off-by: Ryan Mallon <ryan@bluewatersys.com>
> ---
> 
> diff --git a/arch/arm/plat-s3c/include/plat/adc.h b/arch/arm/plat-s3c/include/plat/adc.h
> index 5f3b1cd..9ae61a1 100644
> --- a/arch/arm/plat-s3c/include/plat/adc.h
> +++ b/arch/arm/plat-s3c/include/plat/adc.h
> @@ -16,9 +16,6 @@
>  
>  struct s3c_adc_client;
>  
> -extern int s3c_adc_start(struct s3c_adc_client *client,
> -			 unsigned int channel, unsigned int nr_samples);
> -
>  extern int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch);
>  
>  extern struct s3c_adc_client *
> diff --git a/arch/arm/plat-s3c24xx/adc.c b/arch/arm/plat-s3c24xx/adc.c
> index 4d36b78..f81c539 100644
> --- a/arch/arm/plat-s3c24xx/adc.c
> +++ b/arch/arm/plat-s3c24xx/adc.c
> @@ -125,8 +125,8 @@ static void s3c_adc_try(struct adc_device *adc)
>  	}
>  }
>  
> -int s3c_adc_start(struct s3c_adc_client *client,
> -		  unsigned int channel, unsigned int nr_samples)
> +static int s3c_adc_start(struct s3c_adc_client *client,
> +			 unsigned int channel, unsigned int nr_samples)
>  {
>  	struct adc_device *adc = adc_dev;
>  	unsigned long flags;
> @@ -155,7 +155,6 @@ int s3c_adc_start(struct s3c_adc_client *client,
>  
>  	return 0;
>  }
> -EXPORT_SYMBOL_GPL(s3c_adc_start);
>  
>  static void s3c_convert_done(struct s3c_adc_client *client,
>  			     unsigned v, unsigned u, unsigned *left)
> @@ -189,7 +188,7 @@ int s3c_adc_read(struct s3c_adc_client *client, unsigned int ch)
>  err:
>  	return ret;
>  }
> -EXPORT_SYMBOL_GPL(s3c_adc_convert);
> +EXPORT_SYMBOL_GPL(s3c_adc_read);
>  
>  static void s3c_adc_default_select(struct s3c_adc_client *client,
>  				   unsigned select)
> 

-- 
-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
