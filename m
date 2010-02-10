From: jamie@shareable.org (Jamie Lokier)
Date: Wed, 10 Feb 2010 10:12:02 +0000
Subject: [PATCH] amba-pl011: support hardware flow control
In-Reply-To: <20100210083012.GA11701@n2100.arm.linux.org.uk>
References: <1265636510-27679-1-git-send-email-rabin.vincent@stericsson.com>
	<20100208135124.GA26608@n2100.arm.linux.org.uk>
	<20100209143055.GA6015@bnru01.bnr.st.com>
	<20100209221449.GA23083@n2100.arm.linux.org.uk>
	<20100210011637.GA8683@shareable.org>
	<20100210083012.GA11701@n2100.arm.linux.org.uk>
Message-ID: <20100210101202.GA21829@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Wed, Feb 10, 2010 at 01:16:37AM +0000, Jamie Lokier wrote:
> > Russell King - ARM Linux wrote:
> > > This means that when the kernel's buffers fill up, the kernel calls
> > > down to the serial core layer to throttle the input.  This then
> > > calls into the set_mctrl function to de-assert RTS.  However, because
> > > the hardware ignores the requested software state, the RTS signal
> > > is not de-asserted, and the remote end continues sending data.
> > > 
> > > So, enabling hardware auto-RTS is bad news - you will lose data if
> > > the application stops reading data.
> > 
> > Surely the driver can just stop reading from the UART when the
> > kernel's buffers are full and hardware-RTS is enabled.  Then the
> > hardware will deassert RTS itself.
> 
> I'll let you work out how to implement that.

You have a point.

What do you think of the other suggestion, switching between
software-RTS+deasserted and hardware-RTS in response to set_mctrl
calls from the generic serial layer - effectively hardware-RTS with
ability for kernel to force it deasserted?

-- Jamie
