From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Feb 2017 15:49:13 +0000
Subject: [PATCHv3] arm: ftrace: Adds support for
 CONFIG_DYNAMIC_FTRACE_WITH_REGS
In-Reply-To: <CACh+v5Nrva=dyJzteomPCzaz01pBBuChesR-9Ft=jeAf0zZoxA@mail.gmail.com>
References: <1486508275-18449-1-git-send-email-abelvesa@linux.com>
 <CACh+v5Nrva=dyJzteomPCzaz01pBBuChesR-9Ft=jeAf0zZoxA@mail.gmail.com>
Message-ID: <20170209154913.GG27312@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 09, 2017 at 04:38:32PM +0100, Jean-Jacques Hiblot wrote:
> 2017-02-07 23:57 GMT+01:00 Abel Vesa <abelvesa@linux.com>:
> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +.macro __ftrace_graph_regs_caller
> > +
> > +       sub     r0, fp, #4              @ lr of instrumented routine (parent)
> > +
> > +       @ called from __ftrace_regs_caller
> > +       ldr     r1, [sp, #56]           @ instrumented routine (func)
> > +       mcount_adjust_addr      r1, r1
> > +
> > +       sub     r2, r0, #4              @ frame pointer
> why not mov r2, fp  ?

	r0 = fp - 4
	r2 = r0 - 4

therefore

	r2 = (fp - 4) - 4
	r2 = fp - 8, not r2 = fp

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
