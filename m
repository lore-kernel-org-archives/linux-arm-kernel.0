From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Wed, 8 Jul 2015 15:03:23 +0300
Subject: [PATCH v2 1/5] usb: gadget: ffs: call functionfs_unbind() if
 _ffs_func_bind() fails
In-Reply-To: <1436346323-31593-2-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
 <1436346323-31593-2-git-send-email-r.baldyga@samsung.com>
Message-ID: <559D118B.3050607@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 7/8/2015 12:05 PM, Robert Baldyga wrote:

> Function ffs_do_functionfs_bind() calls functionfs_bind() which allocates
> usb request and increments refcounts. These things needs to be cleaned
> up by if further steps of initialization fail by calling functionfs_unbind().

> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>
> ---
>   drivers/usb/gadget/function/f_fs.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6e7be91..6516187 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -2897,11 +2897,18 @@ static int ffs_func_bind(struct usb_configuration *c,
>   			 struct usb_function *f)
>   {
>   	struct f_fs_opts *ffs_opts = ffs_do_functionfs_bind(f, c);
> +	struct ffs_function *func = ffs_func_from_usb(f);
> +	int ret;
>
>   	if (IS_ERR(ffs_opts))
>   		return PTR_ERR(ffs_opts);
>
> -	return _ffs_func_bind(c, f);
> +	ret = _ffs_func_bind(c, f);
> +	if (ret)
> +		if(!--ffs_opts->refcnt)
> +			functionfs_unbind(func->ffs);

    Hum, I think you need {} around the outer *if* clause. Either that, or 
just fold two *if* statments together.

> +
> +	return ret;
>   }
[...]

WBR, Sergei
