From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 20 Feb 2014 13:18:21 +0100
Subject: [PATCH 21/21] ARM: Kirkwood: Remove DT support
In-Reply-To: <1392896076.23342.37.camel@kazak.uk.xensource.com>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-22-git-send-email-andrew@lunn.ch>
 <52F51922.6030502@gmail.com>
 <1392892217.23342.18.camel@kazak.uk.xensource.com>
 <20140220105854.GL11878@lunn.ch>
 <1392896076.23342.37.camel@kazak.uk.xensource.com>
Message-ID: <20140220121821.GO11878@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 20, 2014 at 11:34:36AM +0000, Ian Campbell wrote:
> (adding debian-arm/-kernel)
> On Thu, 2014-02-20 at 11:58 +0100, Andrew Lunn wrote:
> > On Thu, Feb 20, 2014 at 10:30:17AM +0000, Ian Campbell wrote:
> > > On Fri, 2014-02-07 at 18:34 +0100, Sebastian Hesselbarth wrote:
> > > > On 02/07/2014 12:42 AM, Andrew Lunn wrote:
> > > > > Now that all the device tree support is in mach-mvebu, remove it from
> > > > > mach-kirkwood.
> > > > >
> > > > > Regenerate kirkwood_defconfig, removing all DT support, and a couple
> > > 
> > > s/DT/board-file/?
> > 
> > We keep any system using -setup.c files, and remove the ability to
> > boot systems with a DT description. Thus mach-kirkwood becomes legacy,
> > and you should now be trying to only use mach-mvebu, compiled for v5
> > systems and a second compile for v7 systems.
> 
> Just to check I've got it: The majority of the systems previously
> supported by mach-kirkwood (either board file or DTB based) are now
> supported by mach-mvebu.

We plan to move all kirkwood systems which are DT to mach-mvebu. Any
systems which are not DT will get left in mach-kirkwood.

What would be interesting to know is, if any of the systems left
behind are supported by debian. So LaCie 2Big and 5Big, HP t5325 thin
client and Marvell OpenRD machines? If you don't support any of these,
you can drop mach-kirkwood.

> Is it possible to have both ARCH_KIRKWOOD and ARCH_MVEBU in the same
> v5 .config?

Armada XP, 370, and the new SoCs going in this cycle all use ARM v7
CPUs. Dove also uses an ARM v7 cpu and we intent to move it from
mach-dove into mach-mvebu.

Now ARM v7 cpu and ARM v5 CPUs are mutually incompatible. You cannot
combine them into one kernel. Do you currently build mach-mvebu as
part of a multi v7 kernel. That is, you have one kernel which boots on
all v7 machines?

What this patchset does is also make mach-mvebu part of the multi v5
kernel. So you just need one kernel for all ARM v5 machines which are
part of multi v5. The long term goal is that you need just two 32 ARM
kernels, multi v5 and multi v7. However orion5x and mv76xx0 are not
yet part of theses, so we are not there yet.

> IOW that all of the platforms currently supported by the
> Debian kirkwood flavour remain supportable in the same binary after this
> change. It looks like it should be to me, but I'm not 100% sure.

If you don't support LaCie 2Big and 5Big, HP t5325 thin client and
Marvell OpenRD then yes, you have one binary. That binary could
potentially support over v5 machines, but i have no idea what ARM
machines Debian actually supports. Is there a list somewhere?
 
> Is there a tree I can pull to see what is going into v3.15 in this
> area?

At the moment there is not a tree with all the different parts.  I
have a tree with these specific patches. There are other trees which
contain new DT descriptions for new devices, like Bubba B3, and
systems which have been converted to DT, like the QNAP T4xx.

> > My aim is 3.15. Most patches have been Acked now, so i think we are on
> > track for that.
> 
> If kirkwood and mvebu are mutually exclusive on v5 then this sounds like
> it might end up being more complicated than just setting Append-DTB-From
> in the flash-kernel db. In that case if we could hold off on pulling the
> existing kirkwood support until there is a transition plan here I'd be
> very grateful.

Lets make sure we are all on the same page with v5, v7, kirkwood,
mvebu, multi, and what kernels Debian currently builds and how
flash-kernel works etc. We can then discuss transition plans.

     Andrew
