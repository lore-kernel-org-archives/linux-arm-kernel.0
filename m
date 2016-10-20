From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 20 Oct 2016 11:12:29 +0100
Subject: [PATCH] arm64: Add support for additional relocations in the
 kexec purgatory code
In-Reply-To: <15f9c4d2-34a8-fd74-05ec-0a8df41bc93a@infradead.org>
References: <1476892714-27304-1-git-send-email-catalin.marinas@arm.com>
 <15f9c4d2-34a8-fd74-05ec-0a8df41bc93a@infradead.org>
Message-ID: <20161020101228.GE23600@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 19, 2016 at 03:52:30PM -0700, Geoff Levand wrote:
> Hi Catalin,
> 
> On 10/19/2016 08:58 AM, Catalin Marinas wrote:
> > diff --git a/kexec/arch/arm64/kexec-arm64.c b/kexec/arch/arm64/kexec-arm64.c
> > index 2e8839a..e067a23 100644
> > --- a/kexec/arch/arm64/kexec-arm64.c
> > +++ b/kexec/arch/arm64/kexec-arm64.c
> > @@ -585,6 +598,19 @@ void machine_apply_elf_rel(struct mem_ehdr *ehdr, struct mem_sym *UNUSED(sym),
> >  		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> >  			+ (((value - address) << 3) & 0xffffe0));
> >  		break;
> > +	case R_AARCH64_ADR_PREL_PG_HI21:
> > +		type = "ADR_PREL_PG_HI21";
> > +		imm = ((value & ~0xfff) - (address & ~0xfff)) >> 12;
> > +		loc32 = ptr;
> > +		*loc32 = cpu_to_le32(le32_to_cpu(*loc32)
> > +			+ ((imm & 3) << 29) + ((imm & 0x1ffffc) << (5 - 2)));
> > +		break;
> > +	case R_AARCH64_ADD_ABS_LO12_NC:
> > +		type = "R_AARCH64_ADD_ABS_LO12_NC";
> 
> Following with the others, this should be 'type = "ADD_ABS_LO12_NC"'.

Ah, I missed this detail. I'll post a v2 shortly.

Thanks.

-- 
Catalin
