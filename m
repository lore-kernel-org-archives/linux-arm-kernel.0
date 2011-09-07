From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 7 Sep 2011 16:41:32 +0100
Subject: [PATCH 03/11] ARM: pm: some ARMv7 requires a dsb in resume to
	ensure correctness
In-Reply-To: <E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
	<E1Qz6hr-00078J-2k@rmk-PC.arm.linux.org.uk>
Message-ID: <CAHkRjk65O3wJLazxZeOOQrDuM-XkZXo4fcOuVZf4Jzq9OP3p3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1 September 2011 13:49, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> Add a dsb after the isb to ensure that the previous writes to the
> CP15 registers take effect before we enable the MMU.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> ---
> ?arch/arm/mm/proc-v7.S | ? ?1 +
> ?1 files changed, 1 insertions(+), 0 deletions(-)
>
> diff --git a/arch/arm/mm/proc-v7.S b/arch/arm/mm/proc-v7.S
> index dec72ee..a773f4e 100644
> --- a/arch/arm/mm/proc-v7.S
> +++ b/arch/arm/mm/proc-v7.S
> @@ -255,6 +255,7 @@ ENTRY(cpu_v7_do_resume)
> ? ? ? ?mcr ? ? p15, 0, r4, c10, c2, 0 ?@ write PRRR
> ? ? ? ?mcr ? ? p15, 0, r5, c10, c2, 1 ?@ write NMRR
> ? ? ? ?isb
> + ? ? ? dsb

Isn't an ISB enough here? We usually have the DSB for some background
operations like cache maintenance.

-- 
Catalin
