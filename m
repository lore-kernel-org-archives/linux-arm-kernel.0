From: will.deacon@arm.com (Will Deacon)
Date: Mon, 10 Oct 2016 16:29:48 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <CAKdL+dSt+cBCpwW5q+VCQh+7XeKrnyJgfTsEsuo2nKoUr9ytxw@mail.gmail.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
 <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
 <20161005195359.GR1041@n2100.armlinux.org.uk>
 <CAKdL+dSt+cBCpwW5q+VCQh+7XeKrnyJgfTsEsuo2nKoUr9ytxw@mail.gmail.com>
Message-ID: <20161010152948.GD14561@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fredrik,

[adding Mathieu -- background is getcpu() in userspace for arm]

On Thu, Oct 06, 2016 at 12:17:07AM +0200, Fredrik Markstr?m wrote:
> On Wed, Oct 5, 2016 at 9:53 PM, Russell King - ARM Linux <linux@armlinux.org.uk
> > wrote:
> > On Wed, Oct 05, 2016 at 06:48:05PM +0100, Robin Murphy wrote:
> >> On 05/10/16 17:39, Fredrik Markstr?m wrote:
> >> > The approach I suggested below with the vDSO data page will obviously
> >> > not work on smp, so suggestions are welcome.
> >>
> >> Well, given that it's user-writeable, is there any reason an application
> >> which cares couldn't simply run some per-cpu threads to call getcpu()
> >> once and cache the result in TPIDRURW themselves? That would appear to
> >> both raise no compatibility issues and work with existing kernels.
> >
> > There is - the contents of TPIDRURW is thread specific, and it moves
> > with the thread between CPU cores.  So, if a thread was running on CPU0
> > when it cached the getcpu() value in TPIDRURW, and then migrated to CPU1,
> > TPIDRURW would still contain 0.
> >
> > I'm also not in favour of changing the TPIDRURW usage to be a storage
> > repository for the CPU number - it's far too specific a usage and seems
> > like a waste of hardware resources to solve one problem. 
> 
> Ok, but right now it's nothing but a (architecture specific) piece of TLS,
> which we have generic mechanisms for. From my point of view that is a waste of
> hardware resources.
> 
> > As Mark says, it's an ABI breaking change too, even if it is under a config
> option.
> 
> I can't argue with that. If it's an ABI it's an ABI, even if I can't imagine
> why anyone would use it over normal tls... but then again, people probably do. 
> 
> So in conclusion I agree and give up.

Rather than give up, you could take a look at the patches from Mathieu
Desnoyers, that tackle this in a very different way. It's also the reason
we've been holding off implementing an optimised getcpu in the arm64 vdso,
because it might all well be replaced by the new restartable sequences
approach:

  http://lkml.kernel.org/r/1471637274-13583-1-git-send-email-mathieu.desnoyers at efficios.com

He's also got support for arch/arm/ in that series, so you could take
them for a spin. The main thing missing at the moment is justification
for the feature using real-world code, as requested by Linus:

  http://lkml.kernel.org/r/CA+55aFz+Q33m1+ju3ANaznBwYCcWo9D9WDr2=p0YLEF4gJF12g at mail.gmail.com

so if your per-cpu buffer use-case is compelling in its own right (as
opposed to a micro-benchmark), then you could chime in over there.

Will
