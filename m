From: mans@mansr.com (=?iso-8859-1?Q?M=E5ns_Rullg=E5rd?=)
Date: Mon, 25 Jan 2016 10:31:30 +0000
Subject: [PATCH 07/15] dmaengine: dw: revisit data_width property
In-Reply-To: <1453711547.2521.209.camel@linux.intel.com> (Andy Shevchenko's
 message of "Mon, 25 Jan 2016 10:45:47 +0200")
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-8-git-send-email-mans@mansr.com>
 <C2D7FE5348E1B147BCA15975FBA23075F4E86560@us01wembx1.internal.synopsys.com>
 <1453711547.2521.209.camel@linux.intel.com>
Message-ID: <yw1xfuxmkl19.fsf@unicorn.mansr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andy Shevchenko <andriy.shevchenko@linux.intel.com> writes:

> On Mon, 2016-01-25 at 07:32 +0000, Vineet Gupta wrote:
>> On Monday 25 January 2016 12:55 AM, Mans Rullgard wrote:
>> > From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > 
>> > There are several changes are done here:
>> > 
>> > ?- Convert the property to be in bytes
>> > 
>> > ???Much more convenient than keeping encoded value.
>> > 
>> > ?- Use one value for all AHB masters for now
>> > 
>> > ???It seems in practice we have no controllers where masters have
>> > different
>> > ???data bus width, we still might return to distinct values when
>> > there is a use
>> > ???case.
>> > 
>> > ?- Rename data_width to data-width in the device tree bindings.
>> > 
>> > ?- While here, replace dwc_fast_ffs() by __ffs().
>> > 
>> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> > Signed-off-by: Mans Rullgard <mans@mansr.com>
>> > ---
>> > This patch changes the DT binding, so it should probably be amended
>> > for
>> > compatibility with old device trees.??I've included it as is since
>> > I think
>> > the change as such is good.
>> > ---
>> > ?Documentation/devicetree/bindings/dma/snps-dma.txt |??5 ++-
>> > ?arch/arc/boot/dts/abilis_tb10x.dtsi????????????????|??2 +-
>> > ?arch/arm/boot/dts/spear13xx.dtsi???????????????????|??4 +--
>> > ?drivers/dma/dw/core.c??????????????????????????????| 40 +++-------
>> > ------------
>> > ?drivers/dma/dw/platform.c??????????????????????????|??8 ++---
>> > ?drivers/dma/dw/regs.h??????????????????????????????|??2 +-
>> > ?include/linux/platform_data/dma-dw.h???????????????|??5 ++-
>> > ?7 files changed, 16 insertions(+), 50 deletions(-)
>> > 
>> > diff --git a/Documentation/devicetree/bindings/dma/snps-dma.txt
>> > b/Documentation/devicetree/bindings/dma/snps-dma.txt
>> > index c99c1ffac199..fe7f7710a6b4 100644
>> > --- a/Documentation/devicetree/bindings/dma/snps-dma.txt
>> > +++ b/Documentation/devicetree/bindings/dma/snps-dma.txt
>> > @@ -13,8 +13,7 @@ Required properties:
>> > ?- chan_priority: priority of channels. 0 (default): increase from
>> > chan 0->n, 1:
>> > ???increase from chan n->0
>> > ?- block_size: Maximum block size supported by the controller
>> > -- data_width: Maximum data width supported by hardware per AHB
>> > master
>> > -??(0 - 8bits, 1 - 16bits, ..., 5 - 256bits)
>> > +- data-width: Maximum data width supported by hardware (in bytes)
>> 
>> To the reader this suggests a value truely byte granular, but code
>> uses ffs
>> implying that it is still power of 2.
>> Can you mention this here (....in bytes, always power of 2).
>
> While this comment is good, I have still note that using non-power of 2
> values will not break anything. Least power of two number will be used
> in that case. So, means I would suggest to replace 'always' by 'better
> to be' or something like that.

Although the code rounds down, the hardware actually works in powers of
two, and it's better to document this.

-- 
M?ns Rullg?rd
