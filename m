From: dalias@libc.org (Rich Felker)
Date: Sun, 16 Nov 2014 14:02:28 -0500
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141116171055.GM4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
Message-ID: <20141116190228.GW22465@brightrain.aerifal.cx>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 05:10:55PM +0000, Russell King - ARM Linux wrote:
> > > There's two ways to get that - firstly, the uname syscall, which gives
> > > a string in the form "armv..." which gives the CPU architecture.  The
> > 
> > Isn't it clear from the "Windows 10" fiasco that strcmp on a version
> > string is NOT an acceptable way to determine version/capabilities?
> 
> Would there be a "Windows 10" fiasco if there had been better control of
> the version numbering?  No.
> 
> However, this is already in use as a CPU architecture thing.  It's had a
> /very/ long history of being used by package managers to detect which
> packages are suitable for installation on a platform, whether it be an
> x86 platform, PowerPC, or ARM platform.

Use by package managers (which can be upgraded independently, and
which can, in the worst case, be overridden anyway) and by program
binaries for which you might not even have source are very different
issues.

> In both of these cases, we know that:
> - ARMv1-ARMv3 is no longer supported (for several years)
> - ARMv4 and ARMv5 do not have either the MCR or DMB instructions.
> - ARMv6 has the MCR instruction only
> - ARMv7 has the MCR instruction and the DMB instruction.
> - ARMv8 has the DMB instruction, and MCR emulation.
> 
> A safe bet would be that DMB is going to be there in the future (if that
> goes, then the ARM architecture will be regarded as even more of a toy
> architecture by Linus than he already regards it today, and he'll probably
> stop giving a damn about whether any changes break ARM.)

Yes, I think that's reasonable.

> Now, there is a twist here: ARM64 decided to use an ELF platform string
> of "aarch64" for everything, which means that rather than encoding the
> CPU architecture (like with every other Linux architecture), we have a
> string which encodes the kernel architecture instead, which is absurd.
> Obviously, the plan for ARM64 is that there will never be an ARMv9
> architecture, and ARMv8 is the perfect architecture for the future. :p

I'm confused. Does this mean that 32-bit binaries running on a 64-bit
kernel are going to see "aarch64" here?

> So, a reasonable parsing of this would be:
> 
> 	const char *ptr;
> 	int architecture;
> 
> 	ptr = (const char *)(uintptr_t)getauxval(AT_PLATFORM);
> 	assert(ptr);
> 
> 	if (!strncmp(ptr, "aarch64", 7))
> 		architecture = 8;
> 	else
> 		assert(sscanf(ptr, "v%d", &architecture) == 1);
> 
> 	switch (architecture) {
> 	case 4:
> 	case 5:
> 		no_mcr_dmb;
> 		break;
> 	case 6:
> 		use_mcr;
> 		break;
> 	default:
> 		use_dmb;
> 		break;
> 	}

Is (ptr[1]=='6' && !isdigit(ptr[2])) a safe condition for v6? v4/v5
(and original v6 without the k) don't need to be detected at all since
kuser is mandatory for them and already indicated by !(hwcap &
HWCAP_TLS).

Rich
