From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 11 Sep 2012 15:14:20 +0100
Subject: [PATCH 08/12] tty/serial: Add kgdb_nmi driver
In-Reply-To: <1347356106-25368-8-git-send-email-anton.vorontsov@linaro.org>
References: <20120911093042.GA12471@lizard>
 <1347356106-25368-8-git-send-email-anton.vorontsov@linaro.org>
Message-ID: <20120911151420.14a29485@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> +struct kgdb_nmi_tty_priv {
> +	struct tty_port port;
> +	int opened;
> +	struct tasklet_struct tlet;
> +	STRUCT_KFIFO(char, KGDB_NMI_FIFO_SIZE) fifo;

I don't see where "opened" is used.


> +static const struct tty_operations kgdb_nmi_tty_ops = {
> +	.open		= kgdb_nmi_tty_open,
> +	.close		= kgdb_nmi_tty_close,
> +	.install	= kgdb_nmi_tty_install,
> +	.cleanup	= kgdb_nmi_tty_cleanup,
> +	.write_room	= kgdb_nmi_tty_write_room,
> +	.write		= kgdb_nmi_tty_write,

And a hangup method (just using tty_port helpers will do the job - it's
needed so vhangup() works as expected on a port)


Alan
