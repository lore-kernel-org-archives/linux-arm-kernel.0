From: anton.vorontsov@linaro.org (Anton Vorontsov)
Date: Mon, 10 Sep 2012 10:57:25 -0700
Subject: [PATCH 06/14] tty/serial/core: Introduce poll_init callback
In-Reply-To: <20120910121320.03c9dfc7@pyramind.ukuu.org.uk>
References: <20120910040802.GA1261@lizard> <20120910041335.GF29537@lizard>
 <20120910121320.03c9dfc7@pyramind.ukuu.org.uk>
Message-ID: <20120910175725.GA13673@lizard>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 10, 2012 at 12:13:20PM +0100, Alan Cox wrote:
> > +	tport = &state->port;
> > +	if (!(tport->flags & ASYNC_INITIALIZED) && port->ops->poll_init) {
> > +		mutex_lock(&tport->mutex);
> > +		ret = port->ops->poll_init(port);
> > +		/*
> > +		 * We don't set ASYNCB_INITIALIZED as we only initialized the
> > +		 * hw, e.g. state->xmit is still uninitialized.
> > +		 */
> > +		mutex_unlock(&tport->mutex);
> > +		if (ret)
> > +			return ret;
> > +	}
> 
> What stops a parallel open or close changing ASYNC_INITIALIZED after you
> test and before you lock ?

Yeah, I should do the whole thing under the mutex.

Not related to this particular issue, but the fact that close() can powerdown
the hardware is quite bad. Today it is always possible to use open,close
sequence on /dev/ttyXXXX, and polling would break if close() deinitializes the
hardware (e.g. via uart_change_pm()).

In console= case, serial core handles the issue via uart_console(), checking if
the port is used for console, preventing it to power down the hardware. We can
do the same, or make tty_find_polling_driver() refcount individual ports/lines.
But the issue is orthogonal to this particular patch, although needs to be
fixed some day.

Thanks!

Anton.
