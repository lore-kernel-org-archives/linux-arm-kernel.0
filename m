From: dan.j.williams@intel.com (Dan Williams)
Date: Sat, 15 Jan 2011 23:17:04 -0800
Subject: [PATCH 27/48] ARM: PL08x: avoid duplicating registers in txd and
	phychan structures
In-Reply-To: <20110115092324.GX15996@n2100.arm.linux.org.uk>
References: <20110103222943.GB4572@n2100.arm.linux.org.uk>
	<E1PZt3Z-00025W-0c@rmk-PC.arm.linux.org.uk>
	<AANLkTi=GsMaDQDSuR=Z4AT4Vk4GThx6O_0Le=pjsu9gj@mail.gmail.com>
	<20110115092324.GX15996@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim_1yK_Q7sy4a1iMX2zXG1p3EJ0avGvcYeTP9Us@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 15, 2011 at 1:23 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 05:35:41PM -0800, Dan Williams wrote:
>> On Mon, Jan 3, 2011 at 2:39 PM, Russell King - ARM Linux
>> <linux@arm.linux.org.uk> wrote:
>> > As we now have all the code accessing the phychan {csrc,cdst,clli,cctl,
>> > ccfg} members in one function, there's no point storing the data into
>> > the struct. ?Get rid of the struct members. ?Re-order the register dump
>> > in the dev_dbg() to reflect the order we write the registers to the DMA
>> > device.
>> >
>> > The txd {csrc,cdst,clli,cctl} values are duplicates of the lli[0]
>> > values, so there's no point duplicating these either. ?Program the DMAC
>> > registers directly from the lli[0] values.
>> >
>> > Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
>>
>> This one caused:
>> drivers/dma/amba-pl08x.c: In function 'pl08x_start_txd':
>> drivers/dma/amba-pl08x.c:205: warning: dereferencing 'void *' pointer
>
> That probably means you've got something out of order. ?I have them
> ordered in my git tree, I'll recheck there.

I rechecked here and I think everything is in order.

The line in question does not get touched in subsequent patches...
diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index c025a4b..a1a18bd 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -193,33 +193,25 @@ static void pl08x_start_txd(struct pl08x_dma_chan *plchan,
 {
       struct pl08x_driver_data *pl08x = plchan->host;
       struct pl08x_phy_chan *phychan = plchan->phychan;
-       u32 val;
+       struct pl08x_lli *lli = &txd->llis_va[0];
+       u32 val, ccfg;

29/48 is the only other patch after this to touch pl08x_start_txd.

Double checked the sorted by subject mbox order matches the order they
are applied in git.

...nothing in the series touches the definition of llis_va in
include/linux/amba/pl08x.h.
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 113)
struct pl08x_txd {
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 114)
 struct dma_async_tx_descriptor tx;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 115)
 struct list_head node;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 116)
 enum dma_data_direction direction;
d7244e9a (Russell King - ARM Linux 2011-01-03 22:43:35 +0000 117)
 dma_addr_t src_addr;
d7244e9a (Russell King - ARM Linux 2011-01-03 22:43:35 +0000 118)
 dma_addr_t dst_addr;
cace6585 (Russell King - ARM Linux 2011-01-03 22:37:31 +0000 119)
 size_t len;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 120)
 dma_addr_t llis_bus;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 121)
 void *llis_va;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 122)
 bool active;
70b5ed6b (Russell King - ARM Linux 2011-01-03 22:40:13 +0000 123)
 /* Default cctl value for LLIs */
70b5ed6b (Russell King - ARM Linux 2011-01-03 22:40:13 +0000 124)
 u32 cctl;
4983a04f (Russell King - ARM Linux 2011-01-03 22:39:33 +0000 125)       /*
4983a04f (Russell King - ARM Linux 2011-01-03 22:39:33 +0000 126)
  * Settings to be put into the physical channe
4983a04f (Russell King - ARM Linux 2011-01-03 22:39:33 +0000 127)
  * trigger this txd.  Other registers are in l
4983a04f (Russell King - ARM Linux 2011-01-03 22:39:33 +0000 128)        */
4983a04f (Russell King - ARM Linux 2011-01-03 22:39:33 +0000 129)
 u32 ccfg;
e8689e63 (Linus Walleij            2010-09-28 15:57:37 +0200 130) };

--
Dan
