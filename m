From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 11 Aug 2015 15:23:01 +0100
Subject: [RFC PATCH 01/10] arm64: feature registers: Documentation
In-Reply-To: <CAKv+Gu-9GTzjqyT=NeBKjcaL7q-uFMToqPpprkyD-faG0J3mkQ@mail.gmail.com>
References: <1437731037-25795-1-git-send-email-suzuki.poulose@arm.com>
 <1437731037-25795-2-git-send-email-suzuki.poulose@arm.com>
 <20150810160636.GB15394@e104818-lin.cambridge.arm.com>
 <55C8E12E.6030305@arm.com>
 <CAKv+Gu-9GTzjqyT=NeBKjcaL7q-uFMToqPpprkyD-faG0J3mkQ@mail.gmail.com>
Message-ID: <20150811142301.GE23307@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 10, 2015 at 07:48:48PM +0200, Ard Biesheuvel wrote:
> > On 10/08/15 17:06, Catalin Marinas wrote:
> >> And to debunk some of the counter arguments:
> >>
> >> a) Running out of HWCAP bits - I really doubt this, we can always
> >>     introduce 64 more via a new elf_hwcapX
> 
> Note that ELF_HWCAP is also wired into ifunc resolution of GNU
> indirect functions, which looks like a useful feature although it
> isn't used that widely yet.

I forgot to mention, we also need an HWCAP_CPUID with these patches when
we expose the MRS interface. The ifunc resolver could use MRS when
available. But I would still keep adding HWCAP bits for new features,
even if we risk running out of the 64-bit we have now.

> The ifunc prototype for aarch64 has only one 'long' parameter, and I
> don't know if it is possible to extend that without having a bit in
> HWCAPn to indicate that HWCAPn+1 is valid. Also, the ifunc resolvers
> are restricted in the sense that they cannot use shared libraries or
> code that uses constructors (AFAIR) so it may require a special static
> library to call this CPU feature interface from such a resolver if
> features are not covered by HWCAP bits.

Or we could get some compiler intrinsics that generate the instruction
inline, just to avoid explicit asm.

> So treating HWCAP bits as an endless supply may not be the wisest
> approach here.

Probably not for ifunc, otherwise I don't think it hurts.

> Also, I think some alignment with the libc folks is indeed in order.

I agree (not sure how they feel about cross-posting though).

-- 
Catalin
