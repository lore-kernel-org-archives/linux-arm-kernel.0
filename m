From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 4 Nov 2018 13:30:02 +0100
Subject: [PATCH 07/15] Platform: OLPC: Avoid a warning if the EC didn't
 register yet
In-Reply-To: <20181010172300.317643-8-lkundrak@v3.sk>
References: <20181010172300.317643-1-lkundrak@v3.sk>
 <20181010172300.317643-8-lkundrak@v3.sk>
Message-ID: <20181104123002.GA23864@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2018-10-10 19:22:52, Lubomir Rintel wrote:
> Just return ENODEV, so that whoever attempted to use the EC call can
> defer their work.
> 
> Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>

Acked-by: Pavel Machek <pavel@ucw.cz>

> ---
>  drivers/platform/olpc/olpc-ec.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/platform/olpc/olpc-ec.c b/drivers/platform/olpc/olpc-ec.c
> index 35a21c66cd0d..342f5bb7f7a8 100644
> --- a/drivers/platform/olpc/olpc-ec.c
> +++ b/drivers/platform/olpc/olpc-ec.c
> @@ -116,8 +116,11 @@ int olpc_ec_cmd(u8 cmd, u8 *inbuf, size_t inlen, u8 *outbuf, size_t outlen)
>  	struct olpc_ec_priv *ec = ec_priv;
>  	struct ec_cmd_desc desc;
>  
> -	/* Ensure a driver and ec hook have been registered */
> -	if (WARN_ON(!ec_driver || !ec_driver->ec_cmd))
> +	/* Driver not yet registered. */
> +	if (!ec_driver)
> +		return -ENODEV;
> +
> +	if (WARN_ON(!ec_driver->ec_cmd))
>  		return -ENODEV;
>  
>  	if (!ec)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181104/baa3b3fd/attachment-0001.sig>
