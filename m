From: computersforpeace@gmail.com (Brian Norris)
Date: Fri, 6 Feb 2015 11:38:59 -0800
Subject: [PATCH v2 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <54D4CCEB.5090009@free-electrons.com>
References: <1422284164-16867-1-git-send-email-maxime.ripard@free-electrons.com>
 <1422284164-16867-2-git-send-email-maxime.ripard@free-electrons.com>
 <20150204111028.2f0bd376@bbrezillon>
 <20150206010835.GB30781@ld-irv-0074>
 <20150206091307.1162b123@bbrezillon>
 <54D4CCEB.5090009@free-electrons.com>
Message-ID: <20150206193859.GP18140@ld-irv-0074>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 06, 2015 at 11:17:15AM -0300, Ezequiel Garcia wrote:
> On 02/06/2015 05:13 AM, Boris Brezillon wrote:
> > On Thu, 5 Feb 2015 17:08:35 -0800
> > Brian Norris <computersforpeace@gmail.com> wrote:
> >> On Wed, Feb 04, 2015 at 11:10:28AM +0100, Boris Brezillon wrote:
> >>> I know the datasheet says this bit should be checked after each
> >>> transfer, but I wonder if we shouldn't check it before reading the data.
> >>> What happens if you drain all the data available in the FIFO ? Is the
> >>> controller still setting the RDDREQ bit ?
> >>>
> >>> Moreover, the datasheet says this RDDREQ bit should be checked after
> >>> each 32 bytes (not 32 bits) transfer.
> >>> Testing it after each readl call shouldn't hurt though.
> >>
> >> Seems like that could quite possibly kill performance unnecessarily,
> >> couldn't it? But then, PIO is probably not that fast in the first
> >> place...
> > 
> > Absolutety, my point was, it shouldn't hurt from a functional POV, but
> > yes it will definitely impact performances.
> > But that's not the first thing I would rework of if you're concerned
> > about performances: when doing PIO read/write, the page read/write
> > operations (I mean the part reading the internal fifo) are all done in
> > interrupt context (called from pxa3xx_nand_irq), and doing this will
> > prevent any other interrupt from taking place while you are
> > draining/filling the FIFO :-(.
> 
> But NAND operations are serialized, and there won't be any other
> interrupt for the controller until it's has drained the FIFO. So this
> doesn't really seem to hit performance to me.
> 
> Or am I missing anything here?

I think we're talking about two things:

1. The $subject patch is probably adding too many extra register reads
   (8 times too many?). In the grand scheme of things, this probably
   isn't significant.

2. The driver as already written is doing too much in its interrupt
   handler; this is bad practice in general and can hurt the
   responsiveness of the system. And particularly here, we also have the
   problem of a potential lockup, since the new timeout loop is waiting
   on jiffies, which will not be updated.

> > An alternative would be to move this part into the read/write_buf
> > functions, but that's a lot of work...
> > 
> 
> Yeah, indeed. This also has other benefits. As we discussed on IRC, it
> would allow to support raw writes (i.e. ECC off).

OK. This is probably a good work item for later. But let's get back on
point.

I'd like to see version 2 with the following:

1. For sure the jiffies loop needs to be rewritten

2. Optionally, the RDDREQ bit should be checked less often, per the
   datasheet and Boris's comments

Maxime, would that be OK?

Then maybe I can get this into 3.20. Maybe not in my primary -rc1
pullreq, if we haven't had enough time to look at and test v2, but ASAP.
Only after than am I likely to take Rob's ARM64 cleanup.

Brian
