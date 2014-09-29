From: anders.berg@avagotech.com (Anders Berg)
Date: Mon, 29 Sep 2014 13:13:00 +0200
Subject: [PATCH v2] i2c: axxia: Add I2C driver for AXM55xx
In-Reply-To: <54292F74.2030209@gmail.com>
References: <1411983159-4692-1-git-send-email-anders.berg@avagotech.com>
 <54292F74.2030209@gmail.com>
Message-ID: <CAE0=X_0guSvMqZxHvdS39Zxx4G7qVvnddv96t72rp4FwpJLgfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 12:07 PM, Varka Bhadram <varkabhadram@gmail.com> wrote:
> On 09/29/2014 03:02 PM, Anders Berg wrote:
>>
>> Add I2C bus driver for the controller found in the LSI Axxia family SoCs.
>> The
>> driver implements 10-bit addressing and SMBus transfer modes via emulation
>> (including SMBus block data read).
>>
>> Signed-off-by: Anders Berg <anders.berg@avagotech.com>
>> ---
>>
(...)
>> +
>> +       if (!idev->msg) {
>> +               dev_warn(idev->dev, "unexpected interrupt");
>
>
> Missed terminating new line '\n'
>

Right, I'll fix that (all occurrences)

>
>> +               goto out;
>> +       }
>> +
>> +       /* RX FIFO needs service? */
>> +       if (i2c_m_rd(idev->msg) && (status & MST_STATUS_RFL))
>> +               axxia_i2c_empty_rx_fifo(idev);
>> +
>> +       /* TX FIFO needs service? */
>> +       if (!i2c_m_rd(idev->msg) && (status & MST_STATUS_TFL)) {
>> +               if (axxia_i2c_fill_tx_fifo(idev) == 0)
>> +                       i2c_int_disable(idev, MST_STATUS_TFL);
>> +       }
>> +
>> +       if (status & MST_STATUS_SCC) {
>> +               /* Stop completed */
>> +               i2c_int_disable(idev, ~0);
>> +               complete(&idev->msg_complete);
>> +       } else if (status & MST_STATUS_SNS) {
>> +               /* Transfer done */
>> +               i2c_int_disable(idev, ~0);
>> +               if (i2c_m_rd(idev->msg) && idev->msg_xfrd <
>> idev->msg->len)
>> +                       axxia_i2c_empty_rx_fifo(idev);
>> +               complete(&idev->msg_complete);
>> +       } else if (unlikely(status & MST_STATUS_ERR)) {
>> +               /* Transfer error */
>> +               i2c_int_disable(idev, ~0);
>> +               if (status & MST_STATUS_AL)
>> +                       idev->msg_err = -EAGAIN;
>> +               else if (status & MST_STATUS_NAK)
>> +                       idev->msg_err = -ENXIO;
>> +               else
>> +                       idev->msg_err = -EIO;
>> +               dev_dbg(idev->dev, "error %#x, addr=%#x rx=%u/%u
>> tx=%u/%u\n",
>> +                       status,
>> +                       idev->msg->addr,
>> +                       readl(idev->base + MST_RX_BYTES_XFRD),
>> +                       readl(idev->base + MST_RX_XFER),
>> +                       readl(idev->base + MST_TX_BYTES_XFRD),
>> +                       readl(idev->base + MST_TX_XFER));
>> +               complete(&idev->msg_complete);
>> +       }
>> +
>> +out:
>> +       /* Clear interrupt */
>> +       writel(INT_MST, idev->base + INTERRUPT_STATUS);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>
>
> Its looks good if we move the entire ISR above probe/remove
> functionalities...
>

Not sure what you mean here... The ISR _is_ above probe/remove.

/Anders
