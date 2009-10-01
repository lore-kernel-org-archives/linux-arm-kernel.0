From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 1 Oct 2009 19:39:50 +0100
Subject: [PATCH 1/4] Made VMALLOC_END of type unsigned long.
In-Reply-To: <20091001183248.GD27288@pengutronix.de>
References: <1245155890204-git-send-email-andreas.fenkart@streamunlimited.com>
	<20090619094640.GD22234@n2100.arm.linux.org.uk>
	<20091001104715.GA25067@CCCP>
	<20091001130338.GB26910@n2100.arm.linux.org.uk>
	<20091001183248.GD27288@pengutronix.de>
Message-ID: <20091001183950.GB30326@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 01, 2009 at 08:32:48PM +0200, Uwe Kleine-K?nig wrote:
> Hello,
> 
> On Thu, Oct 01, 2009 at 02:03:38PM +0100, Russell King - ARM Linux wrote:
> > On Thu, Oct 01, 2009 at 12:47:15PM +0200, Andreas Fenkart wrote:
> > > Davinci defines VMALLOC_END this way:
> > > 
> > > #define VMALLOC_END   (IO_VIRT - (2<<20))   
> > > 
> > > The simple solution would be to prefix the VMALLOC_END with UL,
> > > the alternative to make IO_VIRT unsinged long.
> > 
> > Is:
> > 
> > 	(IO_VIRT - (2<<20))UL
> > 
> > valid C?  I don't think it is, and neither does my compiler.
> No, but
> 
> 	 UL(IO_VIRT - (2<<20))
> 
> might work?!  Havn't tried though.

'UL()' is our own macro which appends UL if building in C mode, otherwise
omits it if assembly:

arch/arm/include/asm/memory.h:#define UL(x) _AC(x, UL)

include/linux/const.h:
#ifdef __ASSEMBLY__
#define _AC(X,Y)        X
#define _AT(T,X)        X
#else
#define __AC(X,Y)       (X##Y)
#define _AC(X,Y)        __AC(X,Y)
#define _AT(T,X)        ((T)(X))
#endif
