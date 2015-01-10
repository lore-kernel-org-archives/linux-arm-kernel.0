From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 10 Jan 2015 17:30:01 +0100
Subject: [PATCH 0/6] ARM: mvebu: mvebu-mbus and I/O coherency fixes
In-Reply-To: <20150109165204.3d0d3d99@free-electrons.com>
References: <1419943428-18491-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <20150109165204.3d0d3d99@free-electrons.com>
Message-ID: <20150110163001.GA5392@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 09, 2015 at 04:52:04PM +0100, Thomas Petazzoni wrote:
> Hello Andrew,
> 
> On Tue, 30 Dec 2014 13:43:41 +0100, Thomas Petazzoni wrote:
> 
> > Michal Mazur (1):
> >   bus: mvebu-mbus: fix support of MBus window 13 on Armada XP/375/38x
> > 
> > Thomas Petazzoni (5):
> >   dt: bindings: update mvebu-mbus DT binding with new compatible
> >     properties
> >   ARM: mvebu: fix compatible strings of MBus on Armada 375 and Armada
> >     38x
> >   bus: mvebu-mbus: make sure SDRAM CS for DMA don't overlap the MBus
> >     bridge window
> >   bus: mvebu-mbus: use automatic I/O synchronization barriers
> >   ARM: mvebu: use arm_coherent_dma_ops
> 
> Would it be possible to get those patches applied?

Hi Thomas

I added in Arnd, Olof and Jason and would like there comments and
thoughts.

As you have seen, i've taken the "easy" ones, the ones for the next
merge window.

I'm a bit undecided about the others. There are two issues:

Fixing window 13 is a big fix. It is getting late in the -rc cycle,
which is partially my responsibility, since i was waiting for some
tested-by:'s. But these patches are also heading towards
stable. Stable rules state:

 - It must be obviously correct and tested.
 - It cannot be bigger than 100 lines, with context.
 - It must fix only one thing.
 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).
 - It must fix a problem that causes a build error (but not for things
   marked CONFIG_BROKEN), an oops, a hang, data corruption, a real
   security issue, or some "oh, that's not good" issue.  In short, something
   critical.

The first patch is over 300 lines. Because of its size, i'm also not
able to say it is obviously correct. It does however tick some of the
other boxes, fix only one thing, fixes a real problem.

Is there a more minimal fix? How big an impact is there in just
disabling window 13? How much pressure do we have on windows? Can
Michal Mazur live with one less window?

We could then pushing this proper fix into the next merge window?

For the IO Coherency fixes, obviousness is an issue. This is
especially true since your own comment is "still not working 100%
properly, but it is apparently not worse than it was."

Maybe the correct fix for stable is to simply disable the I/O
coherency hardware. That at least makes mainline stable.  Once we have
a real, well tested, 100% fix, take it via the normal merge window.

Lets discuss this,

     Andrew
