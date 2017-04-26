From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 26 Apr 2017 12:32:04 +0100
Subject: [PATCH v2 2/2] arm64: module: split core and init PLT sections
In-Reply-To: <1487715177-30790-3-git-send-email-ard.biesheuvel@linaro.org>
References: <1487715177-30790-1-git-send-email-ard.biesheuvel@linaro.org>
 <1487715177-30790-3-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20170426113203.GB9406@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 21, 2017 at 10:12:57PM +0000, Ard Biesheuvel wrote:
> The arm64 module PLT code allocates all PLT entries in a single core
> section, since the overhead of having a separate init PLT section is
> not justified by the small number of PLT entries usually required for
> init code.
> 
> However, the core and init module regions are allocated independently,
> and there is a corner case where the core region may be allocated from
> the VMALLOC region if the dedicated module region is exhausted, but the
> init region, being much smaller, can still be allocated from the module
> region. This leads to relocation failures if the distance between those
> regions exceeds 128 MB. (In fact, this corner case is highly unlikely to
> occur on arm64, but the issue has been observed on ARM, whose module
> region is much smaller).
> 
> So split the core and init PLT regions, and name the latter ".init.plt"
> so it gets allocated along with (and sufficiently close to) the .init
> sections that it serves. Also, given that init PLT entries may need to
> be emitted for branches that target the core module, modify the logic
> that disregards defined symbols to only disregard symbols that are
> defined in the same section as the relocated branch instruction.
> 
> Since there may now be two PLT entries associated with each entry in
> the symbol table, we can no longer hijack the symbol::st_size fields
> to record the addresses of PLT entries as we emit them for zero-addend
> relocations. So instead, perform an explicit comparison to check for
> duplicate entries.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

I forgot about this patch. I'll queue it for 4.12. Thanks.

-- 
Catalin
