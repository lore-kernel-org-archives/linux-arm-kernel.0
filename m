From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 27 Jul 2012 11:08:46 +0100
Subject: [PATCH 3/3] cpufreq: Add a generic cpufreq-cpu0 driver
In-Reply-To: <20120727021303.GB3347@b20223-02.ap.freescale.net>
References: <1342713281-31114-1-git-send-email-shawn.guo@linaro.org>
 <1342713281-31114-4-git-send-email-shawn.guo@linaro.org>
 <20120726131121.GB7306@sirena.org.uk>
 <20120727021303.GB3347@b20223-02.ap.freescale.net>
Message-ID: <20120727100845.GA7777@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2012 at 10:13:04AM +0800, Richard Zhao wrote:
> On Thu, Jul 26, 2012 at 02:11:21PM +0100, Mark Brown wrote:
> > On Thu, Jul 19, 2012 at 11:54:41PM +0800, Shawn Guo wrote:

> > > +Optional properties:
> > > +- transition-latency: Specify the possible maximum transition latency,
> > > +  in unit of nanoseconds.

> > This should make it clear that the transition latency being documented
> > here is just that for the core clock change itself, there may be other
> > sources of latency like the regulator ramp time or reprogramming PLLs.

> I think it's the total time and board dts can over-write it if it
> needs. Different transitions between different operating points may
> differ, and regulator may be able to indicate the transition time but
> clk don't have such api, and probably not worth to have.

That's going to be awfully manual if every board has to tweak values
(though obviously the main effect is just going to be bad decisions
rather than breakage).  I've seen several systems where the clock could
provide useful timing input here - the usual pattern is that you've got
a PLL which you can use as well as some dividers.  Transitions that only
need a divider update are extremely quick but transitions that change
the PLL setup can take much longer.  It seems better to just allow the
board maintainer to plug everything together rather than having to work
out their specific latencies to squeeze the performance out of the
system.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120727/673349c5/attachment.sig>
