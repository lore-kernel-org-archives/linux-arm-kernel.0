From: mina86@mina86.com (Michal Nazarewicz)
Date: Wed, 08 Jul 2015 15:44:44 +0200
Subject: [PATCH v2 1/5] usb: gadget: ffs: call functionfs_unbind() if
 _ffs_func_bind() fails
In-Reply-To: <1436346323-31593-2-git-send-email-r.baldyga@samsung.com>
References: <1436346323-31593-1-git-send-email-r.baldyga@samsung.com>
 <1436346323-31593-2-git-send-email-r.baldyga@samsung.com>
Message-ID: <xa1tio9udar7.fsf@mina86.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08 2015, Robert Baldyga wrote:
> Function ffs_do_functionfs_bind() calls functionfs_bind() which allocates
> usb request and increments refcounts. These things needs to be cleaned
> up by if further steps of initialization fail by calling functionfs_unbind().
>
> Signed-off-by: Robert Baldyga <r.baldyga@samsung.com>

Acked-by: Michal Nazarewicz <mina86@mina86.com>

> ---
>  drivers/usb/gadget/function/f_fs.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/gadget/function/f_fs.c b/drivers/usb/gadget/function/f_fs.c
> index 6e7be91..6516187 100644
> --- a/drivers/usb/gadget/function/f_fs.c
> +++ b/drivers/usb/gadget/function/f_fs.c
> @@ -2897,11 +2897,18 @@ static int ffs_func_bind(struct usb_configuration *c,
>  			 struct usb_function *f)
>  {
>  	struct f_fs_opts *ffs_opts = ffs_do_functionfs_bind(f, c);
> +	struct ffs_function *func = ffs_func_from_usb(f);
> +	int ret;
>  
>  	if (IS_ERR(ffs_opts))
>  		return PTR_ERR(ffs_opts);
>  
> -	return _ffs_func_bind(c, f);
> +	ret = _ffs_func_bind(c, f);
> +	if (ret)
> +		if(!--ffs_opts->refcnt)
> +			functionfs_unbind(func->ffs);
> +
> +	return ret;
>  }
>  
>  
> -- 
> 1.9.1
>

-- 
Best regards,                                         _     _
.o. | Liege of Serenely Enlightened Majesty of      o' \,=./ `o
..o | Computer Science,  Micha? ?mina86? Nazarewicz    (o o)
ooo +--<mpn@google.com>--<xmpp:mina86@jabber.org>--ooO--(_)--Ooo--
