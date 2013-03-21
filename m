From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Thu, 21 Mar 2013 06:42:22 -0300
Subject: [PATCH 00/16] Marvell EBU thermal sensor consolidation
In-Reply-To: <20130321064501.GK21478@lunn.ch>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130321064501.GK21478@lunn.ch>
Message-ID: <20130321094221.GA2469@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew,

On Thu, Mar 21, 2013 at 07:45:01AM +0100, Andrew Lunn wrote:
> On Wed, Mar 20, 2013 at 07:36:21PM -0300, Ezequiel Garcia wrote:
> > This patchset is my first attempt at adding basic thermal sensor
> > support on Armada 370 and Armada XP.
> > 
> > Given Armada 370/XP and the other Marvell SoC with thermal support,
> > namely Kirkwood and Dove, have fairly similar thermal devices it 
> > made sense to integrate all of them into a single driver: mvebu-thermal.
> 
> 
> I went this way to start with, merging Dove, Kirkwood and something
> which nearly worked for 370. But then i looked at the code, at how
> little is actually shared, and went back to separate drivers.
> 
> Kirkwood has no control registers, so needs a special case in the probe.
> The bit location of the temperate value moves around in the register.
> Each SoC needs its own initialization sequence.
> Each SoC needs its own is_valid() function.
> Each Soc needs its own formula to convert to milli centigrad.
> 
> I've never seen the datasheets for 370/XP, just a list of registers for
> 370. But i get the impression it has two temperate sensors, so should
> export two values?
> 
> Also, kirkwood will never be built into the same kernel as
> Dove/370/XP.  So we end up with "bloat" in the driver, or at least a
> collection of #ifdefs.
> 
> In the end, i decided it was simpler and cleaner to just have separate
> drivers. This is something which we should think about and discuss.
> 

Thanks for your comments.

I had the same concerns about a single driver against many;
after trying this approach I was convinced by the diffstat:

13 files changed, 395 insertions(+), 393 deletions(-)

So we have almost no LoC increase and two new SoCs are supported.

The alternative would mean to have one driver for Armada 370
and yet another one for Armada XP, with some common boilerplate
in each driver and only the differences you mention: a different
initialization and a different conversion formula.
The initialization is solved my means of a function pointer,
and the conversion is just a switch.

FWIW, the is_valid() is actually the same on Kirkwood and 370.

I debated myself a lot before unifying the drivers: in the end
it seemed a proper solution: less maintainance, less configuration
options, happier hackers :)

What do you think?
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
