From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 2 Sep 2014 11:05:31 +0100
Subject: [PATCH V2 4/6] arm64: Add DTS support for FSL's LS2085A SoC
In-Reply-To: <78eaae039fd04eb58e1dac715968dd72@BN1PR03MB220.namprd03.prod.outlook.com>
References: <1409219706-14843-1-git-send-email-bhupesh.sharma@freescale.com>
 <1409219706-14843-5-git-send-email-bhupesh.sharma@freescale.com>
 <20140828145635.GL14650@leverpostej>
 <18f8ee091e8847c0bcfba1ef04907a71@BN1PR03MB220.namprd03.prod.outlook.com>
 <20140829174757.GD18555@leverpostej>
 <78eaae039fd04eb58e1dac715968dd72@BN1PR03MB220.namprd03.prod.outlook.com>
Message-ID: <20140902100531.GB25092@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 29, 2014 at 07:07:40PM +0100, bhupesh.sharma at freescale.com wrote:
> > > > > +	memory at 80000000 {
> > > > > +		device_type = "memory";
> > > > > +		reg = <0x00000000 0x80000000 0 0x80000000>;
> > > > > +		      /* DRAM space 1 - 2 GB DRAM */
> > > > > +	};
> > > >
> > > > Does that mean:
> > > >
> > > >  - This is "DRAM space 1", populated with 2GB?
> > > >
> > > > Or:
> > > >
> > > >  - The DRAM space can be populated with 1 to 2 GB?
> > > >
> > > > If the former, s/ - /: / for clarity.
> > > >
> > > > If the latter, it might make sense to move that into board-specific
> > > > dts files. If this can be dynamically populated ideally the
> > > > firmware/loader would fix this up (assuming it can probe the memory).
> > >
> > > If the former. I will fix it up in v3.
> > 
> > Ok. Out of curiosity, are there other DRAM spaces that might be
> > populated?
> 
> Yes there is another DRAM space. The 1st one is accessible within 32 bits and
> the 2nd one is accessible from 40-bit and above. However, I was waiting
> for the 4-level ARM64 page table patches (from Catalin) to get absorbed, as w/o the
> same we can access only a 39-bit PA and hence can have only 3-level page table limited
> to the 1st DRAM region (which is accessible via first 32 bits).
> 
> Any idea, about the latest state of Catalin's patch ([1])? Has it made to linux-next?

The 48-bit VA support is in mainline but you wouldn't be able to enable
it because KVM is still broken. Hopefully it will make it to 3.18-rc1.

But here we are talking about 40-bit PA range which should be fine with
3 levels of page tables. The only problem is if you want to idmap the
memory beyond 40-bit (I don't know whether UEFI requires this but for
kernel booting you wouldn't need it since the kernel image is in the
lower part).

-- 
Catalin
