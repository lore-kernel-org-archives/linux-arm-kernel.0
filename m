From: will.deacon@arm.com (Will Deacon)
Date: Mon, 8 Apr 2013 16:57:49 +0100
Subject: [PATCH] Report double word access atomicity on LPAE enabled
 targets through AUXV
In-Reply-To: <20130408142406.GL17995@n2100.arm.linux.org.uk>
References: <C3FF039D-7DE3-4A99-8317-789094095D8B@oracle.com>
 <20130408142406.GL17995@n2100.arm.linux.org.uk>
Message-ID: <20130408155749.GS17476@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Apr 08, 2013 at 03:24:06PM +0100, Russell King - ARM Linux wrote:
> I think we're heading towards running out of hwcap bits to represent all
> these different features.  Not there yet, but after this we only have 11
> spare bits.
> 
> Maybe we need to switch to a more x86-centric method where we report this
> stuff in /proc/cpuinfo, and userspace parses this information out.  If
> glibc already has code in there for x86, maybe we can reuse that?

Why can't we just pass multiple AT_HWCAP entries in the auxv? It would
require a small change to the ELF loader to allow an architecture to provide
more than just ELF_HWCAP, but it's fairly straightforward and easy to
propogate without breaking backwards compatibility.

> > +        if (((read_cpuid_ext(CPUID_EXT_MMFR3) >> 28) & 0xf) > 0)
> > 
> > +          elf_hwcap |= HWCAP_ATOMICD;
> 
> We use tabs for indentation, not two spaces.  Also, on the face of it
> ATOMICD isn't obvious what it means.  Maybe HWCAP_LDRDSTRD would be
> better - it's only one character longer and truely reflects what you're
> trying to report - the presence of these two instructions.

Actually, it's not just the presence of those instructions -- it's their
behaviour wrt atomicity. They are only guaranteed to be atomic if the CPU in
question supports LPAE. We could call it "lpae" but it might be set even
when the kernel is using the short-descriptor format.

Will
