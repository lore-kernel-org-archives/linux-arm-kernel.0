From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 9 Nov 2015 15:36:22 +0100
Subject: [PATCH 2/2] arm64: fix R/O permissions of FDT mapping
In-Reply-To: <20151109142714.GA21606@e104818-lin.cambridge.arm.com>
References: <1447059346-12050-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447059346-12050-3-git-send-email-ard.biesheuvel@linaro.org>
 <20151109142714.GA21606@e104818-lin.cambridge.arm.com>
Message-ID: <CAKv+Gu9y0XjfJUta+Z_P8CU1v-e=5XN2g1yP-eabR5QqP_TfoA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9 November 2015 at 15:27, Catalin Marinas <catalin.marinas@arm.com> wrote:
> On Mon, Nov 09, 2015 at 09:55:46AM +0100, Ard Biesheuvel wrote:
>> The mapping permissions of the FDT are set to 'PAGE_KERNEL | PTE_RDONLY'
>> in an attempt to map the FDT as read-only. However, not only does this
>> break at build time under STRICT_MM_TYPECHECKS (since the two terms are
>> of different types in that case), it also results in both the PTE_WRITE
>> and PTE_RDONLY attributes to be set, which means the region is still
>> writable under ARMv8.1 DBM (and an attempted write will simply clear the
>> PT_RDONLY bit).
>>
>> So instead, define PAGE_KERNEL_RO (which already has an established
>> meaning across architectures) and use that instead.
>
> I guess we don't need cc stable for this, it's only if the kernel has
> some other bug that writes the mapped fdt.
>

Indeed. Since only v8.1 DBM is affected, and the FDT was writable
anyway before this was added, I don't see the point.

-- 
Ard.
