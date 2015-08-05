From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 5 Aug 2015 12:27:13 +0100
Subject: arm kernel oops in highmem.c with 4.2
In-Reply-To: <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
References: <CALeDE9Ox3=sh3AXQ0NUG6BBfU5i5YrMY=LDpcTHQWqz2=60F2g@mail.gmail.com>
 <20150805100701.GV7557@n2100.arm.linux.org.uk>
 <CALeDE9PXF=gQCaBCiHpHy2nXOooQOmsCQvSgOv+wQw3mta=P6A@mail.gmail.com>
Message-ID: <20150805112713.GY7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 05, 2015 at 11:13:07AM +0100, Peter Robinson wrote:
> On Wed, Aug 5, 2015 at 11:07 AM, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Aug 05, 2015 at 11:01:01AM +0100, Peter Robinson wrote:
> >> Hi All,
> >>
> >> On Fedora 23 with recent 4.2 kernels we're seeing a crash (below) in
> >> highmem.c on a fairly regular occurrence across a number of different
> >> SoCs, I've seen it with at least AllWinner A20, i.MX6Q, Tegra2 and 124
> >> with both a LPAE and non LPAE kernel, seen it happen when doing a
> >> number of different things but regenerating a initrd, applying updates
> >> (dnf/yum) and starting X are all pretty good triggers.
> >
> > I've yet to see any problems with mainline 4.2-rc5 kernels on any of my
> > iMX6 platforms, which includes initramfs regeneration, apt-get updates
> > and X.
> >
> >> [71751.658105] ------------[ cut here ]------------
> >> [71751.658153] kernel BUG at arch/arm/mm/highmem.c:114!
> >
> > Well, in mainline kernels, the BUG is on line 113, not line 114.  So at
> > least this file is modified from mainline kernels.  Maybe the problem is
> > caused by patches applied to Fedora kernels?
> 
> We apply a crash driver patch [1] which has been there forever (long
> enough that I'd forgotten it) but other than that for arm kernels we
> currently don't apply any arm specific patches in 4.2.

It helps if I look at 4.2 rather than an older kernel :)

However, I've checked that I have DEBUG_HIGHMEM enabled, which I do, and
I'm unable to reproduce this here.  My kernels are built with gcc 4.7.4.

What it looks like from your oops is that the address which was passed
in was 0xffedf000, but the address we calculated via the following for
the current index was 0xfff00000:

type = kmap_atomic_idx();
idx = type + KM_TYPE_NR * smp_processor_id();
__fix_to_virt(idx)

Doing a bit of maths... the address 0xffedf000 corresponds to a fixmap
index of... (0xffeff000 - 0xffedf000) >> 12 = 32.  KM_TYPE_NR is 16 on
ARM, so the mapping was created by CPU 2, and type was zero.

On unmap, 0xfff00000 gives... (0xffeff000 - 0xfff00000) >> 12 = -1.
That suggests we're on CPU 0, and type is -1 - in other words, there
are no atomically mapped mappings on CPU 0.

Since kmap_atomic() disables preemption and page faults, how did your
kernel migrate this thread from CPU 2 to CPU 0... and I can't see how
that happened.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
