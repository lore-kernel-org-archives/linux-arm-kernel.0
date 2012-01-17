From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2012 23:13:14 +0000
Subject: [PATCH] RFC: spi/sa1100: rewrite the SA1100 SPI driver
In-Reply-To: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
References: <1326841236-25178-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20120117231314.GA1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 18, 2012 at 12:00:36AM +0100, Linus Walleij wrote:
> diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
> index bae8296..ed68746 100644
> --- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
> +++ b/arch/arm/mach-sa1100/include/mach/SA-1100.h
> @@ -727,86 +727,10 @@
>  #define MCCR1_F10MHz	(MCCR1_CFS*1)	/*  Freq. (fmc) = ~ 10 MHz         */
>                  	        	/*  (9.585 MHz)                    */
>  
> -
> -/*
> - * Synchronous Serial Port (SSP) control registers
> - *
> - * Registers
> - *    Ser4SSCR0 	Serial port 4 Synchronous Serial Port (SSP) Control
> - *              	Register 0 (read/write).
> - *    Ser4SSCR1 	Serial port 4 Synchronous Serial Port (SSP) Control
> - *              	Register 1 (read/write).
> - *              	[Bits SPO and SP are only implemented in versions 2.0
> - *              	(rev. = 8) and higher of the StrongARM SA-1100.]
> - *    Ser4SSDR  	Serial port 4 Synchronous Serial Port (SSP) Data
> - *              	Register (read/write).
> - *    Ser4SSSR  	Serial port 4 Synchronous Serial Port (SSP) Status
> - *              	Register (read/write).
> - *
> - * Clocks
> - *    fxtl, Txtl	Frequency, period of the system crystal (3.6864 MHz
> - *              	or 3.5795 MHz).
> - *    fss, Tss  	Frequency, period of the SSP communication.
> - */
> -
> -#define Ser4SSCR0	__REG(0x80070060)  /* Ser. port 4 SSP Control Reg. 0 */
> -#define Ser4SSCR1	__REG(0x80070064)  /* Ser. port 4 SSP Control Reg. 1 */
> -#define Ser4SSDR	__REG(0x8007006C)  /* Ser. port 4 SSP Data Reg. */
> -#define Ser4SSSR	__REG(0x80070074)  /* Ser. port 4 SSP Status Reg. */
> -
> -#define SSCR0_DSS	Fld (4, 0)	/* Data Size - 1 Select [3..15]    */
> -#define SSCR0_DataSize(Size)    	/*  Data Size Select [4..16]       */ \
> -                	(((Size) - 1) << FShft (SSCR0_DSS))
> -#define SSCR0_FRF	Fld (2, 4)	/* FRame Format                    */
> -#define SSCR0_Motorola	        	/*  Motorola Serial Peripheral     */ \
> -                	        	/*  Interface (SPI) format         */ \
> -                	(0 << FShft (SSCR0_FRF))
> -#define SSCR0_TI	        	/*  Texas Instruments Synchronous  */ \
> -                	        	/*  Serial format                  */ \
> -                	(1 << FShft (SSCR0_FRF))
> -#define SSCR0_National	        	/*  National Microwire format      */ \
> -                	(2 << FShft (SSCR0_FRF))
> -#define SSCR0_SSE	0x00000080	/* SSP Enable                      */
> -#define SSCR0_SCR	Fld (8, 8)	/* Serial Clock Rate divisor/2 - 1 */
> -                	        	/* fss = fxtl/(2*(SCR + 1))        */
> -                	        	/* Tss = 2*(SCR + 1)*Txtl          */
> -#define SSCR0_SerClkDiv(Div)    	/*  Serial Clock Divisor [2..512]  */ \
> -                	(((Div) - 2)/2 << FShft (SSCR0_SCR))
> -                	        	/*  fss = fxtl/(2*Floor (Div/2))   */
> -                	        	/*  Tss = 2*Floor (Div/2)*Txtl     */
> -#define SSCR0_CeilSerClkDiv(Div)	/*  Ceil. of SerClkDiv [2..512]    */ \
> -                	(((Div) - 1)/2 << FShft (SSCR0_SCR))
> -                	        	/*  fss = fxtl/(2*Ceil (Div/2))    */
> -                	        	/*  Tss = 2*Ceil (Div/2)*Txtl      */
> -
> -#define SSCR1_RIE	0x00000001	/* Receive FIFO 1/2-full or more   */
> -                	        	/* Interrupt Enable                */
> -#define SSCR1_TIE	0x00000002	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Interrupt Enable                */
> -#define SSCR1_LBM	0x00000004	/* Look-Back Mode                  */
> -#define SSCR1_SPO	0x00000008	/* Sample clock (SCLK) POlarity    */
> -#define SSCR1_SClkIactL	(SSCR1_SPO*0)	/*  Sample Clock Inactive Low      */
> -#define SSCR1_SClkIactH	(SSCR1_SPO*1)	/*  Sample Clock Inactive High     */
> -#define SSCR1_SP	0x00000010	/* Sample clock (SCLK) Phase       */
> -#define SSCR1_SClk1P	(SSCR1_SP*0)	/*  Sample Clock active 1 Period   */
> -                	        	/*  after frame (SFRM, 1st edge)   */
> -#define SSCR1_SClk1_2P	(SSCR1_SP*1)	/*  Sample Clock active 1/2 Period */
> -                	        	/*  after frame (SFRM, 1st edge)   */
> -#define SSCR1_ECS	0x00000020	/* External Clock Select           */
> -#define SSCR1_IntClk	(SSCR1_ECS*0)	/*  Internal Clock                 */
> -#define SSCR1_ExtClk	(SSCR1_ECS*1)	/*  External Clock (GPIO [19])     */
> -
> -#define SSDR_DATA	Fld (16, 0)	/* receive/transmit DATA FIFOs     */
> -
> -#define SSSR_TNF	0x00000002	/* Transmit FIFO Not Full (read)   */
> -#define SSSR_RNE	0x00000004	/* Receive FIFO Not Empty (read)   */
> -#define SSSR_BSY	0x00000008	/* SSP BuSY (read)                 */
> -#define SSSR_TFS	0x00000010	/* Transmit FIFO 1/2-full or less  */
> -                	        	/* Service request (read)          */
> -#define SSSR_RFS	0x00000020	/* Receive FIFO 1/2-full or more   */
> -                	        	/* Service request (read)          */
> -#define SSSR_ROR	0x00000040	/* Receive FIFO Over-Run           */
> -
> +/* The driver will contain the offsets for this peripheral */
> +#define Ser4SSBase	0x80070000
> +/* Ser. port 4 SSP Data Reg. needed by DMA defines */
> +#define Ser4SSDR_DMA	__REG(Ser4SSBase + 0x6C)
>  
>  /*
>   * Operating System (OS) timer control registers
> @@ -1789,10 +1713,10 @@
>                  	 DDAR_Ser4MCP1Rc + DDAR_DevAdd (__PREG(Ser4MCDR1)))
>  #define DDAR_Ser4SSPWr	        	/* Ser. port 4 SSP Write (16 bits) */ \
>                  	(DDAR_DevWr + DDAR_Brst4 + DDAR_16BitDev + \
> -                	 DDAR_Ser4SSPTr + DDAR_DevAdd (__PREG(Ser4SSDR)))
> +                	 DDAR_Ser4SSPTr + DDAR_DevAdd (__PREG(Ser4SSDR_DMA)))
>  #define DDAR_Ser4SSPRd	        	/* Ser. port 4 SSP Read (16 bits)  */ \
>                  	(DDAR_DevRd + DDAR_Brst4 + DDAR_16BitDev + \
> -                	 DDAR_Ser4SSPRc + DDAR_DevAdd (__PREG(Ser4SSDR)))
> +                	 DDAR_Ser4SSPRc + DDAR_DevAdd (__PREG(Ser4SSDR_DMA)))

Please don't delete the above definitions.

The SSP interface is more than just SPI (it's microwire and TI format,
and I have a working ASoC driver for the Assabet.)

In addition, I also have a DMA engine driver for the DMA stuff on SA1100,
which couples into a generic DMA engine ASoC platform driver (though only
for playback).

Oh, and a SA1100 IrDA driver converted to use the DMA engine stuff...

Patches will be posted after the merge window closes.
