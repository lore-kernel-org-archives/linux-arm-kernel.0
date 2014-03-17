From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 17 Mar 2014 17:09:46 -0400 (EDT)
Subject: PL310 errata workarounds
In-Reply-To: <20140317194440.GG21483@n2100.arm.linux.org.uk>
References: <20140314144835.GP21483@n2100.arm.linux.org.uk>
 <20140314150110.GQ21483@n2100.arm.linux.org.uk>
 <CAL_JsqLuNz4EzGaQdb5eFSX5ip-spcDTFsNaFN094=XB_iPV3g@mail.gmail.com>
 <20140316115207.GW21483@n2100.arm.linux.org.uk>
 <CAL_Jsq+9Dm9S6rhQAt_umOM6T_x21O=Y_PPg0QyCH1zR_=yWoA@mail.gmail.com>
 <20140317153738.GB21483@n2100.arm.linux.org.uk>
 <20140317172943.GI24070@arm.com>
 <20140317194440.GG21483@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1403171651440.1291@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 17 Mar 2014, Russell King - ARM Linux wrote:

> On Mon, Mar 17, 2014 at 05:29:44PM +0000, Catalin Marinas wrote:
> > On Mon, Mar 17, 2014 at 03:37:38PM +0000, Russell King - ARM Linux wrote:
> > > On Mon, Mar 17, 2014 at 10:04:20AM -0500, Rob Herring wrote:
> > > > On Sun, Mar 16, 2014 at 6:52 AM, Russell King - ARM Linux
> > > > <linux@arm.linux.org.uk> wrote:
> > > > >    The MCPM stuff is another issue: what the conditions are there I've
> > > > >    no idea, but it looks like other CPUs will be running when it calls
> > > > >    outer_cache_flush().  MCPM commentry claims that this will be
> > > > >    "harmless" and I just had to laugh at that - even with this workaround
> > > > >    enabled, it doesn't fix the problem on L2C-310 R2P0 as the workaround
> > > > >    implementation only works on R3P0!
> > > > 
> > > > For MCPM, is there even a platform that has a PL310 used as an L3? I
> > > > suppose architecturally it is possible, but in reality it is probably
> > > > not something that's ever been tested.
> > > 
> > > I have no idea about MCPM
> > 
> > I assume that the MCPM comment about outer_cache_flush() being harmless
> > is because it is assumed to be a no-op. In the mach-vexpress/dcscb.c
> > file, there is a v7_exit_coherency_flush() prior to outer_flush_all().
> > While it looks like the right way, the comment for
> > v7_exit_coherency_flush() states that ldrex/strex no longer work after
> > the call.

[...]

> My worry about MCPM is that it talks about the function containing the
> outer_flush_all() potentially racing with a different CPU coming online.
> It's not clear to me whether that other CPU would be using the same L2
> controller or not:
>
> /*
>  * We can't use regular spinlocks. In the switcher case, it is possible
>  * for an outbound CPU to call power_down() while its inbound counterpart
>  * is already live using the same logical CPU number which trips lockdep
>  * debugging.
>  */

L2 is normally a per cluster resource.  It is flushed by the last man 
standing when no other CPUs might contend for the L2 controller.  And if 
the outer cache is shared by multiple clusters then some additional 
handling (such as "last cluster standing") would need to be implemented.

Clearly this outer_cache_flush() call is just a hint if someone were to 
copy that file to write their own backend.  If it is causing problems 
then it should just be removed altogether.  No platforms with MCPM that 
I know of have an actual outer cache at the moment.  And certainly not 
the platform where dcscb.c is used.


Nicolas
