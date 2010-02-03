From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 3 Feb 2010 21:34:59 +0000
Subject: [PATCH 12/13] ARM: LPC32XX: architecture header files
In-Reply-To: <083DF309106F364B939360100EC290F805C8B787A9@eu1rdcrdc1wx030.exi.nxp.com>
References: <1264643011-17390-1-git-send-email-wellsk40@gmail.com>
	<1264643011-17390-13-git-send-email-wellsk40@gmail.com>
	<20100203170737.GN11354@pengutronix.de>
	<083DF309106F364B939360100EC290F805C8B787A9@eu1rdcrdc1wx030.exi.nxp.com>
Message-ID: <20100203213459.GB29306@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2010 at 08:20:01PM +0100, Kevin Wells wrote:
> > 
> > > +#define VMALLOC_END	(PAGE_OFFSET + 0x10000000)
> > grepping shows that defining VMALLOC_END based on PAGE_OFFSET is usual,
> > but I wonder why you don't just
> 
> The maximum addressable DRAM sizing is 256MB when fully populated. It seemed
> the right size. 0xF0000000 works too though, I have no problems changing it.

Well, what you have is:

VMALLOC_END
	...
VMALLOC_START
	8MB hole
high_memory
	Direct mapped RAM
PAGE_OFFSET

So, if your maximal DRAM size is 256MB, then if you install that amount
(ignoring things like highmem support, which you should have disabled)
high_memory = PAGE_OFFSET + 256MB, or PAGE_OFFSET + 0x10000000.

That makes VMALLOC_START = PAGE_OFFSET + 0x10800000, which will be
above VMALLOC_END !

What actually happens is that the kernel (by default) enforces a 128MB
VMALLOC area, which, given your VMALLOC_END value will give you a
maximum of 120MB of SDRAM - if you check your boot log, you probably
have some message like:

"Truncating RAM at ..."
