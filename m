From: appana.durga.rao@xilinx.com (Appana Durga Kedareswara Rao)
Date: Tue, 11 Mar 2014 14:08:47 +0000
Subject: [PATCH v5] can: xilinx CAN controller support.
In-Reply-To: <531F0636.4050608@pengutronix.de>
References: <5254bfec-c6fd-4681-a34d-706d51e60fbb@VA3EHSMHS004.ehs.local>
 <531DD2C4.5060109@pengutronix.de>
 <f1e2f08f-05fc-40d3-8437-4c6817d631cb@AM1EHSMHS010.ehs.local>
 <531F0636.4050608@pengutronix.de>
Message-ID: <a99feda0-7463-4781-bb73-90b99e65b014@CO9EHSMHS028.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,


> -----Original Message-----
> From: Marc Kleine-Budde [mailto:mkl at pengutronix.de]
> Sent: Tuesday, March 11, 2014 6:19 PM
> To: Appana Durga Kedareswara Rao
> Cc: linux-can at vger.kernel.org; netdev at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-kernel at vger.kernel.org;
> devicetree at vger.kernel.org; robh+dt at kernel.org; grant.likely at linaro.org;
> Michal Simek; wg at grandegger.com; fengguang.wu at intel.com
> Subject: Re: [PATCH v5] can: xilinx CAN controller support.
>
> On 03/11/2014 01:34 PM, Appana Durga Kedareswara Rao wrote:
>
> >>> diff --git a/drivers/net/can/Kconfig b/drivers/net/can/Kconfig index
> >>> 9e7d95d..b180239 100644
> >>> --- a/drivers/net/can/Kconfig
> >>> +++ b/drivers/net/can/Kconfig
> >>> @@ -125,6 +125,13 @@ config CAN_GRCAN
> >>>       endian syntheses of the cores would need some modifications on
> >>>       the hardware level to work.
> >>>
> >>> +config CAN_XILINXCAN
> >>> +   tristate "Xilinx CAN"
> >>> +   depends on ARCH_ZYNQ || MICROBLAZE
> >>
> >> Is Zynq multiarch already?
> > Discussions are going on this
> > So the final thing that Fengguang ( fengguang.wu at intel.com) Proposed
> > is
> >         config CAN_XILINX
> >         tristate "Xilinx CAN"
> >         depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
> >         depends on COMMON_CLK && HAS_MMIO  # whatever you need for
> > other architectures
>
> > Are you Ok for this?
>
> You have to fill the 2nd depends on with some sane values, though.
>
> [...]
>
Ok

> >>> +/**
> >>> + * struct xcan_priv - This definition define CAN driver instance
> >>> + * @can:                   CAN private data structure.
> >>> + * @tx_head:                       Tx CAN packets ready to send on the
> >> queue
> >>> + * @tx_tail:                       Tx CAN packets successfully sended on the
> >> queue
> >>> + * @tx_max:                        Maximum number packets the driver can
> >> send
> >>> + * @napi:                  NAPI structure
> >>> + * @read_reg:                      For reading data from CAN registers
> >>> + * @write_reg:                     For writing data to CAN registers
> >>> + * @dev:                   Network device data structure
> >>> + * @reg_base:                      Ioremapped address to registers
> >>> + * @irq_flags:                     For request_irq()
> >>> + * @aperclk:                       Pointer to struct clk
> >>> + * @devclk:                        Pointer to struct clk
> >>> + */
> >>> +struct xcan_priv {
> >>> +   struct can_priv can;
> >>> +   unsigned int tx_head;
> >>> +   unsigned int tx_tail;
> >>> +   u32 tx_max;
> >> Please make it an unsigned int, too.
> >>
> > Ok
> >
> >
> >>> +   struct napi_struct napi;
> >>> +   u32 (*read_reg)(const struct xcan_priv *priv, enum xcan_reg reg);
> >>> +   void (*write_reg)(const struct xcan_priv *priv, enum xcan_reg reg,
> >>> +                   u32 val);
> >>> +   struct net_device *dev;
> >>> +   void __iomem *reg_base;
> >>> +   unsigned long irq_flags;
> >>> +   struct clk *aperclk;
> >>> +   struct clk *devclk;
> >>
> >> Please rename the clock variables to match the names in the DT.
> >>
> > The clock names are different for axi CAN and CANPS case.
> > So will make them as busclk and devclk Are you ok with this?
>
> Why not "ref_clk" and "aper_clk" as used in the DT?
>
One of the comments I got from the Soren(sorenb at xilinx.com)
Is the  clock-names must match the data sheet.
If I Modify the clock names then it is different names for AXI CAN
and CANPS case.

> >>> +};
> >>> +
>
> [...]
>
> >>> +/**
> >>> + * xcan_chip_start - This the drivers start routine
> >>> + * @ndev:  Pointer to net_device structure
> >>> + *
> >>> + * This is the drivers start routine.
> >>> + * Based on the State of the CAN device it puts
> >>> + * the CAN device into a proper mode.
> >>> + *
> >>> + * Return: 0 on success and failure value on error  */ static int
> >>> +xcan_chip_start(struct net_device *ndev) {
> >>> +   struct xcan_priv *priv = netdev_priv(ndev);
> >>> +   u32 err;
> >>> +   unsigned long timeout;
> >>> +
> >>> +   /* Check if it is in reset mode */
> >>> +   err = set_reset_mode(ndev);
> >>> +   if (err < 0)
> >>> +           return err;
> >>> +
> >>> +   err = xcan_set_bittiming(ndev);
> >>> +   if (err < 0)
> >>> +           return err;
> >>> +
> >>> +   /* Enable interrupts */
> >>> +   priv->write_reg(priv, XCAN_IER_OFFSET, XCAN_INTR_ALL);
> >>> +
> >>> +   /* Check whether it is loopback mode or normal mode  */
> >>> +   if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
> >>> +           /* Put device into loopback mode */
> >>> +           priv->write_reg(priv, XCAN_MSR_OFFSET,
> >> XCAN_MSR_LBACK_MASK);
> >>> +   else
> >>> +           /* The device is in normal mode */
> >>> +           priv->write_reg(priv, XCAN_MSR_OFFSET, 0);
> >>> +
> >>> +   if (priv->can.state == CAN_STATE_STOPPED) {
> >>
> >> Your device is in stopped mode, add you go though set_reset_mode()
> >> already.
> >
> > Will remove this if condition I putted this condition here because in
> > set_reset_mode we are putting the Device state in Stopped state.
>
> So the device is in CAN_STATE_STOPPED, as this code just went through
> set_reset_mode() some lines ago. so it makes no sense to check if it
> (still) is (the code runs serialized here).
>

After removing the if condition and the line(CAN_STATE_STOPPED from the set_reset_mode)
the code for chip_start is below It is better to check whether it is really Configured in the loopback or normal mode
That's why kept the loops as it is.

static int xcan_chip_start(struct net_device *ndev)
{
        struct xcan_priv *priv = netdev_priv(ndev);
        u32 err;
        unsigned long timeout;

        /* Check if it is in reset mode */
        err = set_reset_mode(ndev);
        if (err < 0)
                return err;

        err = xcan_set_bittiming(ndev);
        if (err < 0)
                return err;

        /* Enable interrupts */
        priv->write_reg(priv, XCAN_IER_OFFSET, XCAN_INTR_ALL);

        /* Check whether it is loopback mode or normal mode  */
        if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK)
                /* Put device into loopback mode */
                priv->write_reg(priv, XCAN_MSR_OFFSET, XCAN_MSR_LBACK_MASK);
        else
                /* The device is in normal mode */
                priv->write_reg(priv, XCAN_MSR_OFFSET, 0);

        priv->write_reg(priv, XCAN_SRR_OFFSET, XCAN_SRR_CEN_MASK);
        timeout = jiffies + XCAN_TIMEOUT;
        if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
                while ((priv->read_reg(priv, XCAN_SR_OFFSET)
                                & XCAN_SR_LBACK_MASK) == 0) {
                        if (time_after(jiffies, timeout)) {
                                netdev_warn(ndev,
                                        "timedout for loopback mode\n");
                                return -ETIMEDOUT;
                        }
                        usleep_range(500, 10000);
                }
        } else {
                while ((priv->read_reg(priv, XCAN_SR_OFFSET)
                                & XCAN_SR_NORMAL_MASK) == 0) {
                        if (time_after(jiffies, timeout)) {
                                netdev_warn(ndev,
                                        "timedout for normal mode\n");
                                return -ETIMEDOUT;
                        }
                        usleep_range(500, 10000);
                }
        }
        netdev_dbg(ndev, "status:#x%08x\n",
                        priv->read_reg(priv, XCAN_SR_OFFSET));

        priv->can.state = CAN_STATE_ERROR_ACTIVE;
        return 0;
}


Regards,
Kedar.

> >>
> >>> +           /* Enable Xilinx CAN */
> >>> +           priv->write_reg(priv, XCAN_SRR_OFFSET,
> >> XCAN_SRR_CEN_MASK);
> >>> +           priv->can.state = CAN_STATE_ERROR_ACTIVE;
> >>> +           timeout = jiffies + XCAN_TIMEOUT;
> >>> +           if (priv->can.ctrlmode & CAN_CTRLMODE_LOOPBACK) {
> >>> +                   while ((priv->read_reg(priv, XCAN_SR_OFFSET)
> >>> +                                   & XCAN_SR_LBACK_MASK) == 0) {
> >>> +                           if (time_after(jiffies, timeout)) {
> >>> +                                   netdev_warn(ndev,
> >>> +                                           "timedout for loopback
> >> mode\n");
> >>> +                                   return -ETIMEDOUT;
> >>> +                           }
> >>> +                           usleep_range(500, 10000);
> >>> +                   }
> >>> +           } else {
> >>> +                   while ((priv->read_reg(priv, XCAN_SR_OFFSET)
> >>> +                                   & XCAN_SR_NORMAL_MASK) == 0) {
> >>> +                           if (time_after(jiffies, timeout)) {
> >>> +                                   netdev_warn(ndev,
> >>> +                                           "timedout for normal
> >> mode\n");
> >>> +                                   return -ETIMEDOUT;
> >>> +                           }
> >>> +                           usleep_range(500, 10000);
> >>> +                   }
> >>> +           }
> >>> +           netdev_dbg(ndev, "status:#x%08x\n",
> >>> +                           priv->read_reg(priv, XCAN_SR_OFFSET));
> >>> +   }
> >>> +   priv->can.state = CAN_STATE_ERROR_ACTIVE;
> >>> +   return 0;
> >>> +}
>
> Marc
>
> --
> Pengutronix e.K.                  | Marc Kleine-Budde           |
> Industrial Linux Solutions        | Phone: +49-231-2826-924     |
> Vertretung West/Dortmund          | Fax:   +49-5121-206917-5555 |
> Amtsgericht Hildesheim, HRA 2686  | http://www.pengutronix.de   |



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
