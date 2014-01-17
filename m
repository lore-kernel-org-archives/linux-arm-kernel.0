From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 17 Jan 2014 17:13:07 +0100
Subject: [PATCH] dma: Add Xilinx AXI Video Direct Memory Access Engine
 driver support
In-Reply-To: <1389894803-4147-2-git-send-email-sthokal@xilinx.com>
References: <1389894803-4147-1-git-send-email-sthokal@xilinx.com>
 <1389894803-4147-2-git-send-email-sthokal@xilinx.com>
Message-ID: <201401171713.08550.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 16 January 2014, Srikanth Thokala wrote:
> @@ -0,0 +1,71 @@
> +Xilinx AXI VDMA engine, it does transfers between memory and video devices.
> +It can be configured to have one channel or two channels. If configured
> +as two channels, one is to transmit to the video device and another is
> +to receive from the video device.
> +
> +Required properties:
> +- compatible: Should be "xlnx,axi-vdma-1.00.a"
> +- #dma-cells: Should be <1>, see "dmas" property below
> +- reg: Should contain VDMA registers location and length.
> +- interrupts: Should contain per channel VDMA interrupts.
> +- compatible (child node): It should be either "xlnx,axi-vdma-mm2s-channel" or
> +       "xlnx,axi-vdma-s2mm-channel". It depends on the hardware design and it
> +       can also have both channels.
> +- xlnx,device-id: Should contain device number in each channel. It should be
> +       {0,1,2...so on} to the number of VDMA devices configured in hardware.
> +- xlnx,num-fstores: Should be the number of framebuffers as configured in h/w.
> +- xlnx,data-width: Should contain the stream data width, takes {32,64...so on}.
> +- xlnx,flush-fsync: (Optional) Tells whether which channel to Flush on Fsync.
> +       It takes following values:
> +       {1}, flush both channels
> +       {2}, flush mm2s channel
> +       {3}, flush s2mm channel
> +- xlnx,include-sg: (Optional) Tells whether configured for Scatter-mode in
> +       the hardware.
> +- xlnx,include-dre: (Optional) Tells whether hardware is configured for Data
> +       Realignment Engine.
> +- xlnx,genlock-mode: (Optional) Tells whether Genlock synchornisation is
> +       enabled/disabled in hardware.

The documentation doesn't seem to match the example, since you don't mention
the fact that the channels have separate nodes here, or which properties
are meant for the parent or the child node. Also, some of the "required"
properties are absent in the example, which makes no sense.

I also assume that some of the properties should just go away:

* xlnx,device-id should be the argument in the handle from the slave device
* data width should be a property of the slave driver that is configured
  through dma_slave_config(), unless you can have dma engines that only
  support certain a width.

	Arnd
