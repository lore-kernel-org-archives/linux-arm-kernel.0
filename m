From: ryan@bluewatersys.com (Ryan Mallon)
Date: Wed, 20 Jan 2010 09:26:41 +1300
Subject: make PHYS_OFFSET determined at run time (unfinished)
In-Reply-To: <20100119083803.GA17904@pengutronix.de>
References: <20100119083803.GA17904@pengutronix.de>
Message-ID: <4B561581.6060400@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> Hello,
> 
> I'm looking into making PHYS_OFFSET determined at run time.  I saw a
> patch for it that already made it a few times on the list[1].
> 
> I'm not yet done, but first want to announce that I look into that to
> prevent duplicate work---so if you intended to do the same let's look
> together---and to post some clean up patches that are the result up to
> now of my digging in the boot code.
> 
> I will send now three patches in reply to this mail, and later hopefully
> more.
> 
> Best regards
> Uwe
> 
> [1] e.g. http://thread.gmane.org/gmane.linux.ports.arm.kernel/53793/
> 

One of the problems that got brought up previously was the 'make uImage'
can end up generating unbootable images with runtime PHYS_OFFSET. The
older format uImage's (pre 1.3.3) encode a load address (zrealaddr), so
uImage's need to have a fixed load address encoded.

As I stated in the previous thread, this is _not_ a kernel issue,
however it is no good having a kernel which contains support for two
boards which boot from different address and then generating a uImage
which can only boot on one of them without warning the user about this
problem. Otherwise you are going to start getting "I did make uImage and
my board won't boot" problems.

There are a few solutions to this problem:
1) Drop uImage make support and require users generate them manually.
2) Have a uImage offset config option to allow uImage users to specify
what they want the load address to be. See:
http://thread.gmane.org/gmane.linux.ports.arm.kernel/53151/focus=53230
3) Print an error if "make uImage" is run for a kernel which has more
than one boot address (possible?)
4) Use FIT U-Boot images. This is supported from U-Boot 1.3.3 onwards,
however a number of people are still using older U-Boots.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
