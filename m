From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 21 Nov 2017 09:40:27 +0000
Subject: =?utf-8?B?562U5aSN?= =?utf-8?Q?=3A?= [PATCH 01/11] Initialize
 the mapping of KASan shadow memory
In-Reply-To: <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
References: <bbf43f92-3d0c-940d-b66b-68f92eb9b282@arm.com>
 <B8AC3E80E903784988AB3003E3E97330C00635F3@dggemm510-mbs.china.huawei.com>
 <87po8ir1kg.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C006371B@dggemm510-mbs.china.huawei.com>
 <87375eqobb.fsf@on-the-bus.cambridge.arm.com>
 <B8AC3E80E903784988AB3003E3E97330C0063816@dggemm510-mbs.china.huawei.com>
 <20171117073556.GB28855@cbox>
 <B8AC3E80E903784988AB3003E3E97330C00638D4@dggemm510-mbs.china.huawei.com>
 <20171118134841.3f6c9183@why.wild-wind.fr.eu.org>
 <B8AC3E80E903784988AB3003E3E97330C0068F12@dggemm510-mbx.china.huawei.com>
Message-ID: <20171121094027.GF31757@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 21, 2017 at 07:59:01AM +0000, Liuwenliang (Abbott Liu) wrote:
> On Nov 17, 2017  21:49  Marc Zyngier [mailto:marc.zyngier at arm.com]  wrote:
> >On Sat, 18 Nov 2017 10:40:08 +0000
> >"Liuwenliang (Abbott Liu)" <liuwenliang@huawei.com> wrote:
> 
> >> On Nov 17, 2017  15:36 Christoffer Dall [mailto:cdall at linaro.org]  wrote:
> >> >If your processor does support LPAE (like a Cortex-A15 for example),
> >> >then you have both the 32-bit accessors (MRC and MCR) and the 64-bit
> >> >accessors (MRRC, MCRR), and using the 32-bit accessor will simply access
> >> >the lower 32-bits of the 64-bit register.
> >> >
> >> >Hope this helps,
> >> >-Christoffer
> >>
> >> If you know the higher 32-bits of the 64-bits cp15's register is not useful for your system,
> >> then you can use the 32-bit accessor to get or set the 64-bit cp15's register.
> >> But if the higher 32-bits of the 64-bits cp15's register is useful for your system,
> >> then you can't use the 32-bit accessor to get or set the 64-bit cp15's register.
> >>
> >> TTBR0/TTBR1/PAR's higher 32-bits is useful for CPU supporting LPAE.
> >> The following description which comes from ARM(r) Architecture Reference
> >> Manual ARMv7-A and ARMv7-R edition tell us the reason:
> >>
> >> 64-bit TTBR0 and TTBR1 format:
> >> ...
> >> BADDR, bits[39:x] :
> >> Translation table base address, bits[39:x]. Defining the translation table base address width on
> >> page B4-1698 describes how x is defined.
> >> The value of x determines the required alignment of the translation table, which must be aligned to
> >> 2x bytes.
> >>
> >> Abbott Liu: Because BADDR on CPU supporting LPAE may be bigger than max value of 32-bit, so bits[39:32] may
> >> be valid value which is useful for the system.
> >>
> >> 64-bit PAR format
> >> ...
> >> PA[39:12]
> >> Physical Address. The physical address corresponding to the supplied virtual address. This field
> >> returns address bits[39:12].
> >>
> >> Abbott Liu: Because Physical Address on CPU supporting LPAE may be bigger than max value of 32-bit,
> >> so bits[39:32] may be valid value which is useful for the system.
> >>
> >> Conclusion: Don't use 32-bit accessor to get or set TTBR0/TTBR1/PAR on CPU supporting LPAE,
> >> if you do that, your system may run error.
> 
> >That's not really true. You can run an non-LPAE kernel that uses the
> >32bit accessors an a Cortex-A15 that supports LPAE. You're just limited
> >to 4GB of physical space. And you're pretty much guaranteed to have
> >some memory below 4GB (one way or another), or you'd have a slight
> >problem setting up your page tables.
> 
> >       M.
> >--
> >Without deviation from the norm, progress is not possible.
> 
> Thanks for your review.
> Please don't ask people to limit to 4GB of physical space on CPU
> supporting LPAE, please don't ask people to guaranteed to have some
> memory below 4GB on CPU supporting LPAE.

A LPAE-capable CPU must always have memory below 4GB physical, no ifs
no buts.

If there's no memory below 4GB physical, then the CPU has no accessible
memory before the MMU is enabled.  That means operating systems such as
Linux are completely unbootable.

There must _always_ be accessible memory below 4GB physical.  This is
not negotiable, it's a fundamental requirement.

The location of physical memory has nothing to do with the accessors.
This point I'm making also has nothing to do with the accessors.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
