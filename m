From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 07 Sep 2016 01:09:36 +0200
Subject: [PATCH v2 06/10] driver core: Avoid endless recursion if device
 has more than one link
In-Reply-To: <1466144820-6286-7-git-send-email-m.szyprowski@samsung.com>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com>
 <1466144820-6286-7-git-send-email-m.szyprowski@samsung.com>
Message-ID: <1633380.7F0afK1dbG@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, June 17, 2016 08:26:56 AM Marek Szyprowski wrote:
> This patch fixes endless recursion, which happends when device has
> more than one link.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/base/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 215cd44de761..4e778539b750 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -57,7 +57,8 @@ static int device_reorder_to_tail(struct device *dev, void *not_used)
>  	device_pm_move_last(dev);
>  	device_for_each_child(dev, NULL, device_reorder_to_tail);
>  	list_for_each_entry(link, &dev->consumer_links, c_node)
> -		device_reorder_to_tail(link->consumer, NULL);
> +		if (link->consumer != dev)
> +			device_reorder_to_tail(link->consumer, NULL);
>  
>  	return 0;
>  }
> 

If I'm not mistaken, this should not be necessary unless dev has a link
pointing to itself as a consumer.  That would be a bug, though.

I can add a WARN_ON() to catch this case, but then if there's a link from
a consumer of dev pointing back to dev as a consumer, that still will loop
forever.

I guess we need to detect circular dependencies and fail link creation in
such cases.  Oh well.

Thanks,
Rafael
