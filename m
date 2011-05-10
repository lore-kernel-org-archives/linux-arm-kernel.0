From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 22:45:18 +0100
Subject: [PATCH 0/4] Pinmux subsystem
In-Reply-To: <BANLkTikSwkYEvbQ8XVrB3LUetVqBBUjT2g@mail.gmail.com>
References: <1304363768-30338-1-git-send-email-linus.walleij@stericsson.com>
	<20110502225708.GD28001@n2100.arm.linux.org.uk>
	<BANLkTikSwkYEvbQ8XVrB3LUetVqBBUjT2g@mail.gmail.com>
Message-ID: <20110510214518.GB5315@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 10, 2011 at 11:25:44PM +0200, Linus Walleij wrote:
> It can, basically:
> 
> struct pinmux *pmx;
> 
> pmx = pinmux_get(dev, "irda-uart");
> pinmux_enable(pmx);
> (... SIR UART operations ...)
> pinmux_disable(pmx);
> pinmux_put(pmx);
> (... stuff to init FIR silicon ...)
> pmx = pinmux_get(dev, "irda-fir");
> pinmux_enable(pmx);
> (... etc ...)

You really don't want to do this.  It's not that SIR and FIR are that
exclusive.  You only switch to FIR mode when you've negotiated in SIR
mode, and then there's tight timings for doing that.  Essentially you
agree in SIR mode to switch to FIR mode, switch to FIR mode and expect
a response in FIR mode from the remote end.

Calling out to lots of functions to perform the switch is asking for
that response to be missed because you've not set things up for it.

You'd want to have SIR and FIR mode 'got', and then switch as quickly
as possible between them.
