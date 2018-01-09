From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 9 Jan 2018 11:40:48 +0000
Subject: arm: Is VFP hotplug notifiers wrong?
In-Reply-To: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
References: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
Message-ID: <20180109114048.GF17719@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 09, 2018 at 08:12:21PM +0900, Kohji Okuno wrote:
> Dear Thomas and all,
> 
> Could you please confirm about the following commit, again?
> 
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vfpmodule.c?id=e5b61bafe70477e05e1dce0d6ca4ec181e23cb2a
> 
> 
> The avobe commit eliminated the following fix, I think.
> 
> http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vfpmodule.c?id=384b38b66947b06999b3e39a596d4f2fb94f77e4
> 
> 
> vfp_force_reload() called from vfp_dying_cpu() does not clear
> vfp_current_hw_state[cpu], because cpu stopper task does not own the
> context held in the VFP hardware.

You are correct, tglx's patch was wrong, since the state in the CPU may
not be the current thread's state, so vfp_force_reload() may not do
anything.

vfp_force_reload() forces the reload of the specified state for the
specified CPU.  What the original hotplug code did was to ensure that
the CPU's state would be reloaded when it came back up.

I do wish that people wouldn't combine functional changes and cleanups
into one patch - it makes this kind of thing harder to spot in review
and also means when we encounter crap like this, it means we can't
simply revert the cleanup.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
