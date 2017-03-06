From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 06 Mar 2017 08:34:00 +0000
Subject: [PATCH v2] arm64: kvm: Use has_vhe() instead of
 hyp_alternate_select()
In-Reply-To: <1488767598-2055-1-git-send-email-shankerd@codeaurora.org>
 (Shanker Donthineni's message of "Sun, 5 Mar 2017 20:33:18 -0600")
References: <1488767598-2055-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <87bmte3itj.fsf@on-the-bus.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shanker,

On Mon, Mar 06 2017 at  2:33:18 am GMT, Shanker Donthineni <shankerd@codeaurora.org> wrote:
> Now all the cpu_hwcaps features have their own static keys. We don't
> need a separate function hyp_alternate_select() to patch the vhe/nvhe
> code. We can achieve the same functionality by using has_vhe(). It
> improves the code readability, uses the jump label instructions, and
> also compiler generates the better code with a fewer instructions.

How do you define "better"? Which compiler? Do you have any benchmarking data?

>
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>
> ---
> v2: removed 'Change-Id: Ia8084189833f2081ff13c392deb5070c46a64038' from commit
>
>  arch/arm64/kvm/hyp/debug-sr.c  | 12 ++++++----
>  arch/arm64/kvm/hyp/switch.c    | 50 +++++++++++++++++++-----------------------
>  arch/arm64/kvm/hyp/sysreg-sr.c | 23 +++++++++----------
>  3 files changed, 43 insertions(+), 42 deletions(-)
>
> diff --git a/arch/arm64/kvm/hyp/debug-sr.c b/arch/arm64/kvm/hyp/debug-sr.c
> index f5154ed..e5642c2 100644
> --- a/arch/arm64/kvm/hyp/debug-sr.c
> +++ b/arch/arm64/kvm/hyp/debug-sr.c
> @@ -109,9 +109,13 @@ static void __hyp_text __debug_save_spe_nvhe(u64 *pmscr_el1)
>  	dsb(nsh);
>  }
>  
> -static hyp_alternate_select(__debug_save_spe,
> -			    __debug_save_spe_nvhe, __debug_save_spe_vhe,
> -			    ARM64_HAS_VIRT_HOST_EXTN);
> +static void __hyp_text __debug_save_spe(u64 *pmscr_el1)
> +{
> +	if (has_vhe())
> +		__debug_save_spe_vhe(pmscr_el1);
> +	else
> +		__debug_save_spe_nvhe(pmscr_el1);
> +}

I have two worries about this kind of thing:
- Not all compilers do support jump labels, leading to a memory access
on each static key (GCC 4.8, for example). This would immediately
introduce a pretty big regression
- The hyp_alternate_select() method doesn't introduce a fast/slow path
duality. Each path has the exact same cost. I'm not keen on choosing
what is supposed to be the fast path, really.

Thanks,

	M.
-- 
Jazz is not dead, it just smell funny.
