From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 18 Dec 2013 11:27:14 +0000
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
 <20131218105541.GE4360@n2100.arm.linux.org.uk>
 <CAKv+Gu_M56pXD8N6rANkYWLxXk=iLe3qpwt7zoBo_h6YuBgHTA@mail.gmail.com>
Message-ID: <20131218112713.GA28112@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:15:45AM +0000, Ard Biesheuvel wrote:
> On 18 December 2013 11:55, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > On Wed, Dec 18, 2013 at 11:25:40AM +0100, Ard Biesheuvel wrote:
> >> On 18 December 2013 11:03, Russell King - ARM Linux
> >> <linux@arm.linux.org.uk> wrote:
> >> > If we allocate the ARM64 private never-will-appear-on-ARM hwcaps in bit
> >> > 32 and above, they'll be hidden from 32-bit stuff.  Hopefully, glibc
> >> > doesn't concatenate the HWCAP and HWCAP2 fields though - someone should
> >> > check that.
> >> >
> >> > Since the bits in the ARM64 hwcap are different from the ARM32 hwcap, I
> >> > don't see any point in defining them for ARM32 - userspace needs to make
> >> > the definition conditional anyway, and can't interpret the bits as-is
> >> > because ARM64 already omits many of the ARM32 ones.
> >>
> >> Please note that this is about the compat bits, not the ARM64 specific
> >> ones. These correspond 1:1 with the ARM32 ones. The idea is that a
> >> binary built for ARM will have access to the extended instructions
> >> which ARM64 offers to ARM32 binaries running in 32 bit compatibility
> >> mode (such as AES, SHAx etc).
> >
> > This all sounds rather silly IMHO.  As ARM32 natively doesn't support
> > these instructions, why should running an ARM32 binary under ARM64
> > end up offering this?
> >
> > If the ARM64 additional instructions are to be used, surely it's not
> > unreasonable to require ARM64 native applications?
> 
> Well, the ARM architects have decided that there shall be Crypto
> Extensions instructions not only for ARMv8/Aarch64 but also for
> ARMv8/Aarch32. This is fully spec'ed in the latest ARM ARM. For
> instance, previously unused NEON opcodes on ARM32 have been allocated
> to AES instructions. (for instance, implemented for QEMU here
> https://git.linaro.org/people/peter.maydell/qemu-arm.git/commitdiff/9d935509)

Indeed. AArch32 is not _dead_ with ARMv8 but getting new features. The
point of this patch is to have a common set of bits between compat arm64
and arm kernel. The AArch32 applications running on ARMv8 (most likely
with an arm64 kernel) may want to make use of the crypto extensions.

If you want a more complete solution, we could add ID_ISAR5 checks on
the arm kernel.

-- 
Catalin
