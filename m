From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 18 Dec 2013 10:55:41 +0000
Subject: [PATCH 0/4] arm64: advertise availability of CRC and crypto
 instructions
In-Reply-To: <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
References: <1387227878-30438-1-git-send-email-ard.biesheuvel@linaro.org>
 <20131217122519.GI32118@arm.com>
 <CAKv+Gu824T1vx=O9taLaDSB-HE3OLSpwnpWMn4z+x8YdmLuM+A@mail.gmail.com>
 <20131218100321.GC4360@n2100.arm.linux.org.uk>
 <CAKv+Gu87zHkxKKyH0-jEcBKcdbWTahN2bgWRDpPog5bds_ukYg@mail.gmail.com>
Message-ID: <20131218105541.GE4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 18, 2013 at 11:25:40AM +0100, Ard Biesheuvel wrote:
> On 18 December 2013 11:03, Russell King - ARM Linux
> <linux@arm.linux.org.uk> wrote:
> > If we allocate the ARM64 private never-will-appear-on-ARM hwcaps in bit
> > 32 and above, they'll be hidden from 32-bit stuff.  Hopefully, glibc
> > doesn't concatenate the HWCAP and HWCAP2 fields though - someone should
> > check that.
> >
> > Since the bits in the ARM64 hwcap are different from the ARM32 hwcap, I
> > don't see any point in defining them for ARM32 - userspace needs to make
> > the definition conditional anyway, and can't interpret the bits as-is
> > because ARM64 already omits many of the ARM32 ones.
> 
> Please note that this is about the compat bits, not the ARM64 specific
> ones. These correspond 1:1 with the ARM32 ones. The idea is that a
> binary built for ARM will have access to the extended instructions
> which ARM64 offers to ARM32 binaries running in 32 bit compatibility
> mode (such as AES, SHAx etc).

This all sounds rather silly IMHO.  As ARM32 natively doesn't support
these instructions, why should running an ARM32 binary under ARM64
end up offering this?

If the ARM64 additional instructions are to be used, surely it's not
unreasonable to require ARM64 native applications?

In order to use these new instructions, you're going to have to build
using 64-bit anyway, at which point you have the problem of linking
32-bit applications with 64-bit libraries, and the inherent
incompatibility in the API between the two.  Remember, in 64-bit mode,
your pointers are 64-bit whereas in 32-bit mode, they're 32-bit.

Frankly, I don't see the point, not do I see what you're talking about
being technically possible.
