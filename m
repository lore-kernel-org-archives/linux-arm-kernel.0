From: JOLLYS@xilinx.com (Jolly Shah)
Date: Mon, 8 Oct 2018 18:27:56 +0000
Subject: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
 <1538173080-7597-5-git-send-email-jollys@xilinx.com>
 <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
Message-ID: <CY1PR02MB21383F22BE80E2DB83E7EB98B8E60@CY1PR02MB2138.namprd02.prod.outlook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

> -----Original Message-----
> From: Stephen Boyd [mailto:sboyd at kernel.org]
> Sent: Sunday, October 07, 2018 7:28 PM
> To: Jolly Shah <JOLLYS@xilinx.com>; arm at kernel.org; linux-
> clk at vger.kernel.org; Michal Simek <michals@xilinx.com>;
> mturquette at baylibre.com; olof at lixom.net; sboyd at codeaurora.org
> Cc: Rajan Vaja <RAJANV@xilinx.com>; linux-arm-kernel at lists.infradead.org;
> linux-kernel at vger.kernel.org; Jolly Shah <JOLLYS@xilinx.com>; Rajan Vaja
> <RAJANV@xilinx.com>; Tejas Patel <TEJASP@xilinx.com>; Shubhrajyoti Datta
> <shubhraj@xilinx.com>; Jolly Shah <JOLLYS@xilinx.com>
> Subject: Re: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
> 
> Quoting Jolly Shah (2018-09-28 15:18:00)
> > diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c new
> > file mode 100644 index 0000000..1b07d77
> > --- /dev/null
> > +++ b/drivers/clk/zynqmp/clkc.c
> > @@ -0,0 +1,716 @@
> [...]
> > + * @type:      Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
> > + *
> > + * Return: 0 on success else error code  */ static int
> > +zynqmp_get_clock_type(u32 clk_id, u32 *type) {
> > +       int ret;
> > +
> > +       ret = zynqmp_is_valid_clock(clk_id);
> > +       if (ret == 1) {
> > +               *type = clock[clk_id].type;
> > +               return 0;
> > +       }
> > +
> > +       return ret == 0 ? -EINVAL : ret; }
> > +
> > +/**
> > + * zynqmp_pm_clock_get_num_clocks() - Get number of clocks in system
> > + * @nclocks:   Number of clocks in system/board.
> > + *
> > + * Call firmware API to get number of clocks.
> > + *
> > + * Return: 0 on success else error code.
> > + */
> > +static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks) {
> > +       struct zynqmp_pm_query_data qdata = {0};
> > +       __le32 ret_payload[PAYLOAD_ARG_CNT];
> 
> I asked about endianess but this isn't the right fix. Just marking something as
> __le32 but then not using that type and just passing it to some function that
> takes a u32 pointer doesn't work. So is the firmware side always little endian? If
> so, maybe the ioctls can do the byte swap and then the kernel API can be native
> CPU endian while the firmware layer can be aware that things may need
> swapping. I'm suggesting that this type is just u32 and then the eemi_ops
> functions accept u32 and do the swapping themselves.
> 
> If you put back u32 here and elsewhere in this patch you can have my
> 
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> 
> The fix to the underlying ops for endian correctness can come later, so don't feel
> like it needs to be fixed right now.

Thanks for clarification. It makes perfect sense. I pushed v6 with suggested change and your review tag. 
I will send an incremental patch for endianness correction.

Thanks,
Jolly Shah
