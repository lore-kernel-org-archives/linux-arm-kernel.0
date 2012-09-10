From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 10 Sep 2012 12:13:20 +0100
Subject: [PATCH 06/14] tty/serial/core: Introduce poll_init callback
In-Reply-To: <20120910041335.GF29537@lizard>
References: <20120910040802.GA1261@lizard>
	<20120910041335.GF29537@lizard>
Message-ID: <20120910121320.03c9dfc7@pyramind.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +	tport = &state->port;
> +	if (!(tport->flags & ASYNC_INITIALIZED) && port->ops->poll_init) {
> +		mutex_lock(&tport->mutex);
> +		ret = port->ops->poll_init(port);
> +		/*
> +		 * We don't set ASYNCB_INITIALIZED as we only initialized the
> +		 * hw, e.g. state->xmit is still uninitialized.
> +		 */
> +		mutex_unlock(&tport->mutex);
> +		if (ret)
> +			return ret;
> +	}

What stops a parallel open or close changing ASYNC_INITIALIZED after you
test and before you lock ?

Alan
