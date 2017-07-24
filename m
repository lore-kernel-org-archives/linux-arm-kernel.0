From: will.deacon@arm.com (Will Deacon)
Date: Mon, 24 Jul 2017 14:12:53 +0100
Subject: [PATCH 00/16] arm/arm64: Workaround misprogrammed CNTFRQ
In-Reply-To: <c3c34b9b-3872-bbb1-28cf-07aa6c739e94@arm.com>
References: <20170721171542.27639-1-marc.zyngier@arm.com>
 <20170724121958.GC29919@arm.com>
 <c3c34b9b-3872-bbb1-28cf-07aa6c739e94@arm.com>
Message-ID: <20170724131252.GG29919@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 24, 2017 at 01:48:37PM +0100, Marc Zyngier wrote:
> On 24/07/17 13:19, Will Deacon wrote:
> > On Fri, Jul 21, 2017 at 06:15:26PM +0100, Marc Zyngier wrote:
> >> It is an unfortunate situation that CNTFRQ{,_EL0} is often
> >> misprogrammed from the firmware side, leaving it up to the kernel to
> >> work around it. This is usually done by providing an alternative
> >> frequency in the Device Tree.
> >>
> >> Unfortunately, CNTFRQ is accessible from EL0, giving userspace the
> >> wrong frequency, and potentially a different frequency per CPU, which
> >> is definitely not what you want. A possible workaround is to trap this
> >> into the kernel and to emulate it (together with the VDSO being
> >> disabled), and this is what this series is achieving.
> > 
> > Which userspace is actually affected by a broken CNTFRQ register? I suspect
> > most users will be more upset at losing their (perfectly functional) vDSO
> > acceleration than they are about having a broken CNTFRQ value that is hardly
> > ever used, especially since this affects quite a few systems.
> 
> OpenMPI is one of the things I'm aware of (we broke it when implementing
> the first set of timer workarounds), and from trawling the Debian code
> search, at least HHVM is another candidate. How this will affect them is
> anybody's guess.

The latest mcrouter sources pulled into HHVM don't use cntfrq, but you're
right about OpenMPI. However, these things are using the counter directly
as a performance optimisation: the moment we start trapping then they've
lost. I doubt it's much better than giving the wrong data for the
frequency (i.e. they're just as broken in both cases).

So, if they want to run on these systems, their best bet is to use the
vDSO-accelerated clock_gettime implementation. Yes, there's a dispatch cost
compared to an inline asm, but it will beat the pants off a trap to the
kernel. The problem is that this patch series prevents them from doing that
and just means they're screwed whatever they do. We can point at the broken
firmware, but it doesn't feel to me like this workaround is really helping
anybody :/.

Will
