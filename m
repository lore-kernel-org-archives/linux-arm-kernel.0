From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 May 2015 09:52:32 +0100
Subject: [PATCH 1/1] arm64:lib: Use Linaro's memset routine to avoid DC
 instruction
In-Reply-To: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
References: <1431062602-1894-1-git-send-email-jliang@xilinx.com>
Message-ID: <20150508085232.GB2125@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 08, 2015 at 06:23:22AM +0100, Wendy Liang wrote:
> From: Jason Wu <j.wu@xilinx.com>
> 
> Currently the DC ZVA is used to zero out memory which is causing unaligned
> fault due to the follows:
> "If the memory region being zeroed is any type of Device memory, these
> instructions give an alignment fault which is prioritized in the same way
> as other alignment faults that are determined by the memory type."
> from arm reference menual.

[...]

> We have carved out top memory from DDR as the memory for the device from DTS:
> ----
> reserved-memory {
>                 #address-cells = <2>;
>                 #size-cells = <1>;
>                 ranges;
>                 rproc_0_reserved: rproc at 3ed000000 {
>                         no-map;
>                         reg = <0x0 0x3ed00000 0x1000000>;
>                 };
>         };
> 
>  amba {
>                 example at 0 {
>                         reg = <0x0 0x3ed00000 0x800000>;
>                         ...
>                 };
> };
> ----
> We use dma_coherent_declare_memory() to declare the memory for DMA operations.
> We use memset() initialize the memory with 0.
> memset calls dc zva to zeroing the memory however it thinks the memory
> is not part of system (somehow even it is part of DDR) and causing
> unalignment fault.

Why isn't the buffer mapped as normal, non-cacheable? Device memory also
doesn't support things like unaligned access, so really DC ZVA is the canary
in the coal mine.

Will
