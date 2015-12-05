From: peter@hurleysoftware.com (Peter Hurley)
Date: Sat, 5 Dec 2015 12:49:07 -0500
Subject: [PATCH LINUX v3 00/10] tty: xuartps: Fix lock ups
In-Reply-To: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1448161172-19717-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <56632393.8090809@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2015 09:59 PM, Soren Brinkmann wrote:
> Hi,
> 
> here is v3 of this series. It's largely the same as before, but I
> adjusted 'tty: xuartps: Don't consider circular buffer when enabling
> transmitter' according to Peter's suggestions.

In reviewing this series, I thought the _OFFSET suffix for every register
address to be excessive. I would refactor all that out; IOW,

-	isrstatus = readl(port->membase + CDNS_UART_ISR_OFFSET);
+	isrstatus = readl(port->membase + CDNS_UART_ISR);


> I also spent some time trying to get Peter's test for flow control and
> xchar running. The xchar thing fails and will need some more work, but I
> think in general it should be possible to get it to work.
> The flow control test passes:
> 
> root at Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS0
> Test flow control on /dev/ttyPS0
> begin test1
> patterns sent: 223  recvd: 208
> read distribution: 1   = 0
>                    2+  = 0
>                    4+  = 0
>                    8+  = 0
>                   16+  = 0
>                   32+  = 643
>                   64+  = 0
>                  128+  = 0
>                  256+  = 0
>                  512+  = 0
> PASSED

This distribution looks like this exactly because the xchar test is
failing. IOW, this driver isn't performing soft flow control (^S,^Q)
like it should.

Regards,
Peter Hurley

> root at Xilinx-ZC1751-DC1:~# ./flow /dev/ttyPS1
> Test flow control on /dev/ttyPS1
> begin test1
> patterns sent: 223  recvd: 208
> read distribution: 1   = 0
>                    2+  = 0
>                    4+  = 0
>                    8+  = 0
>                   16+  = 0
>                   32+  = 643
>                   64+  = 0
>                  128+  = 0
>                  256+  = 0
>                  512+  = 0
> PASSED
> 
> 	S?ren
> 
> S?ren Brinkmann (10):
>   tty: xuartps: Beautify read-modify writes
>   tty: xuartps: Use spinlock to serialize HW access
>   tty: xuartps: Don't consider circular buffer when enabling transmitter
>   tty: xuartps: Clear interrupt status register in shutdown
>   tty: xuartps: Improve startup function
>   tty: xuartps: Keep lock for whole ISR
>   tty: xuartps: Acquire port lock for shutdown
>   tty: xuartps: Move RX path into helper function
>   tty: xuartps: Only handle RX IRQs when RX is enabled
>   tty: xuartps: Cleanup: Reformat if-else
> 
>  drivers/tty/serial/xilinx_uartps.c | 246 +++++++++++++++++++++----------------
>  1 file changed, 137 insertions(+), 109 deletions(-)
> 
