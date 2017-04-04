From: bevenson@melinkcorp.com (Bryan Evenson)
Date: Tue, 4 Apr 2017 20:28:34 +0000
Subject: at91: serial: Can't use DMA on 4.x kernels in RS-485 mode on
 at91sam9x5
Message-ID: <DM5PR05MB2954D56C2E266AF16B250ACCBB0B0@DM5PR05MB2954.namprd05.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All,

I've been using the latest commit of the linux-3.10-at91 branch of Atmel's Linux fork at https://github.com/linux4sam/linux-at91 for my AT91SAM9G25.  I'm using three serial ports in RS-485 mode.  I'm working on upgrading to a more recent kernel and I'm having issues using DMA for these three serial ports.  I'm looking for some guidance as to what may be going wrong.

First, my board is very closely modeled after the AT91SAMG25-EK, so I'm able to use the at91sam9x5 device tree files with just a few modifications.  Here are my relevant device tree settings for the three USARTs in arch/arm/boot/dts/at91sam9x5ek.dtsi.

			usart0: serial at f801c000 {
				pinctrl-0 = <&pinctrl_usart0
					&pinctrl_usart0_rts
					&pinctrl_usart0_cts>;
					rs485-rts-delay = <15 1>;
					linux,rs485-enabled-at-boot-time;
					atmel,use-dma-rx;
					atmel,use-dma-tx;
				status = "okay";
			};

			usart1: serial at f8020000 {
				pinctrl-0 = <&pinctrl_usart1
					&pinctrl_usart1_rts
					&pinctrl_usart1_cts>;
					rs485-rts-delay = <15 1>;
					linux,rs485-enabled-at-boot-time;
					atmel,use-dma-rx;
					atmel,use-dma-tx;
				status = "okay";
			};

			usart3: serial at f8028000 {
				pinctrl-0 = <&pinctrl_usart3
					&pinctrl_usart3_rts
					&pinctrl_usart3_cts>;
					rs485-rts-delay = <15 1>;
					linux,rs485-enabled-at-boot-time;
					atmel,use-dma-rx;
					atmel,use-dma-tx;
				status = "okay";
			};

With the 3.10 kernel, I had to use the TX DMA only.  For some reason receive wouldn't work for me with the DMA.  Now with the latest on the linux-4.4-at91 branch I can't use the TX DMA.  The data is transmitted correctly out the USART (verified on a receiving device), but then the return message is not received.  I verified the same results when both RX&TX DMA was enabled and only when the TX DMA was enabled.  If I use only the RX DMA, everything works fine if I have only one device on the RS-485 port.  As soon as I daisy chain more than one device on an RS-485 port, then I start dropping messages.  If I turn off both the RX and TX DMA, then all data transfers work just fine.

I'd like to get both TX and RX DMA working for all three RS-485 ports.  Anyone have any suggestions for what to look at to get DMA working while in RS-485 mode?  I'm planning to start trying a git bisect, but given these are different branches I wasn't sure how well that was going to work.

Thanks,
Bryan
