From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Oct 2016 20:53:59 +0100
Subject: [PATCH v2] arm: Added support for getcpu() vDSO using TPIDRURW
In-Reply-To: <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
References: <1475589000-29315-1-git-send-email-fredrik.markstrom@gmail.com>
 <1475595363-4272-1-git-send-email-fredrik.markstrom@gmail.com>
 <20161004170741.GC29008@leverpostej>
 <CAKdL+dS4_My6hyMEGNc65mzDapia_tMiVzZ9DMw=ddZM+XiwAw@mail.gmail.com>
 <CAKdL+dTGDqgpnMTkAj=N4cY-cZF_U+bkH1v1vUA4umZoSbWHKQ@mail.gmail.com>
 <50e025e0-7052-9b15-3b3e-36d1d9dfd695@arm.com>
Message-ID: <20161005195359.GR1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 05, 2016 at 06:48:05PM +0100, Robin Murphy wrote:
> On 05/10/16 17:39, Fredrik Markstr?m wrote:
> > The approach I suggested below with the vDSO data page will obviously
> > not work on smp, so suggestions are welcome.
> 
> Well, given that it's user-writeable, is there any reason an application
> which cares couldn't simply run some per-cpu threads to call getcpu()
> once and cache the result in TPIDRURW themselves? That would appear to
> both raise no compatibility issues and work with existing kernels.

There is - the contents of TPIDRURW is thread specific, and it moves
with the thread between CPU cores.  So, if a thread was running on CPU0
when it cached the getcpu() value in TPIDRURW, and then migrated to CPU1,
TPIDRURW would still contain 0.

I'm also not in favour of changing the TPIDRURW usage to be a storage
repository for the CPU number - it's far too specific a usage and seems
like a waste of hardware resources to solve one problem.  As Mark says,
it's an ABI breaking change too, even if it is under a config option.

Take a moment to consider distro kernels: how should they set this
config option - should they enable it to get faster getcpu() or should
they disable it to retain existing compatibility to prevent userspace
breakage.  Who can advise them to make the right decision?  Kernel
developers can't, because the usage of this register is purely a
userspace issue right now, and kernels devs don't know what use it's
been put to.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
