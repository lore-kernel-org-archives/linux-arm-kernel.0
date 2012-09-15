From: francescolavra.fl@gmail.com (Francesco Lavra)
Date: Sat, 15 Sep 2012 17:52:54 +0200
Subject: [PATCH 07/11] tty/serial: Add kgdb_nmi driver
In-Reply-To: <1347548615-18227-7-git-send-email-anton.vorontsov@linaro.org>
References: <20120913150133.GA16238@lizard>
 <1347548615-18227-7-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <5054A456.80606@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 05:03 PM, Anton Vorontsov wrote:
...
> +static int kgdb_nmi_tty_install(struct tty_driver *drv, struct tty_struct *tty)
> +{
> +	struct kgdb_nmi_tty_priv *priv;
> +	int ret;
> +
> +	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +
> +	INIT_KFIFO(priv->fifo);
> +	tasklet_init(&priv->tlet, kgdb_nmi_tty_receiver, (unsigned long)priv);
> +	tty_port_init(&priv->port);
> +	priv->port.ops = &kgdb_nmi_tty_port_ops;
> +	tty->driver_data = priv;
> +
> +	ret = tty_port_install(&priv->port, drv, tty);
> +	if (ret) {
> +		pr_err("%s: can't nstall tty port: %d\n", __func__, ret);

s/nstall/install

...
> diff --git a/drivers/tty/serial/kgdboc.c b/drivers/tty/serial/kgdboc.c
> index 2b42a01..ed97cfd 100644
> --- a/drivers/tty/serial/kgdboc.c
> +++ b/drivers/tty/serial/kgdboc.c
> @@ -145,6 +145,8 @@ __setup("kgdboc=", kgdboc_option_setup);
>  
>  static void cleanup_kgdboc(void)
>  {
> +	if (kgdb_unregister_nmi_console())
> +		return;
>  	kgdboc_unregister_kbd();
>  	if (configured == 1)
>  		kgdb_unregister_io_module(&kgdboc_io_ops);
> @@ -198,6 +200,10 @@ do_register:
>  	if (err)
>  		goto noconfig;
>  
> +	err = kgdb_register_nmi_console();
> +	if (err)
> +		goto noconfig;

If kgdb_register_nmi_console() fails, kgdb_unregister_io_module() must
be called for proper cleanup

--
Francesco
