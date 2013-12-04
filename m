From: computersforpeace@gmail.com (Brian Norris)
Date: Wed, 4 Dec 2013 10:44:05 -0800
Subject: [PATCH 0/4] mtd: spi-nor: add a new framework for SPI NOR
In-Reply-To: <1386082273.18201.61.camel@shinybook.infradead.org>
References: <1385447575-23773-1-git-send-email-b32955@freescale.com>
 <20131127043253.GA9468@ld-irv-0074.broadcom.com>
 <5298AA23.7080404@st.com>
 <1386082273.18201.61.camel@shinybook.infradead.org>
Message-ID: <20131204184405.GE9468@ld-irv-0074.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 03, 2013 at 02:51:13PM +0000, David Woodhouse wrote:
> On Fri, 2013-11-29 at 14:52 +0000, Angus Clark wrote:
> > 
> > As I see it, the main problem with the current support is that dedicated Serial
> > Flash Controllers require a level of semantics that cannot be conveyed over the
> > generic SPI framework.  With this in mind, I would start by defining something
> > along the lines of a "Serial Flash transfer".  
> 
> I think this is the best way to describe the issue, and approach the
> solution.
> 
> We should be looking to extend the generic SPI framework to support what
> we need, rather than hacking around it purely on the MTD side.
> 
> As such, I'd be very interested in Mark's thoughts on it...

Hmm, I thought we already had (some form of) this explanation
weeks/months ago, yet the conclusion was that Mark doesn't want this in
the SPI framework at all, since a dedicated Serial Flash Controller is
not truly SPI. But perhaps I'm wrong.

On this topic, I have one more stick to throw on this fire; I have some
Broadcom hardware that consists of two pieces:

  (1) a true SPI controller, with single-line-I/O and
  (2) a Serial Flash controller that can accelerate flash read, using
      dual/quad I/O.

The latter hardware cannot handle flash writes, only uses quad I/O for
data (not addresses), has some other peculiarities specific to SPI
flash, and is highly dependent on the former for providing complete SPI
flash support. My current driver is not really upstream-ready, since
(like Huang's original driver), it pretends to be a SPI driver yet
requires "incestuous knowledge" of m25p80 / MTD. But I hope that any new
framework can support hardware like mine.

I don't have public documentation for this hardware, but I can provide
more detail if desired.

I mostly bring this up, though, because it is an example of hardware
that

   (a) can operate as a true SPI device (hardware (1) can handle generic
       SPI transfers), but
   (b) requires knowledge of the details of SPI flash in order to get
       optimal usage out of the acceleration from (2).

In my book, point (a) and (b) hold some bearing over the question of
"where should this SPI NOR framework live", because it is reasonable
that a single driver for this hardware should be able to handle either
true SPI devices or accelerated SPI-NOR flash.

Sorry for my late-ish addition to this discussion. There's been a lot of
noise on this topic, and SPI flash is not the highest priority on my
list for now (although it's certainly on the list).

Brian
