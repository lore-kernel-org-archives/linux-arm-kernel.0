From: rabin.vincent@stericsson.com (Rabin VINCENT)
Date: Wed, 10 Feb 2010 19:15:21 +0530
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100210011637.GA8683@shareable.org>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
	<20100209221449.GA23083@n2100.arm.linux.org.uk>
	<20100210011637.GA8683@shareable.org>
Message-ID: <20100210134515.GA2844@bnru01.bnr.st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2010 at 02:16:37AM +0100, Jamie Lokier wrote:
> Russell King - ARM Linux wrote:
> > This means that when the kernel's buffers fill up, the kernel calls
> > down to the serial core layer to throttle the input.  This then
> > calls into the set_mctrl function to de-assert RTS.  However, because
> > the hardware ignores the requested software state, the RTS signal
> > is not de-asserted, and the remote end continues sending data.
> > 
> > So, enabling hardware auto-RTS is bad news - you will lose data if
> > the application stops reading data.
> 
[..]
> The ideal combination may be a bit of both:
> 
>     1. When kernel deasserts RTS, do that and disable hardware-RTS
>        so it really is deasserted.
> 
>     2. When kernel asserts RTS with mctrl, enable hardware-RTS
>        so what's output depends on the receive FIFO state.

I've implemented this in the updated patch below.
