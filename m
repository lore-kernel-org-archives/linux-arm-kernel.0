From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 31 Jan 2018 12:19:31 +0000
Subject: Handling of chars received while a UART is not open
In-Reply-To: <20180131120628.GL5862@e103592.cambridge.arm.com>
References: <20180131120628.GL5862@e103592.cambridge.arm.com>
Message-ID: <20180131121931.GH9418@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 31, 2018 at 12:06:29PM +0000, Dave Martin wrote:
> Hi all,
> 
> Question:
> 
>  1) Should a UART definitely discard the RX FIFO on ->startup()?

Yes; POSIX makes no guarantees about the configuration of the port
while it is closed, and when it is re-opened, it is permitted that
the port is reset back to a set of default parameters rather than
the previous parameter set that was configured.

You also have the CREAD flag which indicates whether we want the
receiver enabled or not, but it is not defined by POSIX whether the
receiver remains enabled when the port is closed.

Linux behaviour has always been to flush the port of received
characters at close and open time (see 8250 driver), meaning that
characters received while the TTY is closed are ignored - just like
what happens on the physical console keyboard, which is also a TTY.
Doing otherwise is likely to confuse applications and potentially
introduce buggy behaviour that would only be detected on UARTs with
differing behaviour to 8250.

Linux follows POSIX General Terminal Interface for its TTY handling.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
