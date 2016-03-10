From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Thu, 10 Mar 2016 22:18:28 +0800
Subject: [PATCH 1/2] iommu/io-pgtable: Add MTK 4GB mode in Short-descriptor
In-Reply-To: <56D6DD2E.4030207@arm.com>
References: <1456268552-16635-1-git-send-email-yong.wu@mediatek.com>
 <1456268552-16635-2-git-send-email-yong.wu@mediatek.com>
 <56D6DD2E.4030207@arm.com>
Message-ID: <1457619508.14539.40.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-03-02 at 12:31 +0000, Robin Murphy wrote:
> Hi Yong,
> 
> On 23/02/16 23:02, Yong Wu wrote:
> > Mediatek extend bit9 in the lvl1 and lvl2 pgtable descriptor of the
> > Short-descriptor as the 4GB mode in which the dram size will be
> > over 4GB.
> >
> > We add a special quirk for this MTK-4GB mode, And in the standard
> > spec, Bit9 in the lvl1 is "IMPLEMENTATION DEFINED", while it's AP[2]
> > in the lvl2, therefore if this quirk is enabled, NO_PERMS is also
> > expected.
> 
> Would you be able to explain exactly what this "4GB mode" actually is? 
> I've been trying to make sense of it from the original M4U patches and 
> the patch for the I2C driver, but it has me completely baffled.
> 
> Is it simply used as an extra physical address bit (although surely that 
> would make it "8GB mode"?), or does it do something crazier like 
> toggling an interconnect remap that shifts the output addresses up by 
> 1GB to be relative to the base of DRAM, like a dma_pfn_offset?

Unfortunately, it is somewhat more crazier than that. Let me have a
short brief on what we got.

Normally, mt8173 memory map looks like this:

Physical addr
---------
| 1st GB |    ->  HW SRAM and Regs
|--------
| 2nd GB |    ->  DRAM 1st GB
|--------
| 3rd GB |    ->  DRAM 2nd GB
|--------
| 4th GB |    ->  DRAM 3rd GB
|--------

On mt8173, we have a "DRAM 4GB mode" toggle bit. If it is enabled, from
CPU's point of view, the dram will be shifted to start from PA
0x1_00000000. The PA 0x40000000~0xffffffff will become an alias to
0x1_40000000~0x1_ffffffff.

Many HW only support 32bits physical address, the 33bit will be added to
PA when 4GB mode is enabled. This looks like dma_pfn_offset you
mentioned.

Some others, like i2c or audio, support 33bits physical address, mostly
because they support DMA to/from SRAM with the same SW interface. When
4GB mode is enabled, these HW can still access DRAM with aliased dram
address (0x40000000 ~ 0xffffffff)

The MTK M4U(iommu) is another case. It did add 33 bits to page table
entries and registers. Unfortunately, when 4GB mode is enabled, 33bit
must be 1. It treats all PA < 0x1_0000_0000 as invalid address. That's
why we always set the 33bit when 4GB mode is enabled in this patch.

And there are other HWs with even crazier remap rule, but that's another
story...

Joe.C
