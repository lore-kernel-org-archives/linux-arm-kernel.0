From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 10 Oct 2014 17:25:31 +0100
Subject: RCU bug with v3.17-rc3 ?
In-Reply-To: <20141010135743.GB31348@saruman>
References: <20140905213216.GD5001@linux.vnet.ibm.com>
 <20141008171322.GH22688@saruman> <20141008175707.GI22688@saruman>
 <20141008212938.GP22688@saruman> <20141009160138.GA2396@cmpxchg.org>
 <20141009162656.GE16002@saruman> <20141009204101.GA25955@debian>
 <20141009204637.GE25729@saruman> <20141009210715.GH25729@saruman>
 <20141010135743.GB31348@saruman>
Message-ID: <20141010162531.GL12379@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 10, 2014 at 08:57:43AM -0500, Felipe Balbi wrote:
> On Thu, Oct 09, 2014 at 04:07:15PM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Oct 09, 2014 at 03:46:37PM -0500, Felipe Balbi wrote:
> > > On Thu, Oct 09, 2014 at 10:41:01PM +0200, Rabin Vincent wrote:
> > > > On Thu, Oct 09, 2014 at 11:26:56AM -0500, Felipe Balbi wrote:
> > > > > alright, it's pretty deterministic however. Always on the same test, no
> > > > > matter which USB controller, no matter if backing store is RAM or MMC.
> > > > > 
> > > > > Those two undefined instructions on the disassembly caught my attention,
> > > > > perhaps I'm facing a GCC bug ?
> > > > 
> > > > The undefined instructions are just ARM's BUG() implementation.
> > > > 
> > > > But did you see the question I asked you yesterday in your other thread?
> > > > http://www.spinics.net/lists/arm-kernel/msg368634.html
> > > 
> > > hmm, completely missed that, sorry. I'm using 4.8.2, will try something
> > > else.
> > 
> > seems to be working fine now, thanks. I'll leave test running overnight
> > just in case.
> 
> yup, ran over night without any problems.

Right, so GCC 4.8.{1,2} are totally unsuitable for kernel building (and
it seems that this has been known about for some time.)

We can blacklist these GCC versions quite easily.  We already have GCC
3.3 blacklisted, and it's trivial to add others.  I would want to include
some proper details about the bug, just like the other existing entries
we already have in asm-offsets.c, where we name the functions that the
compiler is known to break where appropriate.

However, I'm rather annoyed that there are people here who have known
for some time that GCC 4.8.1 and GCC 4.8.2 _can_ lead to filesystem
corruption, and have sat on their backsides doing nothing about getting
it blacklisted for something like a year.

When people talk about the ARM community being dysfunctional... well,
this kind of irresponsible behaviour just gives them more fodder to
throw at us.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
