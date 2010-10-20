From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 20 Oct 2010 10:57:20 +0200
Subject: net{space,xbig} TCLK determination
In-Reply-To: <20101020084826.GK29120@kw.sim.vm.gnt>
References: <20101020050820.GD12979@mail.wantstofly.org>
	<20101020084826.GK29120@kw.sim.vm.gnt>
Message-ID: <20101020085720.GA12979@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 20, 2010 at 08:48:26AM +0000, Simon Guinot wrote:

> Hi Lennert,

Hi Simon,


> > The net{space,xbig} board support files have this:
> > 
> > 	static void netspace_v2_timer_init(void)
> > 	{
> > 		kirkwood_tclk = 166666667;
> > 		orion_time_init(IRQ_KIRKWOOD_BRIDGE, kirkwood_tclk);
> > 	}
> > 
> > This is a pretty ugly hack -- if kirkwood_find_tclk() is not
> > determining the right TCLK on these boards, then that would be the
> > real bug, and it should be fixed there, and not by putting hacks
> > like these in board support files.
> 
> In the Marvell LSP, TCLK detection is based on the Sample at Reset
> Register bit 21. There is no description about this bit usage in the
> Kirkwood functional specification document.
> The given result _seems_ to be correct for the boards on my desk, but
> I have no idea how this way is reliable...
> 
> I simply don't have the needed platform knowledge to solve this issue.
> So, if you want me to fix kirkwood_find_tclk(), you will have to give
> more hints.

This came up when the upstream kirkwood port was initially done, and
the reliable method of detecting TCLK is based on a register that is
internal use only, so what kirkwood_find_tclk() currently does is an
approximation of that using other registers that _are_ public.

If the LSP uses the SaR register, then I don't see why the upstream
kernel shouldn't be doing that as well.  The mv78xx0 port in the
upstream kernel uses that method too (see mach-mv78xx0/common.c,
get_*clk() functions).


> The lacie_v2_timer_init() function is maybe a ugly hack but that is
> the only I found. My concern was to avoid breaking TCLK detection for
> other boards.

Makes sense.


thanks,
Lennert
