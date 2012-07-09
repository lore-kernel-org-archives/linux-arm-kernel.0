From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 9 Jul 2012 13:14:40 +0200
Subject: [PATCH] i2c: mxs: mxs_i2c_finish_read: mute flase positive
 uninitialized var
In-Reply-To: <1341178470-14904-1-git-send-email-mkl@pengutronix.de>
References: <1341178470-14904-1-git-send-email-mkl@pengutronix.de>
Message-ID: <20120709111440.GF1296@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 01, 2012 at 11:34:30PM +0200, Marc Kleine-Budde wrote:
> This patch mutes the false positive compiler warning:
> 
> drivers/i2c/busses/i2c-mxs.c: In function 'mxs_i2c_xfer_msg':
> drivers/i2c/busses/i2c-mxs.c:206:8: warning: 'data' may be used uninitialized in this function [-Wuninitialized]
> drivers/i2c/busses/i2c-mxs.c:196:6: note: 'data' was declared here
> 
> Cc: "Wolfram Sang" <w.sang@pengutronix.de>

FYI: Checkpatch complains about the position of the quotes above.

> Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>

Applied. I didn't know the exact intention of 'uninitialized_var'
before. Its commit message (9490991482a2091a828d997adbc088e24c310a4d)
convinces me to accept this compromise. It will silence the warning, but
it can be disabled if such warnings want to be seen. Also, there is no
extra code added like with '= 0'.

I still do think however, gcc should be able to find out what happens.
There is no pointer magic involved here...

> ---
>  drivers/i2c/busses/i2c-mxs.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/i2c/busses/i2c-mxs.c b/drivers/i2c/busses/i2c-mxs.c
> index 04eb441..02ce1fa 100644
> --- a/drivers/i2c/busses/i2c-mxs.c
> +++ b/drivers/i2c/busses/i2c-mxs.c
> @@ -193,7 +193,7 @@ static int mxs_i2c_wait_for_data(struct mxs_i2c_dev *i2c)
>  
>  static int mxs_i2c_finish_read(struct mxs_i2c_dev *i2c, u8 *buf, int len)
>  {
> -	u32 data;
> +	u32 uninitialized_var(data);
>  	int i;
>  
>  	for (i = 0; i < len; i++) {
> -- 
> 1.7.10
> 

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120709/ddcd158c/attachment.sig>
