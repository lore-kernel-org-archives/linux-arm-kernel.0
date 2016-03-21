From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 21 Mar 2016 12:07:24 +0000
Subject: [PATCH] arm64/kernel: fix incorrect EL0 check in inv_entry macro
In-Reply-To: <1458295089-24447-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1458295089-24447-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20160321120723.GB25466@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 10:58:09AM +0100, Ard Biesheuvel wrote:
> The implementation of macro inv_entry refers to its 'el' argument without
> the required leading backslash, which results in an undefined symbol
> 'el' to be passed into the kernel_entry macro rather than the index of
> the exception level as intended.
> 
> This undefined symbol strangely enough does not result in build failures,
> although it is visible in vmlinux:
> 
>      $ nm -n vmlinux |head
>                       U el
>      0000000000000000 A _kernel_flags_le_hi32
>      0000000000000000 A _kernel_offset_le_hi32
>      0000000000000000 A _kernel_size_le_hi32
>      000000000000000a A _kernel_flags_le_lo32
>      .....
> 
> However, it does result in incorrect code being generated for invalid
> exceptions taken from EL0, since the argument check in kernel_entry
> assumes EL1 if its argument does not equal '0'.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Applied. Thanks.

-- 
Catalin
