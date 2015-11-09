From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 9 Nov 2015 08:17:09 +0000
Subject: [PATCH] ARM/arm64: KVM: test properly for a PTE's uncachedness
In-Reply-To: <1446810188-13727-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1446810188-13727-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151109081709.2512e683@why.wild-wind.fr.eu.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 6 Nov 2015 12:43:08 +0100
Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> The open coded tests for checking whether a PTE maps a page as
> uncached use a flawed 'pte_val(xxx) & CONST != CONST' pattern,
> which is not guaranteed to work since the type of a mapping is an
> index into the MAIR table, not a set of mutually exclusive bits.
> 
> Considering that, on arm64, the S2 type definitions use the following
> MAIR indexes
> 
>     #define MT_S2_NORMAL            0xf
>     #define MT_S2_DEVICE_nGnRE      0x1
> 
> we have been getting lucky merely because the S2 device mappings also
> have the PTE_UXN bit set, which means that a device PTE still does not
> equal a normal PTE after masking with the former type.
> 
> Instead, implement proper checking against the MAIR indexes that are
> known to define uncached memory attributes.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Very well spotted, thanks Ard!

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Without deviation from the norm, progress is not possible.
