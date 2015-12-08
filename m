From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 08 Dec 2015 10:10:47 -0800
Subject: [PATCH net-next 1/2] net: hns: enet specisies a reference to dsaf
In-Reply-To: <1449302356-54658-2-git-send-email-yankejian@huawei.com>
References: <1449302356-54658-1-git-send-email-yankejian@huawei.com>
 <1449302356-54658-2-git-send-email-yankejian@huawei.com>
Message-ID: <56671D27.5070700@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Subject: s/specisies/specifies/?

On 04/12/15 23:59, yankejian wrote:
> enet is associating with dasf. before this patch, the association is
> the same strings between ae-name and dsa-name. in a general way, enet
> specifies a reference to dsaf should be a good idea. so this patch
> deletes the ae-name in enet, and adds parsing the ae-handle
> from DT to set the associating with dsaf.
> 
> Signed-off-by: yankejian <yankejian@huawei.com>
> ---
[snip]

> diff --git a/drivers/net/ethernet/hisilicon/hns/hnae.c b/drivers/net/ethernet/hisilicon/hns/hnae.c
> index b364529..3bfe36f 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hnae.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hnae.c
> @@ -95,21 +95,17 @@ static struct hnae_buf_ops hnae_bops = {
>  static int __ae_match(struct device *dev, const void *data)
>  {
>  	struct hnae_ae_dev *hdev = cls_to_ae_dev(dev);
> -	const char *ae_id = data;
>  
> -	if (!strncmp(ae_id, hdev->name, AE_NAME_SIZE))
> -		return 1;
> -
> -	return 0;
> +	return hdev->dev->of_node == data;
>  }
>  
> -static struct hnae_ae_dev *find_ae(const char *ae_id)
> +static struct hnae_ae_dev *find_ae(const struct device_node *ae_node)
>  {
>  	struct device *dev;
>  
> -	WARN_ON(!ae_id);
> +	WARN_ON(!ae_node);
>  
> -	dev = class_find_device(hnae_class, NULL, ae_id, __ae_match);
> +	dev = class_find_device(hnae_class, NULL, ae_node, __ae_match);

of_find_net_device_by_node might be used for this maybe?
-- 
Florian
