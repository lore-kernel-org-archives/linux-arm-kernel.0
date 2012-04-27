From: b32955@freescale.com (Huang Shijie)
Date: Fri, 27 Apr 2012 15:00:39 +0800
Subject: [PATCH 1/2] serial/imx: add DMA support
In-Reply-To: <20120426111116.GF24211@n2100.arm.linux.org.uk>
References: <1335436632-29499-1-git-send-email-b32955@freescale.com>
 <1335436632-29499-2-git-send-email-b32955@freescale.com>
 <20120426111116.GF24211@n2100.arm.linux.org.uk>
Message-ID: <4F9A4417.7080107@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?04?26? 19:11, Russell King - ARM Linux ??:
> On Thu, Apr 26, 2012 at 06:37:11PM +0800, Huang Shijie wrote:
>> Add the DMA support for uart RX and TX.
>>
>> Signed-off-by: Huang Shijie<b32955@freescale.com>
>> ---
> Apart from the comments below,
>
> 1. How do you deal with transmitting the high-priority XON/XOFF
>     characters (port->x_char) which occur with s/w flow control and
>     the tty buffers fill up?
> 2. How do you deal with flow control in general?  IOW, what happens
>     when the remote end deasserts your CTS with h/w flow control enabled.
>     How does your end deal with sending RTS according to flow control
>     conditions?
>
> i
The UART uses the DMA for RX/TX with the hardware flow control (RTS/CTS) 
enabled all the time.
If we use the software flow control(XON/XOFF), we should not enable the DMA.
I think i should add more comments about this issue.

For example:
The MX6Q arm2 has two uarts, one with the DMA disabled is used for debug,
the other one with the DMA/RTS.CTS enabled can be used for the Bluetooth.
>>   .../bindings/tty/serial/fsl-imx-uart.txt           |    7 +
>>   drivers/tty/serial/imx.c                           |  386 +++++++++++++++++++-
>>   2 files changed, 389 insertions(+), 4 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> index a9c0406..f27489d 100644
>> --- a/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> +++ b/Documentation/devicetree/bindings/tty/serial/fsl-imx-uart.txt
>> @@ -8,6 +8,10 @@ Required properties:
>>   Optional properties:
>>   - fsl,uart-has-rtscts : Indicate the uart has rts and cts
>>   - fsl,irda-mode : Indicate the uart supports irda mode
>> +- fsl,enable-dma : Indicate the uart supports DMA
>> +- fsl,uart-dma-events : contains the DMA events for RX and TX,
>> +	          The first is the RX event, while the other is TX.
>> +- fsl,enable-dte: Indicate the uart works in DTE mode
>>
>>   Example:
>>
>> @@ -16,4 +20,7 @@ uart at 73fbc000 {
>>   	reg =<0x73fbc000 0x4000>;
>>   	interrupts =<31>;
>>   	fsl,uart-has-rtscts;
>> +	fsl,enable-dma;
>> +	fsl,uart-dma-events =<xx xx>;
>> +	fsl,enable-dte;
>>   };
>> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
>> index e7fecee..65ba24d 100644
>> --- a/drivers/tty/serial/imx.c
>> +++ b/drivers/tty/serial/imx.c
>> @@ -47,9 +47,11 @@
>>   #include<linux/slab.h>
>>   #include<linux/of.h>
>>   #include<linux/of_device.h>
>> +#include<linux/dma-mapping.h>
>>
>>   #include<asm/io.h>
>>   #include<asm/irq.h>
>> +#include<mach/dma.h>
>>   #include<mach/imx-uart.h>
>>
>>   /* Register definitions */
>> @@ -82,6 +84,7 @@
>>   #define  UCR1_ADBR       (1<<14) /* Auto detect baud rate */
>>   #define  UCR1_TRDYEN     (1<<13) /* Transmitter ready interrupt enable */
>>   #define  UCR1_IDEN       (1<<12) /* Idle condition interrupt */
>> +#define  UCR1_ICD_REG(x) (((x)&  3)<<  10) /* idle condition detect */
>>   #define  UCR1_RRDYEN     (1<<9)	 /* Recv ready interrupt enable */
>>   #define  UCR1_RDMAEN     (1<<8)	 /* Recv ready DMA enable */
>>   #define  UCR1_IREN       (1<<7)	 /* Infrared interface enable */
>> @@ -125,6 +128,7 @@
>>   #define  UCR4_ENIRI 	 (1<<8)  /* Serial infrared interrupt enable */
>>   #define  UCR4_WKEN  	 (1<<7)  /* Wake interrupt enable */
>>   #define  UCR4_REF16 	 (1<<6)  /* Ref freq 16 MHz */
>> +#define  UCR4_IDDMAEN    (1<<6)  /* DMA IDLE Condition Detected */
>>   #define  UCR4_IRSC  	 (1<<5)  /* IR special case */
>>   #define  UCR4_TCEN  	 (1<<3)  /* Transmit complete interrupt enable */
>>   #define  UCR4_BKEN  	 (1<<2)  /* Break condition interrupt enable */
>> @@ -134,6 +138,7 @@
>>   #define  UFCR_RFDIV      (7<<7)  /* Reference freq divider mask */
>>   #define  UFCR_RFDIV_REG(x)	(((x)<  7 ? 6 - (x) : 6)<<  7)
>>   #define  UFCR_TXTL_SHF   10      /* Transmitter trigger level shift */
>> +#define  UFCR_DCEDTE	 (1<<6)
>>   #define  USR1_PARITYERR  (1<<15) /* Parity error interrupt flag */
>>   #define  USR1_RTSS  	 (1<<14) /* RTS pin status */
>>   #define  USR1_TRDY  	 (1<<13) /* Transmitter ready interrupt/dma flag */
>> @@ -200,12 +205,27 @@ struct imx_port {
>>   	unsigned int		old_status;
>>   	int			txirq,rxirq,rtsirq;
>>   	unsigned int		have_rtscts:1;
>> +	unsigned int		enable_dte:1;
>> +	unsigned int		enable_dma:1;
>>   	unsigned int		use_irda:1;
>>   	unsigned int		irda_inv_rx:1;
>>   	unsigned int		irda_inv_tx:1;
>>   	unsigned short		trcv_delay; /* transceiver delay */
>>   	struct clk		*clk;
>>   	struct imx_uart_data	*devdata;
>> +
>> +	/* DMA fields */
>> +	unsigned int		dma_req_rx;
>> +	unsigned int		dma_req_tx;
>> +	struct imx_dma_data	dma_data;
>> +	struct dma_chan		*dma_chan_rx, *dma_chan_tx;
>> +	struct scatterlist	rx_sgl, tx_sgl[2];
>> +	void			*rx_buf;
>> +	unsigned int		rx_bytes, tx_bytes;
>> +	struct work_struct	tsk_dma_rx, tsk_dma_tx;
> Why do you need a work struct to deal with DMA?
>
The uart uses the SDMA (drivers/dma/imx-sdma.c). And the SDMA may 
schedule out in :
sdma_prep_slave_sg() --> sdma_load_contex() -->sdma_run_channel() .

So i have to add a work struct to prepare and triger the DMA operations.
>> +	unsigned int		dma_tx_nents;
>> +	bool			dma_is_rxing;
>> +	wait_queue_head_t	dma_wait;
>>   };
>>
>>   struct imx_port_ucrs {
>> @@ -394,6 +414,13 @@ static void imx_stop_rx(struct uart_port *port)
>>   	struct imx_port *sport = (struct imx_port *)port;
>>   	unsigned long temp;
>>
>> +	/*
>> +	 * We are maybe in the SMP now, so if the DMA RX thread is running,
>> +	 * we have to wait for it to finish.
>> +	 */
>> +	if (sport->enable_dma&&  sport->dma_is_rxing)
>> +		return;
>> +
>>   	temp = readl(sport->port.membase + UCR2);
>>   	writel(temp&~ UCR2_RXEN, sport->port.membase + UCR2);
>>   }
>> @@ -429,6 +456,80 @@ static inline void imx_transmit_buffer(struct imx_port *sport)
>>   		imx_stop_tx(&sport->port);
>>   }
>>
>> +static void dma_tx_callback(void *data)
>> +{
>> +	struct imx_port *sport = data;
>> +	struct scatterlist *sgl =&sport->tx_sgl[0];
> 	struct scatterlist *sgl = sport->tx_sgl;
>
> is equivalent, and less typing.
>
>> +	struct circ_buf *xmit =&sport->port.state->xmit;
>> +
>> +	dma_unmap_sg(sport->port.dev, sgl, sport->dma_tx_nents, DMA_TO_DEVICE);
>> +
>> +	/* update the stat */
>> +	spin_lock(&sport->port.lock);
>> +	xmit->tail = (xmit->tail + sport->tx_bytes)&  (UART_XMIT_SIZE - 1);
>> +	sport->port.icount.tx += sport->tx_bytes;
>> +	spin_unlock(&sport->port.lock);
> Callbacks are called from tasklet context, and will have IRQs enabled.
> As the port lock is taken from IRQ context, this is waiting for a deadlock
> to happen.  Have you run this with lockdep enabled?
>
This callback is called from IRQ context, with all the IRQ disabled. see:
sdma_int_handler() -->mxc_sdma_handle_channel() --> 
mxc_sdma_handle_channel_normal()
--> .callback().

So spin_lock() is enough.

Best Regards
Huang Shijie
