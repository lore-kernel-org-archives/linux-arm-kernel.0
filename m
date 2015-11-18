From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 18 Nov 2015 21:45:14 +0100
Subject: [PATCH v6 16/19] aarch64: ilp32: use generic stat64 structure
In-Reply-To: <20151118203620.GC11264@yury-N73SV>
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <4020528.IPMzSqapue@wuerfel> <20151118203620.GC11264@yury-N73SV>
Message-ID: <4142331.V6JV5koyt3@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 18 November 2015 23:36:20 Yury Norov wrote:
> On Tue, Nov 17, 2015 at 11:09:05PM +0100, Arnd Bergmann wrote:
> > On Wednesday 18 November 2015 00:16:56 Yury Norov wrote:
> > > Generic 32-bit and AARCH32 stat64 structures has same names.
> > > ILP32 needs generic stat64. So we can either make ILP32 mutual
> > > exclusive with AARCH32, or duplicate generic cp_new_stat64 code
> > > and struct stat64 to sys_ilp32.c. We choose second because it's
> > > more flexible to have independend support for ABIs.
> > > 
> > 
> > I commented on the previous version, but you have not replied to that,
> > or changed anything.
> > 
> > 	Arnd
> 
> Hi Arnd,
> 
> It seems I misunderstood you.
> 
> Are you OK if we'll enable __ARCH_WANT_COMPAT_STAT64
> for ILP32, as for AARCH32_EL0, and turn glibc to use
> struct stat from sysdeps/unix/sysv/linux/bits/stat.h
> with this calls? It seems, this is how ARM ABI works.

Yes, that's fine. The other approach I suggested was to define a stat64
structure in arch/arm64/include/uapi/asm/stat.h that has the same binary
layout as 'struct stat' on arm64, and then use sys_newstat.

We are doing it that way in the 64-bit time_t patch set for most
architectures, and will assign a new system call number at that
point as well.

The only two differences between the arm32 'struct stat64' and the
arm64 'struct stat' are the size of the time members and the broken
__st_ino field on arm32, but that is already handled in glibc.

	Arnd
