From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Nov 2014 13:54:13 +0000
Subject: ARM atomics overhaul for musl
In-Reply-To: <20141116171055.GM4042@n2100.arm.linux.org.uk>
References: <20141116055656.GA13940@brightrain.aerifal.cx>
 <20141116163355.GK4042@n2100.arm.linux.org.uk>
 <20141116165017.GT22465@brightrain.aerifal.cx>
 <20141116171055.GM4042@n2100.arm.linux.org.uk>
Message-ID: <20141117135412.GC29595@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 16, 2014 at 05:10:55PM +0000, Russell King - ARM Linux wrote:
> On Sun, Nov 16, 2014 at 11:50:17AM -0500, Rich Felker wrote:
> > On Sun, Nov 16, 2014 at 04:33:56PM +0000, Russell King - ARM Linux wrote:
> > > second way is the ELF AT_PLATFORM entry.  AT_PLATFORM has well defined
> > > format, and is already used to select between different library versions
> > > (so is already a user API, and is subject to user API rules).  See:
> > > 
> > > $ grep string.*elf_name arch/arm/mm/proc*.S
> > > 
> > > for a list of the prefixes - the last character is always the endian-ness.
> > > >From that, you can see that the format is "v" (for version), then the CPU
> > > architecture number, followed (optionally) by any suffixes.  Parse that
> > > wisely, and you have the CPU architecture version, and the CPU architecture
> > > version defines whether the MCR or DMB variant should be used.
> > 
> > That seems much more acceptable to use.
> > 
> > > See http://lwn.net/Articles/519085/ for a way to get at the ELF aux info
> > > with recent glibc.  I'm sure other C libraries will be getting their own
> > > implementation of that for compatibility with glibc.
> > 
> > Yes, we have access to the aux vector, so this should work in
> > principle.
> 
> In both of these cases, we know that:
> - ARMv1-ARMv3 is no longer supported (for several years)
> - ARMv4 and ARMv5 do not have either the MCR or DMB instructions.
> - ARMv6 has the MCR instruction only
> - ARMv7 has the MCR instruction and the DMB instruction.
> - ARMv8 has the DMB instruction, and MCR emulation.

MCR can be enabled in hardware on ARMv8 (SCTLR_EL1 bit), though there is
no guarantee that it is as fast as the DMB (normally I don't see a
reason why it wouldn't, it's just instruction decoding problem but you
never know what the microarchitecture does).

> Now, there is a twist here: ARM64 decided to use an ELF platform string
> of "aarch64" for everything,

Please define "everything". This matches the ELF name as defined in the
ARM 64-bit ELF ABI.

> which means that rather than encoding the
> CPU architecture (like with every other Linux architecture), we have a
> string which encodes the kernel architecture instead, which is absurd.

Just like x86_64 vs i686?

> Obviously, the plan for ARM64 is that there will never be an ARMv9
> architecture, and ARMv8 is the perfect architecture for the future. :p

If you haven't noticed, the distinction between ARMv6 and ARMv7 has been
blurred enough (guess why cpu_architecture() reports ARMv7 for
ARM11MPCore). ARM is trying to move away from architecture version
numbers, which are rather useful for marketing, to proper feature
detection based on CPUID. Whether there is an ARMv9 or not, it's
irrelevant to what Linux should do (i.e. use CPUID rather than guess
features based on architecture version numbers).

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

Oh, have you even bothered trying 32-bit (compat) getauxval(AT_PLATFORM)
on an aarch64 kernel? It reports "v8l", so please don't confuse others.

> Before this is finalised, I think the ARM64 maintainers need to have a long
> think about the wiseness of their existing AT_PLATFORM string, and consider
> whether they have created something of a cockup there.

We had a think long time ago already and it was a wise decision. FWIW,
it matches x86 in this respect.

-- 
Catalin
