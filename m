From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 3 Sep 2015 18:14:58 +0100
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <BE017903-1EEB-48E9-88C0-A1412534CB4D@caviumnetworks.com>
References: <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
 <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com>
 <20150901221254.5e08ab6e@i7>
 <8C837F8F-050A-45DD-882B-02E107EFD663@caviumnetworks.com>
 <20150902165752.782e75be@i7>
 <CA+=Sn1=27ibpBokqJj3vLZ7NsnovKRdq7mR22ReeJJya4ona-A@mail.gmail.com>
 <20150902171157.GC25614@e104818-lin.cambridge.arm.com>
 <BE017903-1EEB-48E9-88C0-A1412534CB4D@caviumnetworks.com>
Message-ID: <20150903171458.GF5019@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 02, 2015 at 05:21:24PM +0000, Pinski, Andrew wrote:
> On Sep 3, 2015, at 1:12 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Wed, Sep 02, 2015 at 10:52:05PM +0800, Andrew Pinski wrote:
> >> That is not a bad idea.  Put this array in the data section of the
> >> VDSO too.  It should be small enough though on systems with 96 or more
> >> cores (dual socket ThunderX has 96 cores total), it is slightly
> >> getting big.
> >> The struct would be something like:
> >> struct
> >> {
> >>  int32 numcores;
> >>  int32 midr[];
> >> };
> > 
> > First of all, I'm against hard-coding (VDSO) data as ABI. So far we used
> > VDSO to override some weak glibc functions but the VDSO-specific data is
> > parsed by the VDSO function implementation and not directly by glibc (or
> > user space). I prefer helper functions that read the VDSO-internal data
> > structures.
> 
> You don't like the idea of a fixed structure ABI that resides inside
> vdso data? Having a fixed struct ABI should be ok.  The location
> inside the data part was going to be passed via an aux vector entry.
> Userland does even need to know it is really located in the vdso at
> all. It just happens to reside in there. The data structure would be
> well defined for the aux vector. 

The problem is not necessarily the location of the data structure but
whether you are confident it has all the information you need and won't
require changing.

> > Secondly, you seem to be only interested in MIDR_EL1 but we also have
> > REVIDR_EL1 and AIDR_EL1 which may be relevant. Once we realise that more
> > information is needed, it's not always clear where the boundaries are
> > so I would rather have this exposed via /sys and/or MRS emulation (there
> > are patches for both).
> > 
> > Anyway, you need to involve the toolchain people in such discussions,
> > they may have different needs (like ifunc).
> 
> I am a toolchain person first and needed this in the first place for
> memset and memcpy on thunderx.

That's exactly my point. You only care about a micro-optimisation on
thunderx and a quick solution for this specific case. I care about the
wider ecosystem. I'm sure it won't be long before someone asks about
exposing AIDR_EL1 (REVIDR_EL1 was already requested), cache information,
big.LITTLE topology and so on.

We currently have patches to provide all the CPUID information we
_think_ is relevant to user space, though in different forms (/sys and
MRS emulation). As long as you cache such information in user space, the
overhead of a trapped MRS or /sys access is minimal.

-- 
Catalin
