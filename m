From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Jul 2015 14:57:30 +0100
Subject: [PATCH 03/18] arm64: elf: advertise 8.1 atomic instructions as
 new hwcap
In-Reply-To: <20150717134845.GA15035@localhost>
References: <1436779519-2232-1-git-send-email-will.deacon@arm.com>
 <1436779519-2232-4-git-send-email-will.deacon@arm.com>
 <20150717134845.GA15035@localhost>
Message-ID: <20150717135730.GO7557@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 17, 2015 at 02:48:46PM +0100, Catalin Marinas wrote:
> On Mon, Jul 13, 2015 at 10:25:04AM +0100, Will Deacon wrote:
> >  #endif /* _UAPI__ASM_HWCAP_H */
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index f3067d4d4e35..c7fd2c946374 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -280,6 +280,19 @@ static void __init setup_processor(void)
> >  	if (block && !(block & 0x8))
> >  		elf_hwcap |= HWCAP_CRC32;
> >  
> > +	block = (features >> 20) & 0xf;
> > +	if (!(block & 0x8)) {
> > +		switch (block) {
> > +		default:
> > +		case 2:
> > +			elf_hwcap |= HWCAP_ATOMICS;
> > +		case 1:
> > +			/* RESERVED */
> > +		case 0:
> > +			break;
> > +		}
> > +	}
> 
> At some point, we should move the elf_hwcap setting to the cpu features
> infrastructure. The PAN patch series introduces an "enable" method for
> detected CPU features (can be cleaned up for 4.4).

On 32-bit ARM, we have this accessor:

	cpuid_feature_extract_field()

which is there to properly deal with sign extending the 4-bit values, and
avoids all the if (!(block & 8)) { crap.

The above could then become the much simpler:

	block = cpuid_feature_extract_field(...);
	if (block > 0)
		elf_hwcap |= HWCAP_CRC32;

	block = cpuid_feature_extract_field(isarN, 20);
	if (block > 1)
		elf_hwcap |= HWCAP_ATOMICS;

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
