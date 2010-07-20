From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 20 Jul 2010 23:12:17 +0200
Subject: [RFC] arm: versatile: enable PCI I/O space
In-Reply-To: <AANLkTikiim-a8zM0PRDVVN078xBWeZt7ElwbC4oZsfXy@mail.gmail.com>
References: <AANLkTikiim-a8zM0PRDVVN078xBWeZt7ElwbC4oZsfXy@mail.gmail.com>
Message-ID: <201007202312.18353.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 20 July 2010, Eric Miao wrote:

> > -
> > -/* CIK guesswork */
> > -#define PCIBIOS_MIN_IO                 0x44000000
> > +#define PCIBIOS_MIN_IO                 0x00001000
> 
> I guess this is true for other sub-architectures. Currently no idea
> why they are all using different values. But 0x1000 seems to be
> good value and maybe we should default all of them to this and
> move it into some common place instead of defining them every
> where.

Yes. The 0x1000 is really the only sensible way to avoid the
legacy ISA ranges. Most platforms currently set this to zero,
which only works as long as you never try to load things like
an PC keyboard driver (including KDB) or an nvram driver that
probes the well-known ISA ports. The only reason I can see for
using less than 0x1000 is if you have a really small
IO_SPACE_LIMIT, but most platforms seem to set that to
0xffffffff, which is rather unrealistic if you use a memory
mapped IO region.

We also have two platforms (integrator and shark) that use a
higher value of 0x6000 but do not document why they do so.
iop13xx defines it as variable but never sets it to anything
else than zero.

	Arnd
