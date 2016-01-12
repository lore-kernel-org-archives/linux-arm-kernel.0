From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 13 Jan 2016 00:05:28 +0100
Subject: [PATCH v6 11/21] arm64: ilp32: introduce binfmt_ilp32.c
In-Reply-To: <20160112164641.GA9246@yury-N73SV>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
 <5115829.mX1Uk4EoYk@wuerfel> <20160112164641.GA9246@yury-N73SV>
Message-ID: <28415384.BjJykMzeP5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 12 January 2016 19:46:41 Yury Norov wrote:
> On Fri, Jan 08, 2016 at 10:08:44AM +0100, Arnd Bergmann wrote:
> > On Friday 08 January 2016 02:34:29 Yury Norov wrote:
> > > +
> > > +#include "../../../fs/compat_binfmt_elf.c"
> > > 
> > 
> > This is the wrong file, you have to include fs/binfmt_elf.c, otherwise
> > you pick up the same definitions that you have for the other one.
> > 
> 
> I chose compat as it's how it wokrs now. It redefines some types like
> user_long_t, and I think it's neccessary for ILP32, as for aarch32.

I really think the double indirection adds way too much complexity
here, it makes it rather hard to understand what is going on, and
that leads to bugs.

fs/compat_binfmt_elf.c is not doing much at all, and most of it is not
actually needed if you just make a copy of that file and fill in the
data as needed. Some of the overrides (ELF_ARCH, ELF_PLATFORM, ELF_NREG,
ELF_HWCAP, ELF_HWCAP2) are identical between ilp32 and lp64 modes
for arm64, but are different for arm32 compat, so you don't even have
to override them at all.

	Arnd
