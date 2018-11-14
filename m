From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Wed, 14 Nov 2018 16:04:19 +0100
Subject: [PATCH][staging-next] drivers: staging: cedrus: find ctx before
 dereferencing it ctx
In-Reply-To: <20181102190126.5628-1-colin.king@canonical.com>
References: <20181102190126.5628-1-colin.king@canonical.com>
Message-ID: <c54b52b2-c0b2-6afc-ad35-bbf396650418@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/02/18 20:01, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Currently if count is an invalid value the v4l2_info message will
> dereference a null ctx pointer to get the dev information. Fix
> this by finding ctx first and then checking for an invalid count,
> this way ctxt will be non-null hence avoiding the null pointer
> dereference.
> 
> Detected by CoverityScan, CID#1475337 ("Explicit null dereferenced")
> 
> Fixes: 50e761516f2b ("media: platform: Add Cedrus VPU decoder driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/media/sunxi/cedrus/cedrus.c | 22 ++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/staging/media/sunxi/cedrus/cedrus.c b/drivers/staging/media/sunxi/cedrus/cedrus.c
> index 82558455384a..699d62dceb6c 100644
> --- a/drivers/staging/media/sunxi/cedrus/cedrus.c
> +++ b/drivers/staging/media/sunxi/cedrus/cedrus.c
> @@ -108,17 +108,6 @@ static int cedrus_request_validate(struct media_request *req)
>  	unsigned int count;
>  	unsigned int i;
>  
> -	count = vb2_request_buffer_cnt(req);
> -	if (!count) {
> -		v4l2_info(&ctx->dev->v4l2_dev,
> -			  "No buffer was provided with the request\n");
> -		return -ENOENT;
> -	} else if (count > 1) {
> -		v4l2_info(&ctx->dev->v4l2_dev,
> -			  "More than one buffer was provided with the request\n");
> -		return -EINVAL;
> -	}
> -
>  	list_for_each_entry(obj, &req->objects, list) {
>  		struct vb2_buffer *vb;
>  
> @@ -133,6 +122,17 @@ static int cedrus_request_validate(struct media_request *req)
>  	if (!ctx)
>  		return -ENOENT;
>  
> +	count = vb2_request_buffer_cnt(req);
> +	if (!count) {
> +		v4l2_info(&ctx->dev->v4l2_dev,
> +			  "No buffer was provided with the request\n");
> +		return -ENOENT;
> +	} else if (count > 1) {
> +		v4l2_info(&ctx->dev->v4l2_dev,
> +			  "More than one buffer was provided with the request\n");
> +		return -EINVAL;
> +	}
> +

Is this right? If there are no buffers in the request, then the list_for_each_entry()
loop won't find a ctx either. This needs to be done differently: for these initial
v4l2_info() statements you can get the cedrus_dev struct from req->mdev since the
media_device is embedded in the cedrus_dev struct. In other words, some
container_of magic is needed here.

Regards,

	Hans

>  	parent_hdl = &ctx->hdl;
>  
>  	hdl = v4l2_ctrl_request_hdl_find(req, parent_hdl);
> 
