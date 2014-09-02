From: bhupesh.sharma@freescale.com (bhupesh.sharma at freescale.com)
Date: Tue, 2 Sep 2014 10:27:49 +0000
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <20140902101438.GC25092@arm.com>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140828145635.GL14650@leverpostej>
 <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140829174757.GD18555@leverpostej>
 <78eaae039fd04eb58e1dac715968dd72@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140902100531.GB25092@arm.com> <20140902101438.GC25092@arm.com>
Message-ID: <10117779d53642feb9f1e7deb2b8e928@BN1PR03MB220.namprd03.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -----Original Message-----
> From: Catalin Marinas [mailto:catalin.marinas at arm.com]
> Sent: Tuesday, September 02, 2014 3:45 PM
> To: Sharma Bhupesh-B45370
> Cc: Mark Rutland; Will Deacon; arnd at arndb.de; grant.likely at secretlab.ca;
> Marc Zyngier; rob.herring at linaro.org; linux-arm-
> kernel at lists.infradead.org; Yoder Stuart-B08248; Basu Arnab-B45036
> Subject: Re: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
> 
> On Tue, Sep 02, 2014 at 11:05:31AM +0100, Catalin Marinas wrote:
> > On Fri, Aug 29, 2014 at 07:07:40PM +0100, bhupesh.sharma at freescale.com
> wrote:
> > > > > > > +	memory at 80000000 {
> > > > > > > +		device_type = "memory";
> > > > > > > +		reg = <0x00000000 0x80000000 0 0x80000000>;
> > > > > > > +		      /* DRAM space 1 - 2 GB DRAM */
> > > > > > > +	};
> > > > > >
> > > > > > Does that mean:
> > > > > >
> > > > > >  - This is "DRAM space 1", populated with 2GB?
> > > > > >
> > > > > > Or:
> > > > > >
> > > > > >  - The DRAM space can be populated with 1 to 2 GB?
> > > > > >
> > > > > > If the former, s/ - /: / for clarity.
> > > > > >
> > > > > > If the latter, it might make sense to move that into
> > > > > > board-specific dts files. If this can be dynamically populated
> > > > > > ideally the firmware/loader would fix this up (assuming it can
> probe the memory).
> > > > >
> > > > > If the former. I will fix it up in v3.
> > > >
> > > > Ok. Out of curiosity, are there other DRAM spaces that might be
> > > > populated?
> > >
> > > Yes there is another DRAM space. The 1st one is accessible within 32
> > > bits and the 2nd one is accessible from 40-bit and above. However, I
> > > was waiting for the 4-level ARM64 page table patches (from Catalin)
> > > to get absorbed, as w/o the same we can access only a 39-bit PA and
> > > hence can have only 3-level page table limited to the 1st DRAM region
> (which is accessible via first 32 bits).
> > >
> > > Any idea, about the latest state of Catalin's patch ([1])? Has it
> made to linux-next?
> >
> > The 48-bit VA support is in mainline but you wouldn't be able to
> > enable it because KVM is still broken. Hopefully it will make it to
> 3.18-rc1.
> >
> > But here we are talking about 40-bit PA range which should be fine
> > with
> > 3 levels of page tables. The only problem is if you want to idmap the
> > memory beyond 40-bit (I don't know whether UEFI requires this but for
> > kernel booting you wouldn't need it since the kernel image is in the
> > lower part).
> 
> Ah, I confused my self (and thanks to Mark Rutland for telling me). If
> your PA range spans 40-bit, the kernel linear mapping would have to span
> 40-bit as well unless we either implement highmem or compress the
> phys_to_virt(). None of these are desirable on arm64, so it leaves us
> with 48-bit VA (which will be enabled by default in defconfig once KVM is
> sorted).
> 

Right. Thanks for the useful information, Catalin.

Regards,
Bhupesh
