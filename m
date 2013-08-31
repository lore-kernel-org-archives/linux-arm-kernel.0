From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Sat, 31 Aug 2013 13:19:19 -0300
Subject: [PATCH v3 2/2] ARM: kirkwood: Add standby support
In-Reply-To: <20130831155125.GY19598@titan.lakedaemon.net>
References: <1377186547-14284-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1377186547-14284-3-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130830231003.GA2398@localhost>
 <20130831155125.GY19598@titan.lakedaemon.net>
Message-ID: <20130831161918.GA2404@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 31, 2013 at 11:51:25AM -0400, Jason Cooper wrote:
> On Fri, Aug 30, 2013 at 08:10:04PM -0300, Ezequiel Garcia wrote:
> > On Thu, Aug 22, 2013 at 12:49:07PM -0300, Ezequiel Garcia wrote:
> > > Implements standby support for Kirkwood SoC. When the SoC enters
> > > standby state the memory PM units are disabled, the DDR is set
> > > in self-refresh mode, and the CPU is set in WFI.
> > > 
> > > At this point there's no clock gating, as that is considered each
> > > driver's task.
> > > 
> > > Signed-off-by: Simon Guinot <sguinot@lacie.com>
> > > Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> > > ---
> > >  arch/arm/mach-kirkwood/Makefile                   |  2 +
> > >  arch/arm/mach-kirkwood/board-dt.c                 |  1 +
> > >  arch/arm/mach-kirkwood/common.c                   |  1 +
> > >  arch/arm/mach-kirkwood/common.h                   |  6 ++
> > >  arch/arm/mach-kirkwood/include/mach/bridge-regs.h |  2 +
> > >  arch/arm/mach-kirkwood/pm.c                       | 73 +++++++++++++++++++++++
> > >  6 files changed, 85 insertions(+)
> > >  create mode 100644 arch/arm/mach-kirkwood/pm.c
> > 
> > Any comments on this?
> 
> Well, I was sitting on this for the next merge window,

Of course, this isn't intended for this merge window.
We need first the feroceon suspend/resume patch that is already
queued for v3.12.

So, first of all: sorry if I'm making noise; just wanted
to check nobody had any major comments.
 
> since it came in late and honestly, isn't complete.  You stated yourself in the
> coverletter that it offered no real power savings.
> 

Discussing about this with Simon Guinot on IRC (the original author of
this) we agreed the patch was a nice thing to have, and that follow-up
patches might add better power savings on a per-device basis.

Maybe it's foolish, but notice this doesn't provide additional power saving
in comparison with a cpuidled-kernel (I know, most of users will select
it).

> How about expanding the series to add proper suspend/resume support to
> some of the more power hungry drivers

So -just to check- you definitely prefer not to take the stand-by
support until we have some more suspend/resume support in other drivers?

If the stand-by is ready and it's working, I'd say we're ready to
include it, disregarding the drivers, but it's completely your call.

> (yes, this might re-awaken the
> mv643xx_eth mac address issue), and resubmit?
> 

I'm not entirely familiar with the eth mac issue, but currently we're
enabling the eth clock in mach-kirkwood, so those clocks are
*impossible* to disable from the driver (due to refcounting-like clock
disable). Not sure what's the right thing to do.

Thanks!
-- 
Ezequiel Garc?a, Free Electrons
Embedded Linux, Kernel and Android Engineering
http://free-electrons.com
