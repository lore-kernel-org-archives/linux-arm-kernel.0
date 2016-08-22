From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Aug 2016 18:56:07 +0100
Subject: [PATCH v5 2/3] arm64: vmlinux.ld: Add mmuoff text and data
 sections
In-Reply-To: <1471887319-26702-3-git-send-email-james.morse@arm.com>
References: <1471887319-26702-1-git-send-email-james.morse@arm.com>
 <1471887319-26702-3-git-send-email-james.morse@arm.com>
Message-ID: <20160822175606.GH26494@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 22, 2016 at 06:35:18PM +0100, James Morse wrote:
> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
> index 659963d40bb4..97c3f36ce30b 100644
> --- a/arch/arm64/kernel/vmlinux.lds.S
> +++ b/arch/arm64/kernel/vmlinux.lds.S
> @@ -120,6 +120,9 @@ SECTIONS
>  			IRQENTRY_TEXT
>  			SOFTIRQENTRY_TEXT
>  			ENTRY_TEXT
> +			__mmuoff_text_start = .;
> +			*(.mmuoff.text)
> +			__mmuoff_text_end = .;
>  			TEXT_TEXT
>  			SCHED_TEXT
>  			LOCK_TEXT
> @@ -185,6 +188,24 @@ SECTIONS
>  	_data = .;
>  	_sdata = .;
>  	RW_DATA_SECTION(L1_CACHE_BYTES, PAGE_SIZE, THREAD_SIZE)
> +
> +	/*
> +	 * Data written with the MMU off but read with the MMU on requires
> +	 * cache lines to be invalidated, discarding up to a Cache Writeback
> +	 * Granule (CWG) of data from the cache. Keep the section that
> +	 * requires this type of maintenance to be in its own Cache Writeback
> +	 * Granule (CWG) area so the cache maintenance operations don't
> +	 * don't interfere with adjacent data.
> +	 */

Nitpick: you have "don't" twice in the comment above.

-- 
Catalin
