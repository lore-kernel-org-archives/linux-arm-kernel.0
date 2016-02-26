From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 26 Feb 2016 14:55:17 +0000
Subject: [PATCH v3] arm64: mm: Mark .rodata as RO
In-Reply-To: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
References: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
Message-ID: <20160226145516.GE8728@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 19, 2016 at 11:50:32AM -0600, Jeremy Linton wrote:
> Currently the .rodata section is actually still executable when DEBUG_RODATA
> is enabled. This changes that so the .rodata is actually read only, no execute.
> It also adds the .rodata section to the mem_init banner.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/vmlinux.lds.S |  5 +++--
>  arch/arm64/mm/init.c            |  4 +++-
>  arch/arm64/mm/mmu.c             | 17 +++++++++++++----
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 8f4fc2c..9208f53 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -114,8 +114,9 @@ SECTIONS
>  		*(.got)			/* Global offset table		*/
>  	}
>  
> -	RO_DATA(PAGE_SIZE)
> -	EXCEPTION_TABLE(8)
> +	ALIGN_DEBUG_RO_MIN(0)
> +	RO_DATA(PAGE_SIZE)		/* everything from this point to */
> +	EXCEPTION_TABLE(8)		/* _etext will be marked RO NX   */
>  	NOTES

That should be ALIGN_DEBUG_RO_MIN(PAGE_SIZE), given we map .text and
.rodata separately regardless of DEBUG_RODATA (and hence they need to
never share a page).

You'll get away with it, since RO_DATA forces PAGE_SIZE alignment for
__start_rodata, but for consistency that should be fixed up.

With that:

Acked-by: Mark Rutland <mark.rutland@arm.com>

Catalin, I assume you can fix that up locally?

Mark.
