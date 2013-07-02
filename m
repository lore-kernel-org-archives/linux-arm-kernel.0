From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 2 Jul 2013 11:03:52 +0800
Subject: [RFC PATCH 02/13] misc: atmel_ssc: keep the count of pdev->id
In-Reply-To: <1372667978-4718-3-git-send-email-richard.genoud@gmail.com>
References: <1372667978-4718-1-git-send-email-richard.genoud@gmail.com>
 <1372667978-4718-3-git-send-email-richard.genoud@gmail.com>
Message-ID: <51D24318.40908@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Richard,

On 7/1/2013 16:39, Richard Genoud wrote:
> With device tree, pdev->id is always -1, so we introduce a local
> counter.
>
> Signed-off-by: Richard Genoud <richard.genoud@gmail.com>
> ---
>   drivers/misc/atmel-ssc.c |    7 +++++++
>   1 file changed, 7 insertions(+)
>
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index 3afbd82..d1ec5ab 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -173,6 +173,12 @@ out:
>   	return err;
>   }
>
> +/* counter of ssc devive instances.
> + * With device tree pdev->id is always -1, so we have to keep the
> + * count ourselves
> + */
> +static int ssc_device_id;

Do we really need this? If Yes, would it better to get from device 
through of_alias_get_id?

> +
>   static int ssc_probe(struct platform_device *pdev)
>   {
>   	struct resource *regs;
> @@ -235,6 +241,7 @@ static int ssc_probe(struct platform_device *pdev)
>   	}
>
>   	spin_lock(&user_lock);
> +	pdev->id = ssc_device_id++;
>   	list_add_tail(&ssc->list, &ssc_list);
>   	spin_unlock(&user_lock);
>
>

Best Regards,
Bo Shen
