From: balbi@ti.com (Felipe Balbi)
Date: Thu, 20 Mar 2014 20:35:57 -0500
Subject: [RFC] possible removal of omap-serial
In-Reply-To: <20140321001228.GA18131@kroah.com>
References: <20140320235210.GB26964@saruman.home>
 <20140321001228.GA18131@kroah.com>
Message-ID: <20140321013557.GB29691@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Mar 20, 2014 at 05:12:28PM -0700, Greg KH wrote:
> On Thu, Mar 20, 2014 at 06:52:10PM -0500, Felipe Balbi wrote:
> > Hi folks,
> > 
> > I've been toying with the idea of removing
> > drivers/tty/serial/omap-serial.c since that's, to put it bluntly, an
> > ungly copy of 8250 driver.
> > 
> > The original concern was wrt suspend/resume but I think it'd be a far
> > better approach to implement runtime PM in 8250 and write a rather small
> > 8250-omap.c glue (much like 8250-acorn.c or 8250-dw.c) just to get the
> > OMAP-specific details out of the way.
> > 
> > The question I have is: omap-serial.c calls the serial devnodes ttyO\d,
> > instead of ttyS\d so removing omap-serial.c would have a direct impact
> > in userland. I wonder if it's an acceptable "regression" considering
> > we'd be able to reuse 8250 gaining proper Flow Control support, proper
> > DMA support, years and years of bug-fixes, etc.
> 
> Breaking device node names is a contentious issue for serial ports, I
> don't think you can do that :(

would an upstream udev rule creating a symbolic link from ttyO to ttyS
be enough ?

I didn't test this yet but I guess this is enough (?)

KERNEL=="ttyO[0-9]", GROUP="dialout", SYMLINK+="ttyS"

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140320/de2b9cbe/attachment-0001.sig>
