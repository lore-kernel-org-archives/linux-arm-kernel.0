From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 22 Jul 2014 17:13:31 +0100
Subject: [PATCH 2/3] ARM: smp_scu: enable SCU standby support
In-Reply-To: <20140722020911.GO8537@dragon>
References: <1405928755-19413-1-git-send-email-shawn.guo@freescale.com>
 <1405928755-19413-3-git-send-email-shawn.guo@freescale.com>
 <20140721085150.GB15666@arm.com> <20140721092703.GL8537@dragon>
 <20140721102638.GE32578@arm.com> <20140722020911.GO8537@dragon>
Message-ID: <20140722161331.GN2219@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 22, 2014 at 03:09:12AM +0100, Shawn Guo wrote:
> On Mon, Jul 21, 2014 at 11:26:38AM +0100, Catalin Marinas wrote:
> > The usual question - could the firmware enable this bit before Linux
> > starts?
> 
> It could, I guess.  Actually, on i.MX we're setting this bit in platform
> code right now.  But I think setting this bit makes sense for most of
> the platforms, so it can reasonably be done in SCU core function.  Isn't
> it the point of having core/common function after all?

Only that it wouldn't be consistent. If a platform (like some OMAPs)
boots in non-secure mode, the SCU would be already enabled the firmware
and your patch would not have any effect (that's one reason on arm64 I
try to get some consistency between various platforms and not rely on
the kernel which may or may not be able to enable certain features; but
it's late to enforced this on arm32).

> > We already do a read/modify/write sequence here and are only
> > supposed to write the enable bit as the rest are implementation defined.
> 
> Isn't standby bit implemented by all A9 SCU except a couple of very
> early revisions (per Will)?

And we don't know the behaviour of setting this bit on such A9 early
revisions. So we can try to (1) find out if there are any in the field,
(2) read the RTL to see if anything happens or (3) add a check in Linux
for such revisions. I think (3) should be the case but you need to figure
out which revisions these are.

-- 
Catalin
