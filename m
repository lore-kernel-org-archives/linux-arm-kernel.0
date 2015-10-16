From: m-karicheri2@ti.com (Murali Karicheri)
Date: Fri, 16 Oct 2015 10:00:45 -0400
Subject: [PATCH linux-next] soc: ti: use request_firmware_direct() as
 acc firmware is optional
In-Reply-To: <1444935553-19760-1-git-send-email-m-karicheri2@ti.com>
References: <1444935553-19760-1-git-send-email-m-karicheri2@ti.com>
Message-ID: <5621030D.4090800@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/15/2015 02:59 PM, Murali Karicheri wrote:
> When firmware image for PDSP firmware is absent in the file system
> the kernel boot with ramfs/nfs is stuck for 60 seconds being the
> the default timeout. request_firmware_direct() is to take care of
> such optional firmware loading and hence replace the call in the
> driver with this API.
>
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
> ---
>   drivers/soc/ti/knav_qmss_queue.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
> index f3a0b6a..89789e2 100644
> --- a/drivers/soc/ti/knav_qmss_queue.c
> +++ b/drivers/soc/ti/knav_qmss_queue.c
> @@ -1519,9 +1519,9 @@ static int knav_queue_load_pdsp(struct knav_device *kdev,
>
>   	for (i = 0; i < ARRAY_SIZE(knav_acc_firmwares); i++) {
>   		if (knav_acc_firmwares[i]) {
> -			ret = request_firmware(&fw,
> -					       knav_acc_firmwares[i],
> -					       kdev->dev);
> +			ret = request_firmware_direct(&fw,
> +						      knav_acc_firmwares[i],
> +						      kdev->dev);
>   			if (!ret) {
>   				found = true;
>   				break;
>
Santosh,

If this looks good, could you please send this to linux-next?  Without 
this, Linux boot will see a pause for about 60 seconds if qmss acc 
firmware is not present in the file system. So this is a must for next.

-- 
Murali Karicheri
Linux Kernel, Keystone
