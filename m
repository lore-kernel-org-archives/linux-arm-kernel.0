From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 17 Dec 2014 09:25:06 +0000
Subject: [RFC] ACPI on arm64 TODO List
In-Reply-To: <5490C83A.2080600@linaro.org>
References: <548F9668.6080900@linaro.org> <9355623.14GfrLxEB0@wuerfel>
 <20141216152707.GH11565@e104818-lin.cambridge.arm.com>
 <5490C83A.2080600@linaro.org>
Message-ID: <20141217092505.GA9475@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 17, 2014 at 12:03:06AM +0000, Al Stone wrote:
> On 12/16/2014 08:27 AM, Catalin Marinas wrote:
> > On Tue, Dec 16, 2014 at 11:27:48AM +0000, Arnd Bergmann wrote:
> >> On Monday 15 December 2014 19:18:16 Al Stone wrote:
> >>> TODO List for ACPI on arm64:
> >>> ============================
> [snip..]
> >>> 4. Set clear expectations for those providing ACPI for use with Linux
> >>>    * Problem:
> >>>      * Hardware/Firmware vendors can and will create ACPI tables that
> >>>        cannot be used by Linux without some guidance
> >>>      * Kernel developers cannot determine whether the kernel or firmware
> >>>        is broken without knowing what the firmware should do
> >>>    * Solution: document the expectations, and iterate as needed.
> >>>      Enforce when we must.
> >>>    * Status: initial kernel text available; AMD has offered to make
> >>>      their guidance document generic; firmware summit planned for
> >>>      deeper discussions.
> >>
> [snip...]
> > 
> > Another example is SMP booting. The ACPI 5.1 spec mentions the parking
> > protocol but I can't find a reference to the latest document. In the
> > meantime, we stick to PSCI.
> 
> Hrm.  A bug in the spec.
> 
> Every external document mentioned in the ACPI spec is supposed to have
> a link that will eventually get you to the source document.  All links
> in the spec should point here http://www.uefi.org/acpi which in turn
> has links to the authoritative original documents.  However, it looks
> like the parking protocol document pointed to (the "Multiprocessor
> Startup" link) may not be the most recent version.  The reference in
> the spec to the protocol (Table 5-61, Section 5.2.12.14)) also appears
> to be useless (it points to http://infocenter.arm.com/help/index.jsp
> which doesn't have the document either).  I've filed a change request
> with ASWG to fix this.

Thanks. I followed the same links but couldn't find any newer version.

> That being said, the early systems still don't provide PSCI.  They will
> at some point in the future, but not now.  Regardless, I think it's
> reasonable for us to say that if you want ACPI support, PSCI must be
> used for secondary CPU startup.  People can hack something up to get
> the parking protocol to work on development branches if they want, but
> I personally see no need to get that into the kernel -- and it needs
> to be said explicitly in arm-acpi.txt.

I'm fine with this. But note that it pretty much rules out the APM
boards (I think we ruled them out a few times already) which don't have
an EL3 to host PSCI firmware. EL2 is not suitable as it is likely that
we want this level for KVM or Xen rather than platform firmware.

-- 
Catalin
