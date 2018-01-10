From: jae.hyun.yoo@linux.intel.com (Jae Hyun Yoo)
Date: Wed, 10 Jan 2018 15:11:25 -0800
Subject: [PATCH linux dev-4.10 3/6] drivers/misc: Add driver for Aspeed
 PECI and generic PECI headers
In-Reply-To: <CAK8P3a3MaSEYnwk2_OadBSyKnBiwXsHw_RocvPDqL6oea9MuJA@mail.gmail.com>
References: <20180109223126.13093-1-jae.hyun.yoo@linux.intel.com>
 <20180109223126.13093-4-jae.hyun.yoo@linux.intel.com>
 <CAK8P3a3MaSEYnwk2_OadBSyKnBiwXsHw_RocvPDqL6oea9MuJA@mail.gmail.com>
Message-ID: <35b7ed78-ea47-4c6e-2d66-b72f53d5efb4@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2018 3:55 AM, Arnd Bergmann wrote:
> On Tue, Jan 9, 2018 at 11:31 PM, Jae Hyun Yoo
> <jae.hyun.yoo@linux.intel.com> wrote:
>> This commit adds driver implementation for Aspeed PECI. Also adds
>> generic peci.h and peci_ioctl.h files to provide compatibility
>> to peci drivers that can be implemented later e.g. Nuvoton's BMC
>> SoC family.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
> 
>> +#include <linux/clk.h>
>> +#include <linux/crc8.h>
>> +#include <linux/delay.h>
>> +#include <linux/interrupt.h>
>> +#include <linux/io.h>
>> +#include <linux/jiffies.h>
>> +#include <linux/mfd/syscon.h>
>> +#include <linux/miscdevice.h>
>> +#include <linux/module.h>
>> +#include <linux/of.h>
>> +#include <linux/peci_ioctl.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/regmap.h>
>> +#include <linux/semaphore.h>
>> +#include <linux/types.h>
>> +#include <linux/uaccess.h>
> 
> semaphore.h is not used here and can be dropped.
> 

You are right. Will drop it.

>> +static struct aspeed_peci *aspeed_peci_priv;
> 
> Try to avoid instance variables like this one. You should always be able to find
> that pointer from whatever structure you were called with.
> 
> 

Okay. I will use driver_data instead.

>> +       timeout = wait_for_completion_interruptible_timeout(
>> +                                       &priv->xfer_complete,
>> +                                       msecs_to_jiffies(priv->cmd_timeout_ms));
>> +
>> +       dev_dbg(priv->dev, "INT_STS : 0x%08x\n", priv->sts);
>> +       if (!regmap_read(priv->regmap, AST_PECI_CMD, &peci_state))
>> +               dev_dbg(priv->dev, "PECI_STATE : 0x%lx\n",
>> +                       PECI_CMD_STS_GET(peci_state));
>> +       else
>> +               dev_dbg(priv->dev, "PECI_STATE : read error\n");
>> +
>> +       if (timeout <= 0 || !(priv->sts & PECI_INT_CMD_DONE)) {
>> +               if (timeout <= 0) {
>> +                       dev_dbg(priv->dev, "Timeout waiting for a response!\n");
>> +                       rc = -ETIME;
>> +               } else {
>> +                       dev_dbg(priv->dev, "No valid response!\n");
>> +                       rc = -EFAULT;
>> +               }
>> +               return rc;
>> +       }
> 
> You don't seem to handle -ERESTARTSYS correct here. Either do it
> right, or drop the _interruptible part above.
> 

Will add a handling logic for the -ERESTARTSYS.

>> +typedef int (*ioctl_fn)(struct aspeed_peci *, void *);
>> +
>> +static ioctl_fn peci_ioctl_fn[PECI_CMD_MAX] = {
>> +       ioctl_xfer_msg,
>> +       ioctl_ping,
>> +       ioctl_get_dib,
>> +       ioctl_get_temp,
>> +       ioctl_rd_pkg_cfg,
>> +       ioctl_wr_pkg_cfg,
>> +       ioctl_rd_ia_msr,
>> +       NULL, /* Reserved */
>> +       ioctl_rd_pci_cfg,
>> +       NULL, /* Reserved */
>> +       ioctl_rd_pci_cfg_local,
>> +       ioctl_wr_pci_cfg_local,
>> +};
>> +
>> +
>> +long peci_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
>> +{
>> +       struct aspeed_peci *priv;
>> +       long ret = 0;
>> +       void __user *argp = (void __user *)arg;
>> +       int timeout = PECI_IDLE_CHECK_TIMEOUT;
>> +       u8 msg[sizeof(struct peci_xfer_msg)];
>> +       unsigned int peci_cmd, msg_size;
>> +       u32 cmd_sts;
>> +
>> +       /*
>> +        * Treat it as an inter module call when filp is null but only in case
>> +        * the private data is initialized.
>> +        */
>> +       if (filp)
>> +               priv = container_of(filp->private_data,
>> +                                   struct aspeed_peci, miscdev);
>> +       else
>> +               priv = aspeed_peci_priv;
> 
> Drop this.
> 

peci_ioctl is being called from peci_hwmon as an inter-module call so it 
is needed, but as you suggested in the other patch, I'll consider 
redesign it with adding a peci device class.

>> +       if (!priv)
>> +               return -ENXIO;
>> +
>> +       switch (cmd) {
>> +       case PECI_IOC_XFER:
>> +       case PECI_IOC_PING:
>> +       case PECI_IOC_GET_DIB:
>> +       case PECI_IOC_GET_TEMP:
>> +       case PECI_IOC_RD_PKG_CFG:
>> +       case PECI_IOC_WR_PKG_CFG:
>> +       case PECI_IOC_RD_IA_MSR:
>> +       case PECI_IOC_RD_PCI_CFG:
>> +       case PECI_IOC_RD_PCI_CFG_LOCAL:
>> +       case PECI_IOC_WR_PCI_CFG_LOCAL:
>> +               peci_cmd = _IOC_TYPE(cmd) - PECI_IOC_BASE;
>> +               msg_size = _IOC_SIZE(cmd);
>> +               break;
> 
> Having to keep the switch() statement and the array above seems a
> little fragile. Can you just do one or the other?
> 
> Regarding the command set, you have both a low-level PECI_IOC_XFER
> interface and a high-level interface. Can you explain why? I'd think that
> generally speaking it's better to have only one of the two.
> 

I was intended to provide generic peci command set, also the low level 
PECI_IOC_XFER to provide flexibility for a case when compose a custom 
peci command which cannot be covered by the high-level command set. As 
you said, all other commands can be implemented in the upper layer but 
the benefit of when this driver has the implementation is, it's easy to 
manage retry logic since peci is retrial based protocol intends to do 
not disturb a CPU if the CPU is doing more important task.

However, your thought also makes sense. I'll check the spec again 
whether the high-level command set can cover all cases. If so, I'll 
remove the low-level command.

>> +       /* Check command sts and bus idle state */
>> +       while (!regmap_read(priv->regmap, AST_PECI_CMD, &cmd_sts)
>> +              && (cmd_sts & (PECI_CMD_STS_MASK | PECI_CMD_PIN_MON))) {
>> +               if (timeout-- < 0) {
>> +                       dev_dbg(priv->dev, "Timeout waiting for idle state!\n");
>> +                       ret = -ETIME;
>> +                       goto out;
>> +               }
>> +               usleep_range(10000, 11000);
>> +       };
> 
> To implement timeout, it's better to replace the counter with a
> jiffies/time_before or ktime_get()/ktime_before() check, since usleep_range()
> is might sleep considerably longer than expected.
> 

Thanks for the suggestion. Will rewrite it using ktime_get()/ktime_before().

>> +EXPORT_SYMBOL_GPL(peci_ioctl);
> 
> No user of this, so drop it.
> 

peci_hwmon is using it.

>> +static int aspeed_peci_open(struct inode *inode, struct file *filp)
>> +{
>> +       struct aspeed_peci *priv =
>> +               container_of(filp->private_data, struct aspeed_peci, miscdev);
>> +
>> +       atomic_inc(&priv->ref_count);
>> +
>> +       dev_dbg(priv->dev, "ref_count : %d\n", atomic_read(&priv->ref_count));
>> +
>> +       return 0;
>> +}
>> +
>> +static int aspeed_peci_release(struct inode *inode, struct file *filp)
>> +{
>> +       struct aspeed_peci *priv =
>> +               container_of(filp->private_data, struct aspeed_peci, miscdev);
>> +
>> +       atomic_dec(&priv->ref_count);
>> +
>> +       dev_dbg(priv->dev, "ref_count : %d\n", atomic_read(&priv->ref_count));
>> +
>> +       return 0;
>> +}
> 
> Nothing uses that reference count, drop it.
> 

You are right. Will drop it.

>> new file mode 100644
>> index 0000000..66322c6
>> --- /dev/null
>> +++ b/include/misc/peci.h
>> @@ -0,0 +1,11 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017 Intel Corporation
>> +
>> +#ifndef __PECI_H
>> +#define __PECI_H
>> +
>> +#include <linux/peci_ioctl.h>
>> +
>> +long peci_ioctl(struct file *filp, unsigned int cmd, unsigned long arg);
>> +
>> +#endif /* __PECI_H */
> 
> Not used anywhere.
> 

peci_hwmon is using it.

>> diff --git a/include/uapi/linux/peci_ioctl.h b/include/uapi/linux/peci_ioctl.h
>> new file mode 100644
>> index 0000000..8386848
>> --- /dev/null
>> +++ b/include/uapi/linux/peci_ioctl.h
>> @@ -0,0 +1,270 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +// Copyright (c) 2017 Intel Corporation
>> +
>> +#ifndef __PECI_IOCTL_H
>> +#define __PECI_IOCTL_H
>> +
>> +#include <linux/ioctl.h>
>> +
>> +/* Base Address of 48d */
>> +#define PECI_BASE_ADDR  0x30  /* The PECI client's default address of 0x30 */
>> +#define PECI_OFFSET_MAX 8     /* Max numver of CPU clients */
>> +
>> +/* PCI Access */
>> +#define MAX_PCI_READ_LEN 24  /* Number of bytes of the PCI Space read */
>> +
>> +#define PCI_BUS0_CPU0      0x00
>> +#define PCI_BUS0_CPU1      0x80
>> +#define PCI_CPUBUSNO_BUS   0x00
>> +#define PCI_CPUBUSNO_DEV   0x08
>> +#define PCI_CPUBUSNO_FUNC  0x02
>> +#define PCI_CPUBUSNO       0xcc
>> +#define PCI_CPUBUSNO_1     0xd0
>> +#define PCI_CPUBUSNO_VALID 0xd4
> 
> I can't tell for sure, but this file seems to be mixing the kernel API with
> hardware specific macros that are not needed in user space. Can you move
> some of this file into the driver itself?
> 
> This might go back to the previous question about the high-level and
> low-level interfaces: if you can drop the low-level ioctl interface, more
> of this header can become private to the driver.
> 

As I answered above, I'll check the spec again and remove the low-level 
command if the high-level command set covers all cases.

>> +/* Package Identifier Read Parameter Value */
>> +#define PKG_ID_CPU_ID               0x0000  /* 0 - CPUID Info */
>> +#define PKG_ID_PLATFORM_ID          0x0001  /* 1 - Platform ID */
>> +#define PKG_ID_UNCORE_ID            0x0002  /* 2 - Uncore Device ID */
>> +#define PKG_ID_MAX_THREAD_ID        0x0003  /* 3 - Max Thread ID */
>> +#define PKG_ID_MICROCODE_REV        0x0004  /* 4 - CPU Microcode Update Revision */
>> +#define PKG_ID_MACHINE_CHECK_STATUS 0x0005  /* 5 - Machine Check Status */
>> +
>> +/* RdPkgConfig Index */
>> +#define MBX_INDEX_CPU_ID            0   /* Package Identifier Read */
>> +#define MBX_INDEX_VR_DEBUG          1   /* VR Debug */
>> +#define MBX_INDEX_PKG_TEMP_READ     2   /* Package Temperature Read */
>> +#define MBX_INDEX_ENERGY_COUNTER    3   /* Energy counter */
>> +#define MBX_INDEX_ENERGY_STATUS     4   /* DDR Energy Status */
>> +#define MBX_INDEX_WAKE_MODE_BIT     5   /* "Wake on PECI" Mode bit */
>> +#define MBX_INDEX_EPI               6   /* Efficient Performance Indication */
> 
> Who defines these constants? Are they specific to the aspeed BMC, to the HECI
> protocol, or to a particular version of the remote endpoint?
> 

These are common peci definitions, not the aspeed BMC specific.

>> +#pragma pack(push, 1)
>> +struct peci_xfer_msg {
>> +       unsigned char client_addr;
>> +       unsigned char tx_len;
>> +       unsigned char rx_len;
>> +       unsigned char tx_buf[MAX_BUFFER_SIZE];
>> +       unsigned char rx_buf[MAX_BUFFER_SIZE];
>> +};
>> +#pragma pack(pop)
>> +
>> +struct peci_ping_msg {
>> +       unsigned char target;
>> +};
>> +
>> +struct peci_get_dib_msg {
>> +       unsigned char target;
>> +       unsigned int  dib;
>> +};
>> +
>> +struct peci_get_temp_msg {
>> +       unsigned char target;
>> +       signed short  temp_raw;
>> +};
> 
> Aside from what Greg already said about the types, please be careful to
> also avoid implicit padding in the API data structures, including the end of the
> structure.
> 

Okay, I'll expand the pack() scope for all these definition.

>> +#define PECI_IOC_RD_PCI_CFG \
>> +       _IOWR(PECI_IOC_BASE + PECI_CMD_RD_PCI_CFG, 0, \
>> +               struct peci_rd_pci_cfg_msg)
>> +
>> +#define PECI_IOC_RD_PCI_CFG_LOCAL \
>> +       _IOWR(PECI_IOC_BASE + PECI_CMD_RD_PCI_CFG_LOCAL, 0, \
>> +               struct peci_rd_pci_cfg_local_msg)
>> +
>> +#define PECI_IOC_WR_PCI_CFG_LOCAL \
>> +       _IOWR(PECI_IOC_BASE + PECI_CMD_WR_PCI_CFG_LOCAL, 0, \
>> +               struct peci_wr_pci_cfg_local_msg)
> 
> Can you give some background on what these do? In particular, who
> is configuring whose PCI devices?
> 
>          Arnd
> 

These are commands to read/write a client CPU's PCI configuration which 
could be an end-point of the physical PECI interface connection. BMC 
controller will be a host and a CPU will be a client.

Thanks,
Jae
