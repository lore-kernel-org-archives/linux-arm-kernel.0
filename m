From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 6 Oct 2011 17:40:34 +0100
Subject: [RFC/PATCH 6/7] ARM: ARM11 MPCore: DMA_CACHE_RWFO operations
	are not preempt safe
In-Reply-To: <1317877714-11355-7-git-send-email-gdavis@mvista.com>
References: <05942148-7AFB-4755-A22F-355E0360B098@mvista.com>
	<1317877714-11355-1-git-send-email-gdavis@mvista.com>
	<1317877714-11355-7-git-send-email-gdavis@mvista.com>
Message-ID: <20111006164034.GB21464@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 06, 2011 at 01:08:33AM -0400, gdavis at mvista.com wrote:
>  v6_dma_inv_range:
>  #ifdef CONFIG_DMA_CACHE_RWFO
> +#ifdef CONFIG_PREEMPT
> +	stmdb	sp!, {r4, r10, r11}
> +	get_thread_info r10
> +	ldr	r4, [r10, #TI_PREEMPT]		@ get preempt count
> +	add	r11, r4, #1			@ increment it
> +	str	r11, [r10, #TI_PREEMPT]		@ disable preempt
> +#endif

r11 is the frame pointer.  On kernels built with the frame pointer
enabled, this register must either be a valid frame pointer or zero.

There's no reason to use r4, r10 and r11 here - you could use r4, r5
and ip (r12) - and then there's no need to save ip as that's allowed
to be corrupted by called functions.
