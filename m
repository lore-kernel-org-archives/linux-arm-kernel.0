From: michal.simek@xilinx.com (Michal Simek)
Date: Fri, 12 Jun 2015 11:25:17 +0200
Subject: [PATCH v2] ARM: zynq: Fix earlyprintk in big endian mode
In-Reply-To: <1434092004-21385-1-git-send-email-achandran@mvista.com>
References: <1433945584-16379-1-git-send-email-achandran@mvista.com>
 <1434092004-21385-1-git-send-email-achandran@mvista.com>
Message-ID: <557AA57D.1010104@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/12/2015 08:53 AM, Arun Chandran wrote:
> earlyprintk messages are not appearing on the terminal
> emulator during a big endian kernel boot. In BE mode
> sending full words to UART will result in unprintable
> characters as they are byte swapped versions of printable
> ones. So send only bytes.
> 
> Signed-off-by: Arun Chandran <achandran@mvista.com>
> ---
> ---
> Changes since v1:
> 	removed the byte swapping logic. Just send characters instead.
> ---
>  arch/arm/include/debug/zynq.S | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/include/debug/zynq.S b/arch/arm/include/debug/zynq.S
> index bd13ded..de86b92 100644
> --- a/arch/arm/include/debug/zynq.S
> +++ b/arch/arm/include/debug/zynq.S
> @@ -38,7 +38,7 @@
>  		.endm
>  
>  		.macro	senduart,rd,rx
> -		str	\rd, [\rx, #UART_FIFO_OFFSET]	@ TXDATA
> +		strb	\rd, [\rx, #UART_FIFO_OFFSET]	@ TXDATA
>  		.endm
>  
>  		.macro	waituart,rd,rx
> 

ok - this works too.

Tested-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
