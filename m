From: grant.likely@secretlab.ca (Grant Likely)
Date: Mon, 19 Sep 2011 18:22:15 -0600
Subject: [PATCH 5/5] ARM: gic: add OF based initialization
In-Reply-To: <4E77B9E3.40004@gmail.com>
References: <1316017900-19918-1-git-send-email-robherring2@gmail.com>
	<1316017900-19918-6-git-send-email-robherring2@gmail.com>
	<CAJuYYwSFu2HC+u2NY41+yw9tEyy85RKa4Dpm3SL+jbwS_OOA0A@mail.gmail.com>
	<4E71CE5D.9030900@ti.com> <4E71F978.6020402@gmail.com>
	<4E72030F.1090300@ti.com>
	<4E722B2D.4050307@gmail.com> <4E76615C.3000005@gmail.com>
	<4E77310A.3000106@ti.com> <4E774847.3020104@gmail.com>
	<CACxGe6v9nd5f5x-eu9hUyAqdS1+p3h6ixyutECYLdNo3ewDH0w@mail.gmail.com>
	<4E77B9E3.40004@gmail.com>
Message-ID: <CACxGe6vrksxkEhsKm5zWG5P3g0wqOBxsM3yqtP4yk0Us-=EPWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2011 at 3:53 PM, Rob Herring <robherring2@gmail.com> wrote:
> On 09/19/2011 04:14 PM, Grant Likely wrote:
>> * ARM Generic Interrupt Controller
>>
>> ARM SMP cores are often associated with a GIC, providing per processor
>> interrupts (PPI), shared processor interrupts (SPI) and software
>> generated interrupts (SGI).
>>
>> Primary GIC is attached directly to the CPU and typically has PPIs and SGIs.
>> Secondary GICs are cascaded into the upward interrupt controller and do not
>> have PPIs or SGIs.
>>
>> Main node required properties:
>>
>> - compatible : should be one of:
>> ? ? ? ?"arm,cortex-a9-gic"
>> ? ? ? ?"arm,arm11mp-gic"
>> - interrupt-controller : Identifies the node as an interrupt controller
>> - #interrupt-cells : Specifies the number of cells needed to encode an
>> ? interrupt source. ?The type shall be a <u32> and the value shall be 3.
>>
>> ? The 1st cell is the interrupt type; 0 for SPI interrupts, 1 for PPI
>> interrupts.
>> ? The 2nd cell contains the interrupt number for the interrupt type.
>> SPI interrupts are in the range [0-987]. ?PPI interrupts are in the
>> range [0-15].
>> ? The 3rd cell is the flags, encoded as follows:
>> ? ? ? ? bits[3:0] trigger type and level flags.
>> ? ? ? ? ? ? ? ? ? ? 1 = low-to-high edge triggered
>> ? ? ? ? ? ? ? ? ? ? 2 = high-to-low edge triggered
>> ? ? ? ? ? ? ? ? ? ? 4 = active high level-sensitive
>> ? ? ? ? ? ? ? ? ? ? 8 = active low level-sensitive
>> ? ? ? ? bits[15:8] PPI interrupt cpu mask. ?Each bit corresponds to
>> each of the 8 possible cpus attached to the GIC. ?A bit set to '1'
>> indicated the interrupt is wired to that CPU. ?Only valid for PPI
>> interrupts.
>>
> How about a cpu mask of 0 means SPI and non-zero means PPI? Then we can
> drop the first cell.

Cells are cheap, and it is better to be explicit.  It is certainly
easier to extend in the future too if the type cell is used.

g.
