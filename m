From: Thomas.Betker@rohde-schwarz.com (Thomas.Betker at rohde-schwarz.com)
Date: Mon, 13 Jul 2015 12:04:54 +0200
Subject: [RFC PATCH 0/2] spi: add dual parallel & stacked mode support
 in Zynq MPSoC GQSPI controller
In-Reply-To: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
References: <1436445895-25504-1-git-send-email-ranjit.waghmode@xilinx.com>
Message-ID: <OFDDDA0AA7.A583461A-ONC1257E81.0030FCED-C1257E81.003761EE@rohde-schwarz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Ranjit:

> What is dual parallel mode?
> ---------------------------
> ZynqMP GQSPI controller supports Dual Parallel mode with following 
> functionalities:
> 1) Supporting two SPI flash memories operating in parallel. 8 I/O lines.
> 2) Chip selects and clock are shared to both the flash devices
> 3) This mode is targeted for faster read/write speed and also doubles 
the size
> 4) Commands/data can be transmitted/received from both the 
devices(mirror),
>    or only upper or only lower flash memory devices.
> 5) Data arrangement:
>    With stripe enabled,
>    Even bytes i.e. 0, 2, 4,... are transmitted on Lower Data Bus
>    Odd bytes i.e. 1, 3, 5,.. are transmitted on Upper Data Bus.

In the dual-parallel configuration, odd and even _bits_ of each byte are 
distributed over the flash chips; I am assuming this works just as in Zynq 
QSPI (apparently, the TRM for ZynqMP isn't out yet).

Striping seems to be a different mechanism, though. Can you explain it a 
bit more? Also, the wording seems to indicate that it belongs to 
dual-stacked rather than dual-parallel.

> Suggestions on MTD layer support
> --------------------------------
> In order to add above two specified modes, we may required to get some
> support from MTD layer.
> 
> I'm trying to list the dependencies as follows:
> 1) Support for two flashes
> 2) Enable/Disable data stripe as and when required.
> 3) May need to update read_sr() to get status of both flashes
> 4) May also need to update read_fsr() to get status of both flashes
> 5) Adjustment of offset value based on the parallel/stacked mode 
configuration
> 6) Setting either parallel or stacked mode during the scan process.
> 7) In case of stacked mode, is there a MTD concatenation support?

In addition to 5), the MTD driver using a dual-parallel QSPI flash has to
5a) add padding at the start of data for unaligned addresses,
5b) add padding at the end of data for unaligned lengths.

Best regards,
Thomas Betker
