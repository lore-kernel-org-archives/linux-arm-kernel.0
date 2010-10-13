From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 14 Oct 2010 00:26:04 +0100
Subject: [PATCH] serial: DCC(JTAG) serial and console emulation support
In-Reply-To: <alpine.LFD.2.00.1010131831470.2764@xanadu.home>
References: <1286305668-19987-1-git-send-email-dwalker@codeaurora.org>
	<201010132145.30550.arnd@arndb.de>
	<1286999522.28336.15.camel@c-dwalke-linux.qualcomm.com>
	<201010132210.17061.arnd@arndb.de>
	<1287001466.28336.31.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131638360.2764@xanadu.home>
	<1287002975.28336.44.camel@c-dwalke-linux.qualcomm.com>
	<alpine.LFD.2.00.1010131831470.2764@xanadu.home>
Message-ID: <20101013232604.GA13146@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 13, 2010 at 06:51:52PM -0400, Nicolas Pitre wrote:
> 3) All serial drivers could have migrated to a uniform device node 
>    namespace when RMK revamped support for serial devices, with dynamic 
>    allocation just like everything else.

Wrong.  There was no dynamic allocation, because the layer above did
not support it.

>  Unlike for IDE disks, this 
>    didn't happen unfortunately because some people couldn't get over a 
>    possible device name change (I wonder how they survived the 
>    transition to libata).

I was not, and still am firmly of the opinion that my decision was
the right one to reject your "approach" to forcefully unifying the
serial devices.  It was more of a hack, introducing multiple
special cases for the old 8250-style ports to make it half sort of
work.

Until the tty layer gets fixed so that it doesn't need to be told
that there will be N tty ports attached to D tty driver at the point
in time when D is registered with the tty subsystem, my opinion on
this isn't going to change.  This is why your patches needed to
special case the 8250 driver - so it could register the right number
of 'ttyS' ports.

And to prove the point that my decision was right, the way support
for ttyS port space has gone, there's been an overwhelming desire
to reduce the number of ttyS ports down to the bare minimum - for
common setups to four at the most.  That'll require yet more special
casing to make your idea work.

The big difference between this and SCSI is that SCSI was built from
day one separate the functional drivers from the backing hardware
drivers - which is great when there's an adhered to standard protocol
which everyone follows.  Again, that's not really the case with serial.
SCSI has also had from day one the ability to dynamically register
and unregister hosts and disks in any order, expanding on the fly with
no problem.  That's certainly not the case with the tty subsystem.

Get over it.  Comparing tty with SCSI is absurdly stupid when they're
vastly different beasts.
