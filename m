From: f.fainelli@gmail.com (Florian Fainelli)
Date: Mon, 5 Dec 2016 16:50:33 -0800
Subject: [PATCHv4 05/10] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <1480445729-27130-6-git-send-email-labbott@redhat.com>
References: <1480445729-27130-1-git-send-email-labbott@redhat.com>
 <1480445729-27130-6-git-send-email-labbott@redhat.com>
Message-ID: <72eb08c8-4f2c-6cb9-1e23-0860fd153a2e@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/29/2016 10:55 AM, Laura Abbott wrote:
> __pa_symbol is technically the marco that should be used for kernel
> symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
> will do bounds checking. As part of this, introduce lm_alias, a
> macro which wraps the __va(__pa(...)) idiom used a few places to
> get the alias.
> 
> Signed-off-by: Laura Abbott <labbott@redhat.com>
> ---
> v4: Stop calling __va early, conversion of a few more sites. I decided against
> wrapping the __p*d_populate calls into new functions since the call sites
> should be limited.
> ---


> -	pud_populate(&init_mm, pud, bm_pmd);
> +	if (pud_none(*pud))
> +		__pud_populate(pud, __pa_symbol(bm_pmd), PMD_TYPE_TABLE);
>  	pmd = fixmap_pmd(addr);
> -	pmd_populate_kernel(&init_mm, pmd, bm_pte);
> +	__pmd_populate(pmd, __pa_symbol(bm_pte), PMD_TYPE_TABLE);

Is there a particular reason why pmd_populate_kernel() is not changed to
use __pa_symbol() instead of using __pa()? The other users in the arm64
kernel is arch/arm64/kernel/hibernate.c which seems to call this against
kernel symbols as well?
-- 
Florian
