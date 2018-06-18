From: hugues.fruchet@st.com (Hugues FRUCHET)
Date: Mon, 18 Jun 2018 09:36:28 +0000
Subject: [PATCH] media: stm32-dcmi: simplify of_node_put usage
In-Reply-To: <1528824196-19149-1-git-send-email-hofrat@osadl.org>
References: <1528824196-19149-1-git-send-email-hofrat@osadl.org>
Message-ID: <1b951a4b-4583-5cc2-c54a-4de1196e1653@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicholas,
Thanks for patch,

On 06/12/2018 07:23 PM, Nicholas Mc Guire wrote:
> This does not fix any bug - this is just a code simplification. As
> np is not used after passing it to v4l2_fwnode_endpoint_parse() its
> refcount can be decremented immediately and at one location.
> 
> Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Acked-by: Hugues Fruchet <hugues.fruchet@st.com>

> ---
> 
> Issue found during code reading.
> 
> Patch was compile tested with: x86_64_defconfig, MEDIA_SUPPORT=y
> MEDIA_CAMERA_SUPPORT=y, V4L_PLATFORM_DRIVERS=y, OF=y, COMPILE_TEST=y
> CONFIG_VIDEO_STM32_DCMI=y
> (There are a few sparse warnings - but unrelated to the lines changed)
> 
> Patch is against 4.17.0 (localversion-next is next-20180608)
> 
>   drivers/media/platform/stm32/stm32-dcmi.c | 5 +----
>   1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/media/platform/stm32/stm32-dcmi.c b/drivers/media/platform/stm32/stm32-dcmi.c
> index 2e1933d..0b61042 100644
> --- a/drivers/media/platform/stm32/stm32-dcmi.c
> +++ b/drivers/media/platform/stm32/stm32-dcmi.c
> @@ -1696,23 +1696,20 @@ static int dcmi_probe(struct platform_device *pdev)
>   	}
>   
>   	ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(np), &ep);
> +	of_node_put(np);
>   	if (ret) {
>   		dev_err(&pdev->dev, "Could not parse the endpoint\n");
> -		of_node_put(np);
>   		return -ENODEV;
>   	}
>   
>   	if (ep.bus_type == V4L2_MBUS_CSI2) {
>   		dev_err(&pdev->dev, "CSI bus not supported\n");
> -		of_node_put(np);
>   		return -ENODEV;
>   	}
>   	dcmi->bus.flags = ep.bus.parallel.flags;
>   	dcmi->bus.bus_width = ep.bus.parallel.bus_width;
>   	dcmi->bus.data_shift = ep.bus.parallel.data_shift;
>   
> -	of_node_put(np);
> -
>   	irq = platform_get_irq(pdev, 0);
>   	if (irq <= 0) {
>   		dev_err(&pdev->dev, "Could not get irq\n");
> 
