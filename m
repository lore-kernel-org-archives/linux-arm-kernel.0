From: stern@rowland.harvard.edu (Alan Stern)
Date: Tue, 28 Feb 2012 10:01:29 -0500 (EST)
Subject: [PATCH v2] USB: Support for LPC32xx SoC
In-Reply-To: <201202272201.14665.arnd@arndb.de>
Message-ID: <Pine.LNX.4.44L0.1202280951440.1456-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 27 Feb 2012, Arnd Bergmann wrote:

> > The generic driver, as you'll see when you read the patch, includes 
> > generic versions of the various routines that a bus glue file has to 
> > provide (probe, remove, initialize, and so on).
> 
> Ok, I see. Nevermind then, I don't think this will help to solve
> the problem of building multiple ARM platforms together when they
> provide conflicting bus glues, although it seems generally to be
> a good idea in order to reduce the number of platform glues that there
> are
> 
> What do you think about an approach like below?

It's heading in the intended direction, although the details might not 
all be quite right -- I didn't check them very closely.

One big thing about it is wrong: Many or most of the functions you
exported don't really need to be.  Instead, ohci-hcd.c should define
ohci_driver (a bus-agnostic hc_driver structure) and export that.  
Then the bus-glue files can copy the structure for their own use during
initialization (rather than duplicating the definition all over the
place) and override individual methods as needed.

It's a more "object-oriented" approach.  :-)

Alan Stern
