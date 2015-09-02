From: tglx@linutronix.de (Thomas Gleixner)
Date: Wed, 2 Sep 2015 22:11:12 +0200 (CEST)
Subject: [PATCHv2] ARM64: Add AT_ARM64_MIDR to the aux vector
In-Reply-To: <BE017903-1EEB-48E9-88C0-A1412534CB4D@caviumnetworks.com>
References: <1440873982-44062-1-git-send-email-apinski@cavium.com>
 <20150901163304.GC16430@leverpostej>
 <A9115CAF-0C57-4810-97F6-6245E7D0CE48@gmail.com>
 <4C8DD5E0-E1EA-40C6-B947-72189241023C@caviumnetworks.com>
 <20150901173043.GE16430@leverpostej>
 <9AA83792-C973-4642-88BA-3C59F23EB048@gmail.com> <20150901221254.5e08ab6e@i7>
 <8C837F8F-050A-45DD-882B-02E107EFD663@caviumnetworks.com>
 <20150902165752.782e75be@i7>
 <CA+=Sn1=27ibpBokqJj3vLZ7NsnovKRdq7mR22ReeJJya4ona-A@mail.gmail.com>,
 <20150902171157.GC25614@e104818-lin.cambridge.arm.com>
 <BE017903-1EEB-48E9-88C0-A1412534CB4D@caviumnetworks.com>
Message-ID: <alpine.DEB.2.11.1509022207380.15006@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2 Sep 2015, Pinski, Andrew wrote:
> > On Sep 3, 2015, at 1:12 AM, Catalin Marinas <catalin.marinas@arm.com> wrote:
> >> On Wed, Sep 02, 2015 at 10:52:05PM +0800, Andrew Pinski wrote:
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

Restrict the VDSO ABI to well defined single purpose functions. It's
way harder to define data struct ABIs right from the beginning.

Thanks,

	tglx
