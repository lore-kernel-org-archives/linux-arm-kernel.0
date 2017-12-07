From: andrzej.p@samsung.com (Andrzej Pietrasiewicz)
Date: Thu, 07 Dec 2017 15:53:23 +0100
Subject: [PATCH] media: s5p-jpeg: Fix off-by-one problem
In-Reply-To: <20171206163746.8456-1-flavio.ceolin@intel.com>
References: <CGME20171206163802epcas1p3527bd6a922fd31aa80cf349a510a71eb@epcas1p3.samsung.com>
 <20171206163746.8456-1-flavio.ceolin@intel.com>
Message-ID: <67ddf04e-2f0f-c14b-90ce-0f29a3647e16@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

W dniu 06.12.2017 o?17:37, Flavio Ceolin pisze:
> s5p_jpeg_runtime_resume() does not call clk_disable_unprepare() for
> jpeg->clocks[0] when one of the clk_prepare_enable() fails.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Flavio Ceolin <flavio.ceolin@intel.com>

Acked-by: Andrzej Pietrasiewicz <andrzej.p@samsung.com>


> ---
>   drivers/media/platform/s5p-jpeg/jpeg-core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/s5p-jpeg/jpeg-core.c b/drivers/media/platform/s5p-jpeg/jpeg-core.c
> index faac816..79b63da 100644
> --- a/drivers/media/platform/s5p-jpeg/jpeg-core.c
> +++ b/drivers/media/platform/s5p-jpeg/jpeg-core.c
> @@ -3086,7 +3086,7 @@ static int s5p_jpeg_runtime_resume(struct device *dev)
>   	for (i = 0; i < jpeg->variant->num_clocks; i++) {
>   		ret = clk_prepare_enable(jpeg->clocks[i]);
>   		if (ret) {
> -			while (--i > 0)
> +			while (--i >= 0)
>   				clk_disable_unprepare(jpeg->clocks[i]);
>   			return ret;
>   		}
> 
