From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Wed, 24 May 2017 11:19:48 +0100
Subject: [PATCH v2] arm64: kernel: restrict /dev/mem read() calls to
 linear region
In-Reply-To: <CAKv+Gu8vYP7xB5T_gFPvFQ6yiAprAMf5QfjqfhC8zbg4PwTMyA@mail.gmail.com>
References: <20170519154200.14158-1-ard.biesheuvel@linaro.org>
 <20170522174126.GJ1657@bivouac.eciton.net>
 <CAKv+Gu8vYP7xB5T_gFPvFQ6yiAprAMf5QfjqfhC8zbg4PwTMyA@mail.gmail.com>
Message-ID: <20170524101948.GB32240@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 23, 2017 at 03:51:11AM -0700, Ard Biesheuvel wrote:
> > So, I'm still of the opinion that /dev/mem simply should not be made
> > available on systems where people care about accidentally hard-locking
> > their systems from userland.
> >
> > To that extent, this workaround takes the pressure off people to
> > configure their kernels properly.
> >
> > On the other hand, it probably removes 90% of the risk cases.
> 
> Sadly, no. This change only fixes a kernel bug where we access a
> region using read()/write() that is known to be memory, but may have
> been left unmapped. It does not affect /dev/mem uses involving mmap()
> at all.

Ah. Well, in that case I don't have much of an objection.

> > I guess the solution depends on whether people think the remaining 10%
> > matter.
> 
> I think there are two different aspects that we need to distinguish:
> - on ARM, you cannot use /dev/mem to go looking for magic numbers in
> memory to locate certain data structures left by the firmware,
> - on ARM, you should [must] not use /dev/mem to map regions that are
> already mapped with different attributes.

And don't leave out the whopper:
- on ARM, running userland applications written to use /dev/mem to do
  specific things on x86 is unlikely to do what you expected it to do,
  and is likely to crash your system.

Being architecturally safe does not mean your system is not
vulnerable.

> This fix is in neither category, it just fails read()s on /dev/mem
> gracefully if they attempt to access NOMAP memory.

Understood.

> So the only moderately sane use case for /dev/mem on ARM is to do
> cached accesses to DRAM regions that are covered by the linear
> mapping.

Aside from "writing proper kernel interfaces takes effort", is there a
valid reason to do so?

Even if we did restrict it down to cached known DRAM regions, we would
still need to turn it read-only. Or a badly written program (I've
heard a couple exist) can start trampling whatever.

If people need a generic way to easily give access to certain defined
memory regions, let's write a driver that chomps kernel command line
or DT and provides simple mmap access to those specific regions.

If people want arbitrary userspace access to any region in memory at
any given time, why did we waste the gates and energy of implementing
an MMU and managing permissions?

> Interestingly, these are exactly the ones RESTRICT_DEVMEM
> usually disallows IIRC, given that you may be poking into kernel
> internals.

Yes, well, given its history as being PROMISC_DEVMEM renamed and
flipped logically, I doubt that't the only inconsistency...

> My vote would be to deprecate other /dev/mem uses on arm64, so that we
> can start getting a handle on things before the cat is too far out of
> the bag. (and you can't 'break' a x86 userspace this way on arm64 if
> it was simply recompiled but pokes memory for legacy BIOS strings etc)

To no one's surprise, my vote is to deprecate all uses of /dev/mem on
arm64. 

/
    Leif
