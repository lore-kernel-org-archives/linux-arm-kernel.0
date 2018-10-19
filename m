From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Fri, 19 Oct 2018 16:11:50 +0300
Subject: [PATCH 07/15] Platform: OLPC: Avoid a warning if the EC didn't
 register yet
In-Reply-To: <20181010172300.317643-8-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-8-lkundrak@v3.sk>
Message-ID: <CAHp75Ve7v0xL-qd5Ri82W1z7jku_Mbxg531J_261-EW0dxsouQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 10, 2018 at 8:23 PM Lubomir Rintel <lkundrak@v3.sk> wrote:
>
> Just return ENODEV, so that whoever attempted to use the EC call can
> defer their work.
>
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
> ---
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..342f5bb7f7a8 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>         struct olpc_ec_priv *ec = ec_priv;
>         struct ec_cmd_desc desc;
>
> -       /* Ensure a driver and ec hook have been registered */
> -       if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +       /* Driver not yet registered. */
> +       if (!ec_driver)
> +               return -ENODEV;

Why -ENODEV is preferred over -EPROBE_DEFER?

> +
> +       if (WARN_ON(!ec_driver->ec_cmd))
>                 return -ENODEV;
>
>         if (!ec)
> --
> 2.19.0
>


-- 
With Best Regards,
Andy Shevchenko
