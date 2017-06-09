From: labbott@redhat.com (Laura Abbott)
Date: Fri, 9 Jun 2017 11:05:04 -0700
Subject: [PATCH 0/2] arm64: fix crash when reading /proc/kcore
In-Reply-To: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
References: <20170608194139.9250-1-ard.biesheuvel@linaro.org>
Message-ID: <7bbed6bb-63e9-bb75-318f-0054967ee087@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/08/2017 12:41 PM, Ard Biesheuvel wrote:
> This is a follow-up to patches from zhonjiang [0] and myself [1] that aim
> to solve a problem in the kcore code, which gets confused by the presence
> of block mappings in the vmalloc region.
> 
> While fixing the crash is quite straight forward [2], we need to tweak
> the kcore code itself to ensure that it operates correctly on arm64.
> Fortunately, we can achieve this with two very simple changes:
> 
> - replace a call to is_vmalloc_or_module_addr() in read_kcore() with a
>   comparison of the kclist type field (#1)
> - enable CONFIG_ARCH_PROC_KCORE_TEXT for arm64 (#2)
> 
> [0] http://marc.info/?l=linux-mm&m=149632393629295&w=2
> [1] http://marc.info/?l=linux-mm&m=149685966530180&w=2
> [2] http://marc.info/?l=linux-mm&m=149694975123959&w=2
> 
> Ard Biesheuvel (2):
>   fs/proc: kcore: use kcore_list type to check for vmalloc/module
>     address
>   arm64: mm: select CONFIG_ARCH_PROC_KCORE_TEXT
> 
>  arch/arm64/Kconfig | 3 +++
>  fs/proc/kcore.c    | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 

Reviewed-by: Laura Abbott <labbott@redhat.com>

I wish there was actual Kconfig help text for CONFIG_ARCH_PROC_KCORE_TEXT
instead of having to go into kcore.c to read about how it was used but
that can be fixed up separately.

Thanks,
Laura
