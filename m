From: thierry.reding@gmail.com (Thierry Reding)
Date: Mon, 19 Aug 2013 21:46:04 +0200
Subject: [PATCH RESEND] i2c: move of helpers into the core
In-Reply-To: <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
References: <1376918361-7014-1-git-send-email-wsa@the-dreams.de>
 <1376935183-11218-1-git-send-email-wsa@the-dreams.de>
Message-ID: <20130819194603.GC4961@mithrandir>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 19, 2013 at 07:59:40PM +0200, Wolfram Sang wrote:
[...]
> diff --git a/drivers/i2c/i2c-core.c b/drivers/i2c/i2c-core.c
[...]
> +#if IS_ENABLED(CONFIG_OF)
> +static void of_i2c_register_devices(struct i2c_adapter *adap)
> +{
[...]
> +}
[...]
> +#endif /* CONFIG_OF */

Isn't this missing the dummy implementation for !OF.

>  static int i2c_do_add_adapter(struct i2c_driver *driver,
>  			      struct i2c_adapter *adap)
>  {
> @@ -1058,6 +1160,8 @@ static int i2c_register_adapter(struct i2c_adapter *adap)
>  
>  exit_recovery:
>  	/* create pre-declared device nodes */
> +	of_i2c_register_devices(adap);

Alternatively you could remove the of_i2c_register_devices() from the
"#ifdef CONFIG_OF" block so that it will always be compiled. You could
turn the above into

	if (IS_ENABLED(CONFIG_OF))
		of_i2c_register_devices(adap);

and let the compiler throw the static function away if it sees that the
condition is always false.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130819/39b2197d/attachment.sig>
