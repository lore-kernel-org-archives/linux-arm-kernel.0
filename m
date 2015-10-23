From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 23 Oct 2015 15:07:37 +0200
Subject: [PATCH v3 2/7] vfio: platform: add capability to register a reset
 function
In-Reply-To: <1445603835-14506-3-git-send-email-eric.auger@linaro.org>
References: <1445603835-14506-1-git-send-email-eric.auger@linaro.org>
 <1445603835-14506-3-git-send-email-eric.auger@linaro.org>
Message-ID: <5723752.hDK15zeNcm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 23 October 2015 14:37:10 Eric Auger wrote:
> +
> +void vfio_platform_unregister_reset(const char *compat)
> +{
> +       struct vfio_platform_reset_node *iter, *temp;
> +
> +       mutex_lock(&driver_lock);
> +       list_for_each_entry_safe(iter, temp, &reset_list, link) {
> +               if (!strcmp(iter->compat, compat)) {
> +                       list_del(&iter->link);
> +                       break;
> +               }
> +       }
> +
> +       mutex_unlock(&driver_lock);
> +}
> +EXPORT_SYMBOL_GPL(vfio_platform_unregister_reset);
> 

This is slightly unsafe in case you ever get two drivers that register
with the same compat string. If we care about that, we could pass
and compare both the string and the function pointer, or the
vfio_platform_reset_node.

	Arnd
