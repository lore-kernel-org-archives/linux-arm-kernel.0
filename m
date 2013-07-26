From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Fri, 26 Jul 2013 18:01:37 +0100
Subject: [PATCH v3 07/16] of/device: add helper to get cpu device node
 from logical cpu index
In-Reply-To: <1374492747-13879-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-8-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Message-ID: <51F2AB71.3070102@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob,

On 22/07/13 12:32, Sudeep KarkadaNagesha wrote:
> From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
>
> Multiple drivers need to get the cpu device node from the cpu logical
> index and then access the of_node.
>
> This patch adds helper function to fetch the device node directly.
>
> Cc: Rob Herring <rob.herring@calxeda.com>
> Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

If you have no objections with this patch, can I add your ACK ?

Regards,
Sudeep

> ---
>  include/linux/of_device.h | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/include/linux/of_device.h b/include/linux/of_device.h
> index 9d27475..82ce324 100644
> --- a/include/linux/of_device.h
> +++ b/include/linux/of_device.h
> @@ -1,6 +1,7 @@
>  #ifndef _LINUX_OF_DEVICE_H
>  #define _LINUX_OF_DEVICE_H
>
> +#include <linux/cpu.h>
>  #include <linux/platform_device.h>
>  #include <linux/of_platform.h> /* temporary until merge */
>
> @@ -43,6 +44,15 @@ static inline void of_device_node_put(struct device *dev)
>       of_node_put(dev->of_node);
>  }
>
> +static inline struct device_node *of_cpu_device_node_get(int cpu)
> +{
> +     struct device *cpu_dev;
> +     cpu_dev = get_cpu_device(cpu);
> +     if (!cpu_dev)
> +             return NULL;
> +     return of_node_get(cpu_dev->of_node);
> +}
> +
>  #else /* CONFIG_OF */
>
>  static inline int of_driver_match_device(struct device *dev,
> @@ -67,6 +77,11 @@ static inline const struct of_device_id *of_match_device(
>  {
>       return NULL;
>  }
> +
> +static inline struct device_node *of_cpu_device_node_get(int cpu)
> +{
> +     return NULL;
> +}
>  #endif /* CONFIG_OF */
>
>  #endif /* _LINUX_OF_DEVICE_H */
>


-- IMPORTANT NOTICE: The contents of this email and any attachments are confidential and may also be privileged. If you are not the intended recipient, please notify the sender immediately and do not disclose the contents to any other person, use it for any purpose, or store or copy the information in any medium.  Thank you.
