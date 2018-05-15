From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 15 May 2018 09:22:23 +0100
Subject: [PATCH 08/18] arm64: convert raw syscall invocation to C
In-Reply-To: <20180514202445.GA26773@light.dominikbrodowski.net>
References: <20180514125351.GK7753@e103592.cambridge.arm.com>
 <20180514114104.oubxdf526hf2m6t5@lakrids.cambridge.arm.com>
 <20180514202445.GA26773@light.dominikbrodowski.net>
Message-ID: <20180515082222.rcoyf6dsf2s2edgq@salmiak>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 10:24:45PM +0200, Dominik Brodowski wrote:
> On Mon, May 14, 2018 at 12:41:10PM +0100, Mark Rutland wrote:
> > I agree it would be nicer if it had a wrapper that took a pt_regs, even
> > if it does nothing with it.
> > 
> > We can't use SYSCALL_DEFINE0() due to the fault injection muck, we'd
> > need a ksys_ni_syscall() for our traps.c logic, and adding this
> > uniformly would involve some arch-specific rework for x86, too, so I
> > decided it was not worth the effort.
> 
> Couldn't you just open-code the "return -ENOSYS;" in traps.c?

I guess so. I was just worried that debug logic might be added to the generic
ni_syscall() in future, and wanted to avoid potential divergence.

> Error injection has no reasonable stable ABI/API expectations, so that's not
> a show-stopper either.

If people are happy with using SYSCALL_DEFINE0() for ni_syscall, I'm happy to
do that -- it's just that we'll need a fixup for x86 as that will change the
symbol name.

Thanks,
Mark.
