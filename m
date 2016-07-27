From: bharat.kumar.gogada@xilinx.com (Bharat Kumar Gogada)
Date: Wed, 27 Jul 2016 06:33:29 +0000
Subject: Why does BIOS assign memory to 16 byte BAR
In-Reply-To: <CAE9FiQWaFAD0+biMmnKqSQ2K4AdRJJmeEZ=ASSsvEgiDsKAP6Q@mail.gmail.com>
References: <8520D5D51A55D047800579B094147198258BB59B@XAP-PVEXMBX01.xlnx.xilinx.com>
 <20160722151546.GA20646@localhost> <20160722155133.GB20646@localhost>
 <8520D5D51A55D047800579B094147198258BC23C@XAP-PVEXMBX01.xlnx.xilinx.com>
 <8520D5D51A55D047800579B094147198258BC2BB@XAP-PVEXMBX01.xlnx.xilinx.com>
 <CAE9FiQWaFAD0+biMmnKqSQ2K4AdRJJmeEZ=ASSsvEgiDsKAP6Q@mail.gmail.com>
Message-ID: <8520D5D51A55D047800579B094147198258BC5E3@XAP-PVEXMBX01.xlnx.xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Your system host bridge: has resource
> pci_bus 0000:00: root bus resource [mem 0xe0100000-0xefffffff] pci_bus
> 0000:00: root bus resource [mem 0x600000000-0x7ffffffff pref] then one pci
> bridge:
> pci 0000:00:00.0
> then 0000:01:00.0 have four bars:
> pci 0000:01:00.0: BAR 0:  [mem size 0x40000000] pci 0000:01:00.0: BAR 4:
> [mem size 0x00100000 64bit] pci 0000:01:00.0: BAR 2:  [mem size 0x00000010]
> pci 0000:01:00.0: BAR 3:  [mem size 0x00000010]
> 
> 
> kernel need to get allocation for pci 0000:00:00.0 at first
> 
> but can not find big enough space.
> 
> pci 0000:00:00.0: BAR 8: no space for [mem size 0x60000000] as it should
> come from [mem 0xe0100000-0xefffffff], and that is less 1.5G.
> 
> so all children resource from pci 0000:01:00.0 all fail.
> 
> 
> please check if you modify your FPGA code to make pci 0000:01:00.0
> 
> BAR 0, and BAR 4 to use 64bit pref instead non-pref mmio.
> 
> or you can check if can increase root bus mmio range
> 
>  MEM 0xe0100000..0xefffffff -> 0xe0100000 nwl-pcie fd0e0000.pcie: PCI host
> bridge to bus 0000:00
> 
> to have more than 1.5G.
> 
Thanks Yinghai Lu.
We see that similar test is passing in x86 machine, where function one requesting 1GB BAR's is failing,
but function two requesting BAR's with 16byte is getting assigned BAR's.

To my knowledge on x86 BIOS assigns resources, or will kernel assign reosurces on x86 ?
If kernel does is there any difference between x86 and arm64 resource assignment logic ?

Thanks & Regards,
Bharat

  
