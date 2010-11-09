From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Nov 2010 15:44:39 +0000
Subject: [PATCH] pl011: added clock management feature
In-Reply-To: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
References: <1289316637-7828-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20101109154439.GA7973@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 09, 2010 at 04:30:37PM +0100, Linus Walleij wrote:
> From: Grzegorz Sygieda <grzegorz.sygieda@tieto.com>
> 
> This patch allows to control the pl011 clock using set_termios
> callback. Any positive baudrate passed enables clock, otherwise
> disables. This saves a lot of power on submicron designs since
> we can clock off and disable unused UARTs.

Why not just close the port to save power - the clock in that case will
automatically be turned off.

It's not like the port can be used without the baud rate correctly set -
or indeed characters transmitted or received without the clock running.
So all the time that the clock is disabled, the port is inoperable.

If you want to maintain the modem control line settings while the port
is closed, why not clear the HUPCL termios flag?
