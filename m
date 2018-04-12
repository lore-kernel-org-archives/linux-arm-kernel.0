From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Apr 2018 10:58:11 +0100
Subject: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
In-Reply-To: <20180412013435.GA21219@altlinux.org>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
Message-ID: <20180412095811.GC16141@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 12, 2018 at 04:34:35AM +0300, Dmitry V. Levin wrote:
> A similar commit v4.16-rc1~159^2~37
> ("signal/arm: Document conflicts with SI_USER and SIGFPE") must have
> introduced a similar ABI regression to compat arm.

So, could you explain how can this change cause a regression?

+#define FPE_FIXME      0
-               vfp_raise_sigfpe(0, regs);
+               vfp_raise_sigfpe(FPE_FIXME, regs);

I think you're talking garbage here - look at the damned change.
It subsitutes a definition for a constant, and vfp_raise_sigfpe()
ends up receiving exactly the same value bother before and after
the change.

The change is rather incomplete though because it should have
also changed:

        int si_code = 0;

as well.

So, the commit log is accurate in this case: it _is_ about
documenting the conflicting cases between SI_USER and SIGFPE and
that bit of the change has no ABI effect.

What does slightly annoy me is the creation of uapi/asm/siginfo.h
to contain a definition that _isn't_ to be exposed as part of the
UAPI.  If it's not part of the UAPI, it doesn't belong in a UAPI
header, period.  In any case, I don't think that is exposed to
userspace.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
