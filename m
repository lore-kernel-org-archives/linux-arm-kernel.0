From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 13 Oct 2014 13:19:09 +0200
Subject: [PATCH v3] drivers: of: add return value to
 of_reserved_mem_device_init
In-Reply-To: <1412857080-5100-1-git-send-email-m.szyprowski@samsung.com>
References: <1410434561-9294-2-git-send-email-m.szyprowski@samsung.com>
 <1412857080-5100-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <13963062.ORRNOhrvYD@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 09 October 2014 14:18:00 Marek Szyprowski wrote:
> diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
> index 59fb12e..70780ad 100644
> --- a/drivers/of/of_reserved_mem.c
> +++ b/drivers/of/of_reserved_mem.c

>         if (!rmem || !rmem->ops || !rmem->ops->device_init)
> -               return;
> +               return -EINVAL;
>  
>         rmem->ops->device_init(rmem, dev);
>         dev_info(dev, "assigned reserved memory node %s\n", rmem->name);
> +       return 0;
>  }

You don't actually return the value from ->device_init() here but always
return 0 on success. There are no callers of this function, so it's
hard to tell if this actually makes a difference, but it contradicts
your patch description.

> diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
> index 5b5efae..ad2f670 100644
> --- a/include/linux/of_reserved_mem.h
> +++ b/include/linux/of_reserved_mem.h
> @@ -16,7 +16,7 @@ struct reserved_mem {
>  };
>  
>  struct reserved_mem_ops {
> -       void    (*device_init)(struct reserved_mem *rmem,
> +       int     (*device_init)(struct reserved_mem *rmem,
>                                struct device *dev);
>         void    (*device_release)(struct reserved_mem *rmem,
>                                   struct device *dev);

This part is definitely needed to avoid the new compile warnings we
are getting.

	Arnd
