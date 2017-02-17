From: joe@perches.com (Joe Perches)
Date: Fri, 17 Feb 2017 11:52:09 -0800
Subject: [PATCH] staging: bcm2835-audio: bcm2835.h: fix various coding
 style issues
In-Reply-To: <1487356776-11449-1-git-send-email-adanhawthorn@gmail.com>
References: <1487356776-11449-1-git-send-email-adanhawthorn@gmail.com>
Message-ID: <1487361129.2198.4.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2017-02-17 at 13:39 -0500, Nathan Howard wrote:
> The following coding style issues (as per checkpatch.pl) were resolved.

What Greg said is true, and the volatile conversion
especially needs to be verified.

> diff --git a/drivers/staging/bcm2835-audio/bcm2835.h b/drivers/staging/bcm2835-audio/bcm2835.h
[]
> @@ -27,8 +27,8 @@
>  #include <linux/workqueue.h>
>  
>  /*
> -#define AUDIO_DEBUG_ENABLE
> -#define AUDIO_VERBOSE_DEBUG_ENABLE
> + * #define AUDIO_DEBUG_ENABLE
> + * #define AUDIO_VERBOSE_DEBUG_ENABLE
>   */

Using #define DEBUG would be more common.
 
>  /* Debug macros */
> @@ -37,10 +37,10 @@
>  #ifdef AUDIO_VERBOSE_DEBUG_ENABLE
>  
>  #define audio_debug(fmt, arg...) \
> -	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
> +	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
>  
>  #define audio_info(fmt, arg...) \
> -	printk(KERN_INFO"%s:%d " fmt, __func__, __LINE__, ##arg)
> +	pr_info("%s:%d " fmt, __func__, __LINE__, ##arg)
>  
>  #else
>  
> @@ -59,13 +59,13 @@
>  #endif /* AUDIO_DEBUG_ENABLE */
>  
>  #define audio_error(fmt, arg...) \
> -	printk(KERN_ERR"%s:%d " fmt, __func__, __LINE__, ##arg)
> +	pr_err("%s:%d " fmt, __func__, __LINE__, ##arg)
>  
>  #define audio_warning(fmt, arg...) \
> -	printk(KERN_WARNING"%s:%d " fmt, __func__, __LINE__, ##arg)
> +	pr_warn("%s:%d " fmt, __func__, __LINE__, ##arg)
>  
>  #define audio_alert(fmt, arg...) \
> -	printk(KERN_ALERT"%s:%d " fmt, __func__, __LINE__, ##arg)
> +	pr_alert("%s:%d " fmt, __func__, __LINE__, ##arg)

These might as well be removed and converted to
the direct pr_<level> equivalents and have

#define pr_fmt(fmt) "%s:%d: " fmt, __func__, __LINE__

added before any include, but honestly the
__func__ and __LINE__ aren't particularly useful.

> @@ -122,8 +125,8 @@ struct bcm2835_alsa_stream {
>  	struct semaphore buffers_update_sem;
>  	struct semaphore control_sem;
>  	spinlock_t lock;
> -	volatile unsigned int control;
> -	volatile unsigned int status;
> +	unsigned int control;
> +	unsigned int status;

Unless you can absolutely verify that that
doesn't change hardware access, you should
leave this alone.
'
