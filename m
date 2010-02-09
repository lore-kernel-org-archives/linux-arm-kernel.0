From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Feb 2010 22:14:49 +0000
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100209143055.GA6015@bnru01.bnr.st.com>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
Message-ID: <20100209221449.GA23083@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 09, 2010 at 08:00:56PM +0530, Rabin VINCENT wrote:
> On Mon, Feb 08, 2010 at 02:51:24PM +0100, Russell King - ARM Linux wrote:
> > On Mon, Feb 08, 2010 at 07:11:50PM +0530, Rabin Vincent wrote:
> > > Enable/disable hardware flow control as requested by the termios.
> > 
> > From what I remember, I didn't implement this because there were
> > corner cases to be dealt with.  I don't remember what they were
> > off hand though.
> 
> We haven't seen any problems with it thus far.  Nothing obvious strikes
> me on rechecking the pl011 spec; it would be helpful if you could
> elaborate.

Right, the problem with RTS flow control is that if you enable it,
the hardware takes full control of the RTS signal.

This means that when the kernel's buffers fill up, the kernel calls
down to the serial core layer to throttle the input.  This then
calls into the set_mctrl function to de-assert RTS.  However, because
the hardware ignores the requested software state, the RTS signal
is not de-asserted, and the remote end continues sending data.

So, enabling hardware auto-RTS is bad news - you will lose data if
the application stops reading data.

Auto-CTS flow control looks safe.
