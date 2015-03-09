From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 09 Mar 2015 20:47:46 +0100
Subject: [PATCH v5 2/3] wl18xx: add basic device-tree support
In-Reply-To: <1425915402-10012-2-git-send-email-eliad@wizery.com>
References: <1425915402-10012-1-git-send-email-eliad@wizery.com>
 <1425915402-10012-2-git-send-email-eliad@wizery.com>
Message-ID: <10327320.45ToCM2gnq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 09 March 2015 17:36:41 Eliad Peller wrote:
> @@ -323,11 +388,14 @@ out:
>  static void wl1271_remove(struct sdio_func *func)
>  {
>         struct wl12xx_sdio_glue *glue = sdio_get_drvdata(func);
> +       struct wlcore_platdev_data *pdev_data = glue->core->dev.platform_data;
> +       struct wl12xx_platform_data *pdata = pdev_data->pdata;
>  
>         /* Undo decrement done above in wl1271_probe */
>         pm_runtime_get_noresume(&func->dev);
>  
>         platform_device_unregister(glue->core);
> +       wlcore_del_platform_data(pdata);
>         kfree(glue);
>  }
>  
> 

The third patch looks ok, but now you should remove the wl12xx_platform_data
from the wlcore code, since it's not used any more, it was broken to start
with (as it supports only one instance) and we want to prevent others from
adding new users of that. Since the only thing you need is the irq number,
you can directly add the irq number to struct wlcore_platdev_data and
remove the pdata pointer there.

	Arnd
