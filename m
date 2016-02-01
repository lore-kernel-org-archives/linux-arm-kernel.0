From: djkurtz@chromium.org (Daniel Kurtz)
Date: Mon, 1 Feb 2016 18:22:29 +0800
Subject: [RFC 3/3] CMDQ: Mediatek CMDQ driver
In-Reply-To: <1454307624.22441.18.camel@mtksdaap41>
References: <1453266881-16849-1-git-send-email-hs.liao@mediatek.com>
 <1453266881-16849-4-git-send-email-hs.liao@mediatek.com>
 <CAGS+omBjD1pXKY_6bFbiGxa5bttvqg5zEvKevzSfoiMOy7ys6Q@mail.gmail.com>
 <1454053150.32413.52.camel@mtksdaap41>
 <CAGS+omBrEE21Xxh8hjcf32qfHJE0jJYvxGP6L1ihS6jcNbLvLQ@mail.gmail.com>
 <1454070262.7401.21.camel@mtksdaap41>
 <CAGS+omBhs7Ks7MVDsxHBBUdgF+0fmAa465HwvNiCzEe97Knt3Q@mail.gmail.com>
 <1454292257.22270.3.camel@mtksdaap41>
 <CAGS+omCzDisk2TfbDnWiXufWgUsCbhF_JFafaUazhSymX-MT_Q@mail.gmail.com>
 <1454307624.22441.18.camel@mtksdaap41>
Message-ID: <CAGS+omB7d3Kq1DKNHxZJjLDmin0rpkDj1kEde3zCxTiT5-xZWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 1, 2016 at 2:20 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
> On Mon, 2016-02-01 at 12:15 +0800, Daniel Kurtz wrote:
>> On Mon, Feb 1, 2016 at 10:04 AM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>> >
>> > On Fri, 2016-01-29 at 21:15 +0800, Daniel Kurtz wrote:
>> > > On Fri, Jan 29, 2016 at 8:24 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>> > > > On Fri, 2016-01-29 at 16:42 +0800, Daniel Kurtz wrote:
>> > > >> On Fri, Jan 29, 2016 at 3:39 PM, Horng-Shyang Liao <hs.liao@mediatek.com> wrote:
>> > > >> > Hi Dan,
>> > > >> >
>> > > >> > Many thanks for your comments and time.
>> > > >> > I reply my plan inline.
>> > > >> >
>> > > >> >
>> > > >> > On Thu, 2016-01-28 at 12:49 +0800, Daniel Kurtz wrote:
>> > > >> >> Hi HS,
>> > > >> >>
>> > > >> >> Sorry for the delay.  It is hard to find time to review a >3700 line
>> > > >> >> driver :-o in detail....
>> > > >> >>
>> > > >> >> Some review comments inline, although I still do not completely
>> > > >> >> understand how all that this driver does and how it works.
>> > > >> >> I'll try to find time to go through this driver in detail again next
>> > > >> >> time you post it for review.
>> > > >> >>
>> > > >> >> On Tue, Jan 19, 2016 at 9:14 PM,  <hs.liao@mediatek.com> wrote:
>> > > >> >> > From: HS Liao <hs.liao@mediatek.com>
>> > > >> >> >
>> > > >> >> > This patch is first version of Mediatek Command Queue(CMDQ) driver. The
>> > > >> >> > CMDQ is used to help read/write registers with critical time limitation,
>> > > >> >> > such as updating display configuration during the vblank. It controls
>> > > >> >> > Global Command Engine (GCE) hardware to achieve this requirement.
>> > > >> >> > Currently, CMDQ only supports display related hardwares, but we expect
>> > > >> >> > it can be extended to other hardwares for future requirements.
>> > > >> >> >
>> > > >> >> > Signed-off-by: HS Liao <hs.liao@mediatek.com>
>> > > >> >>
>> > > >> >> [snip]
>> > > >> >>
>> > > >> >> > diff --git a/drivers/soc/mediatek/mtk-cmdq.c b/drivers/soc/mediatek/mtk-cmdq.c
>> > > >> >> > new file mode 100644
>> > > >> >> > index 0000000..7570f00
>> > > >> >> > --- /dev/null
>> > > >> >> > +++ b/drivers/soc/mediatek/mtk-cmdq.c
>> > > >
>> > > > [snip]
>> > > >
>> > > >> >> > +static const struct cmdq_subsys g_subsys[] = {
>> > > >> >> > +       {0x1400, 1, "MMSYS"},
>> > > >> >> > +       {0x1401, 2, "DISP"},
>> > > >> >> > +       {0x1402, 3, "DISP"},
>> > > >> >>
>> > > >> >> This isn't going to scale.  These addresses could be different on
>> > > >> >> different chips.
>> > > >> >> Instead of a static table like this, we probably need specify to the
>> > > >> >> connection between gce and other devices via devicetree phandles, and
>> > > >> >> then use the phandles to lookup the corresponding device address
>> > > >> >> range.
>> > > >> >
>> > > >> > I will define them in device tree.
>> > > >> > E.g.
>> > > >> > cmdq {
>> > > >> >   reg_domain = 0x14000000, 0x14010000, 0x14020000
>> > > >> > }
>> > > >>
>> > > >> The devicetree should only model hardware relationships, not software
>> > > >> considerations.
>> > > >>
>> > > >> Is the hardware constraint here for using gce with various other
>> > > >> hardware blocks?  I think we already model this by only providing a
>> > > >> gce phandle in the device tree nodes for those devices that can use
>> > > >> gce.
>> > > >>
>> > > >> Looking at the driver closer, as far as I can tell, the whole subsys
>> > > >> concept is a purely software abstraction, and only used to debug the
>> > > >> CMDQ_CODE_WRITE command.  In fact, AFAICT, everything would work fine
>> > > >> if we just completely removed the 'subsys' concept, and just passed
>> > > >> through the raw address provided by the driver.
>> > > >>
>> > > >> So, I recommend just removing 'subsys' completely from the driver -
>> > > >> from this array, and in the masks.
>> > > >>
>> > > >> Instead, if there is an error on the write command, just print the
>> > > >> address that fails.  There are other ways to deduce the subsystem from
>> > > >> a physical address.
>> > > >>
>> > > >> Thanks,
>> > > >>
>> > > >> -Dan
>> > > >
>> > > > Hi Dan,
>> > > >
>> > > > Subsys is not just for debug.
>> > > > Its main purpose is to transfer CPU address to GCE address.
>> > > > Let me explain it by "write" op,
>> > > > I list a code segment from cmdq_rec_append_command().
>> > > >
>> > > >         case CMDQ_CODE_WRITE:
>> > > >                 subsys = cmdq_subsys_from_phys_addr(cqctx, arg_a);
>> > > >                 if (subsys < 0) {
>> > > >                         dev_err(dev,
>> > > >                                 "unsupported memory base address 0x%08x\n",
>> > > >                                 arg_a);
>> > > >                         return -EFAULT;
>> > > >                 }
>> > > >
>> > > >                 *cmd_ptr++ = arg_b;
>> > > >                 *cmd_ptr++ = (CMDQ_CODE_WRITE << CMDQ_OP_CODE_SHIFT) |
>> > > >                              (arg_a & CMDQ_ARG_A_WRITE_MASK) |
>> > > >                              ((subsys & CMDQ_SUBSYS_MASK) << CMDQ_SUBSYS_SHIFT);
>> > > >                 break;
>> > > >
>> > > > Subsys is mapped from physical address via cmdq_subsys_from_phys_addr(),
>> > > > and then it becomes part of GCE command via ((subsys & CMDQ_SUBSYS_MASK)
>> > > > << CMDQ_SUBSYS_SHIFT) .
>> > > > Only low bits of physical address are the same as GCE address.
>> > > > We can get it by (arg_a & CMDQ_ARG_A_WRITE_MASK).
>> > > > MASK is used to define how many bits are valid for this op.
>> > > > So, GCE address = subsys + valid low bits.
>> > >
>> > > How are these upper bits of the "GCE address" defined?
>> > > In other words, for a given SoC, how is the mapping between physical
>> > > io addresses to GCE addresses defined?
>> > > Is this mapping fixed by hardware?
>>
>> Please answer the detailed technical questions:
>>
>> How are these upper bits of the "GCE address" defined?
>
> A GCE command is arg_a + arg_b. Both of them have 32 bits length.
> arg_a is op + subsys + addr, and arg_b is value.
> subsys + addr is less than 32bits, so we need to map address range to
> subsys.
> The mapping rule is defined by hardware.
>
>> In other words, for a given SoC, how is the mapping between physical
>> io addresses to GCE addresses defined?
>
> It is (b).
>
>>
>> (a) Does the GCE remap a continuous device IO address range?
>>
>> AFAICT, the  defines an MT8173 specific mapping of:
>>
>> For example, the g_subsys table above seems to imply that the MT8173
>> gce maps all of:
>>   0x1400ffff:0x141fffff => 0x010000:0x1fffff
>>
>> (b) Or, are the upper 5 bits of the "gce address" significant, and via
>> hardware it can map a disjoint groups of device addresses into the
>> continuous GCE address space, and really there are 0x1f distinct 64k
>> mappings:
>>
>> mmsys (1) : 0x14000000:0x1400ffff => 0x010000:0x01ffff
>> disp  (2) : 0x14010000:0x1401ffff => 0x020000:0x02ffff
>> disp  (3) : 0x14020000:0x1402ffff => 0x030000:0x03ffff
>> ...
>> ???? (1f) : 0x141fffff:0x141fffff => 0x1f0000:0x1fffff
>>
>> If the mapping is fixed and continuous (a), then I think all we need
>> is a single dts entry for the gce node that describes how it performs
>> this mapping.  And then, the gce consumers can just pass in their
>> regular physical addresses, and the gce driver can remap them directly
>> to gce addresses.
>>
>> WDYT?
>
> How about this?
> hardware_module = <address_base subsys_id mask>;
> So, the result is
> mmsys_config_base = <0x14000000 1 0xffff0000>;
> disp_rdma_config_base = <0x14010000 2 0xffff0000>;
> disp_mutex_config_base = <0x14020000 3 0xffff0000>;

What uses ID 0 and 4 - 0x1f?

According to mt8173.dtsi, here are the blocks in the address ranges above:

@1400:
  mmsys: clock-controller at 14000000
  ovl0: ovl at 1400c000
  ovl1: ovl at 1400d000
  rdma0: rdma at 1400e000
  rdma1: rdma at 1400f000

@1401:
  rdma2: rdma at 14010000
  wdma0: wdma at 14011000
  wdma1: wdma at 14012000
  color0: color at 14013000
  color1: color at 14014000
  aal at 14015000
  gamma at 14016000
  merge at 14017000
  split0: split at 14018000
  split1: split at 14019000
  ufoe at 1401a000
  dsi0: dsi at 1401b000
  dsi1: dsi at 1401c000
  dpi0: dpi at 1401d000
  pwm0: pwm at 1401e000
  pwm1: pwm at 1401f000

@1402:
  mutex: mutex at 14020000
  od at 14023000
  larb0: larb at 14021000
  smi_common: smi at 14022000
  hdmi0: hdmi at 14025000
  larb4: larb at 14027000

I assume that the gce will work with any of the devices in those
ranges, not just "mmsys", "rdma" and "mutex", right?   (Also, notice
there are two "rdma" in the @1400 range, so rdma is really not a good
name for @1401)

Further, it looks like the gce just maps a large device address range
starting at 0x14000000 to (21-bit) gce address 0x010000, rather than
31 individually addressable 64k "subsys" blocks.  Is there a counter
example that I am missing?

-Dan

>
>> -Dan
>>
>> >
>> > Yes, this mapping is fixed by hardware.
>> >
>> > > Does it vary for different SoCs?
>> >
>> > Yes, it varies for different SoCs.
>> >
>> > >
>> > > -Dan
>> > >
>> > > > That's why we need to know the mapping between the range of physical
>> > > > address and subsys.
>> > > > Please guide us a better way to code such requirement.
>> > > > Thanks for your help.
>> > > >
>> > > > Thanks,
>> > > > HS Liao
>> > > >
>> >
>> > Thanks,
>> > HS Liao
>> >
>
> Thanks,
> HS Liao
>
