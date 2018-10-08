From: sboyd@kernel.org (Stephen Boyd)
Date: Sun, 07 Oct 2018 19:27:50 -0700
Subject: [PATCH v5 4/4] drivers: clk: Add ZynqMP clock driver
In-Reply-To: <1538173080-7597-5-git-send-email-jollys@xilinx.com>
References: <1538173080-7597-1-git-send-email-jollys@xilinx.com>
 <1538173080-7597-5-git-send-email-jollys@xilinx.com>
Message-ID: <153896567067.119890.7785076104115447392@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Jolly Shah (2018-09-28 15:18:00)
> diff --git a/drivers/clk/zynqmp/clkc.c b/drivers/clk/zynqmp/clkc.c
> new file mode 100644
> index 0000000..1b07d77
> --- /dev/null
> +++ b/drivers/clk/zynqmp/clkc.c
> @@ -0,0 +1,716 @@
[...]
> + * @type:      Clock type: CLK_TYPE_OUTPUT or CLK_TYPE_EXTERNAL
> + *
> + * Return: 0 on success else error code
> + */
> +static int zynqmp_get_clock_type(u32 clk_id, u32 *type)
> +{
> +       int ret;
> +
> +       ret = zynqmp_is_valid_clock(clk_id);
> +       if (ret == 1) {
> +               *type = clock[clk_id].type;
> +               return 0;
> +       }
> +
> +       return ret == 0 ? -EINVAL : ret;
> +}
> +
> +/**
> + * zynqmp_pm_clock_get_num_clocks() - Get number of clocks in system
> + * @nclocks:   Number of clocks in system/board.
> + *
> + * Call firmware API to get number of clocks.
> + *
> + * Return: 0 on success else error code.
> + */
> +static int zynqmp_pm_clock_get_num_clocks(u32 *nclocks)
> +{
> +       struct zynqmp_pm_query_data qdata = {0};
> +       __le32 ret_payload[PAYLOAD_ARG_CNT];

I asked about endianess but this isn't the right fix. Just marking
something as __le32 but then not using that type and just passing it to
some function that takes a u32 pointer doesn't work. So is the firmware
side always little endian? If so, maybe the ioctls can do the byte swap
and then the kernel API can be native CPU endian while the firmware
layer can be aware that things may need swapping. I'm suggesting that
this type is just u32 and then the eemi_ops functions accept u32 and do
the swapping themselves.

If you put back u32 here and elsewhere in this patch you can have my

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

The fix to the underlying ops for endian correctness can come later, so
don't feel like it needs to be fixed right now.
