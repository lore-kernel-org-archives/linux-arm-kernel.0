From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Sep 2012 19:57:48 +0100
Subject: [PATCH 1/3] serial: pl011: safeguard against impossible baudrates
In-Reply-To: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
References: <1348134346-25593-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20120920185748.GA15609@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 20, 2012 at 11:45:46AM +0200, Linus Walleij wrote:
> +	if ((termios->c_ispeed > max_baud) ||
> +	    (termios->c_ospeed > max_baud)) {
> +		dev_err(port->dev,
> +			"requested a baud rate > clock/mindivisor\n");
> +		return;
> +	}

Why do we need this check?  In any case, this is incorrect behaviour
just to 'return' from this function without doing anything.  You just
produce an error message, and userspace believes that it's request
has been satisfied.

uart_get_baud_rate() is there precisely to do the right thing for invalid
baud rates, which is to fallback to the old termios setting (and update
the new termios with that) if the old termios setting satisifies the
limits, if not it falls back to something within the limited range.
