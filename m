From: okuno.kohji@jp.panasonic.com (okuno.kohji at jp.panasonic.com)
Date: Tue, 9 Jan 2018 14:46:30 +0000
Subject: arm: Is VFP hotplug notifiers wrong?
In-Reply-To: <alpine.DEB.2.20.1801091457210.1766@nanos>
References: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
 <20180109114048.GF17719@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1801091457210.1766@nanos>
Message-ID: <104db10119fd453ba38edac32a228ab6@JPA000SECMN21.palet.jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Russel and Thomas,

Thank you for your quick response.
Thomas, do you create the patch?

Best regards,
 Kohji Okuno

> -----Original Message-----
> From: Thomas Gleixner [mailto:tglx at linutronix.de]
> Sent: Tuesday, January 9, 2018 10:58 PM
> To: Russell King - ARM Linux
> Cc: Okuno Kohji (?? ??); linux-arm-kernel at lists.infradead.org
> Subject: Re: arm: Is VFP hotplug notifiers wrong?
> 
> On Tue, 9 Jan 2018, Russell King - ARM Linux wrote:
> 
> > On Tue, Jan 09, 2018 at 08:12:21PM +0900, Kohji Okuno wrote:
> > > Dear Thomas and all,
> > >
> > > Could you please confirm about the following commit, again?
> > >
> > > http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vf
> > > pmodule.c?id=e5b61bafe70477e05e1dce0d6ca4ec181e23cb2a
> > >
> > >
> > > The avobe commit eliminated the following fix, I think.
> > >
> > > http://git.armlinux.org.uk/cgit/linux-arm.git/commit/arch/arm/vfp/vf
> > > pmodule.c?id=384b38b66947b06999b3e39a596d4f2fb94f77e4
> > >
> > >
> > > vfp_force_reload() called from vfp_dying_cpu() does not clear
> > > vfp_current_hw_state[cpu], because cpu stopper task does not own the
> > > context held in the VFP hardware.
> >
> > You are correct, tglx's patch was wrong, since the state in the CPU
> > may not be the current thread's state, so vfp_force_reload() may not
> > do anything.
> >
> > vfp_force_reload() forces the reload of the specified state for the
> > specified CPU.  What the original hotplug code did was to ensure that
> > the CPU's state would be reloaded when it came back up.
> >
> > I do wish that people wouldn't combine functional changes and cleanups
> > into one patch - it makes this kind of thing harder to spot in review
> > and also means when we encounter crap like this, it means we can't
> > simply revert the cleanup.
> 
> sorry about that....
