From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 25 Feb 2010 09:38:59 +0000
Subject: [PATCH] Clean up ARM compressed loader
In-Reply-To: <alpine.LFD.2.00.1002242309030.1946@xanadu.home>
References: <1266978217-7023-1-git-send-email-hector@marcansoft.com>
	<20100224223418.GB25587@n2100.arm.linux.org.uk>
	<alpine.LFD.2.00.1002241824520.1946@xanadu.home>
	<20100224234215.GA21985@n2100.arm.linux.org.uk>
	<4B85BCE0.7000903@marcansoft.com>
	<20100225000114.GB21985@n2100.arm.linux.org.uk>
	<4B85C4A4.4060005@marcansoft.com>
	<alpine.LFD.2.00.1002242309030.1946@xanadu.home>
Message-ID: <20100225093859.GA19870@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 24, 2010 at 11:28:45PM -0500, Nicolas Pitre wrote:
> Obviously.  But that's the core of the argument: we made sure that the 
> previous implementation didn't use any static within functions.  Why do 
> you need to do that?  This is usually a bad idea anyway as this makes 
> the function non reentrant.

Indeed - but having static data within a function doesn't make it non-
reentrant - having static data modified by the function can make it
non-reentrant.

I wonder if we can get around this problem a slightly different way -
instead of building the decompressor into misc.c, build it as a separate
PIC object without the -Dstatic= stuff, and verify that it contains no
read-write data.

Since these decompressors are designed to be used within the multi-threaded
environment of the kernel, they shouldn't have any read-write data within
them (or if they do, they'd better use some locking - which would make
them unusable for decompressors.)

Then we can tailor our misc.c not to use static data (which is the real
problem - not the functions being static), and the -Dstatic= hack will
go away.
