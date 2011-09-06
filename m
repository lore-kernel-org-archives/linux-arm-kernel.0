From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 06 Sep 2011 14:45:04 -0400 (EDT)
Subject: [PATCH 4.5/6] ARM: omap: pass phys,
	virt and lsr from uncompress.h to debug-macro.S
In-Reply-To: <20110905150758.GG1903@atomide.com>
References: <1314932353-24813-1-git-send-email-nico@fluxnic.net>
	<1314932353-24813-5-git-send-email-nico@fluxnic.net>
	<20110905150758.GG1903@atomide.com>
Message-ID: <alpine.LFD.2.00.1109061440590.20358@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Sep 2011, Tony Lindgren wrote:

> Earlier code passed the serial port configuration number as the
> code originally used the scratchpad register in the serial port
> to pass it from uncompress.h to debug-macro.S. This is no longer
> the case as some omaps don't have a serial port. A memory address
> is used instead.
> 
> Change the code to pass phys, virt and lsr from uncompress.h
> to debug-macro.S. Note that the virt value is only used on zoom
> boards that have an external 8250 hardware.
> 
> This will make it possible to combine omap1 and omap2+ debug-macro.S.
> 
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> 
[...]
> 
>  	u32 ram_start = (u32)&uart_shift & 0xf8000000;
>  	u32 *uart_info = (u32 *)(ram_start + OMAP_UART_INFO_OFS);
> -	*uart_info = port;
> +	*uart_info = (u32)uart_base;
> +	uart_info++;
> +	*uart_info = (u32)uart_virt;
> +	uart_info++;
> +	*uart_info = UART_LSR << uart_shift;

Whouldn't this be clearer as:

	uart_info[0] = (u32)uart_base;
	uart_info[1] = (u32)uart_virt;
	uart_info[2] = UART_LSR << uart_shift;

?


Nicolas
