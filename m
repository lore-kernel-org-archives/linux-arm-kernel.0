From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 18 Oct 2017 13:58:34 +0800
Subject: [PATCH 1/3] driver: mailbox: add support for Hi3660
In-Reply-To: <CABb+yY1gbA8tXz4u_7s6=jo7s0HTEWcisXxKe_yhdZR2tPPEUw@mail.gmail.com>
References: <1502097434-11136-1-git-send-email-zhongkaihua@huawei.com>
 <CABb+yY1gbA8tXz4u_7s6=jo7s0HTEWcisXxKe_yhdZR2tPPEUw@mail.gmail.com>
Message-ID: <20171018055833.GG19504@leoy-ThinkPad-T440>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Sat, Sep 02, 2017 at 01:07:50PM +0530, Jassi Brar wrote:

[...]

> > +#define MBOX_CHAN_MAX                  32
> > +
> > +#define MBOX_TX                                0x1
> > +
> > +/* Mailbox message length: 2 words */
> > +#define MBOX_MSG_LEN                   2
> > +
> > +#define MBOX_OFF(m)                    (0x40 * (m))
> > +#define MBOX_SRC_REG(m)                        MBOX_OFF(m)
> > +#define MBOX_DST_REG(m)                        (MBOX_OFF(m) + 0x04)
> > +#define MBOX_DCLR_REG(m)               (MBOX_OFF(m) + 0x08)
> > +#define MBOX_DSTAT_REG(m)              (MBOX_OFF(m) + 0x0C)
> > +#define MBOX_MODE_REG(m)               (MBOX_OFF(m) + 0x10)
> > +#define MBOX_IMASK_REG(m)              (MBOX_OFF(m) + 0x14)
> > +#define MBOX_ICLR_REG(m)               (MBOX_OFF(m) + 0x18)
> > +#define MBOX_SEND_REG(m)               (MBOX_OFF(m) + 0x1C)
> > +#define MBOX_DATA_REG(m, i)            (MBOX_OFF(m) + 0x20 + ((i) << 2))
> > +
> > +#define MBOX_CPU_IMASK(cpu)            (((cpu) << 3) + 0x800)
> > +#define MBOX_CPU_IRST(cpu)             (((cpu) << 3) + 0x804)
> > +#define MBOX_IPC_LOCK                  (0xA00)
> > +
>
> How is this controller different than the PL320?

Sorry for the late replying, I am starting to work on this patch set.

I compared Hi3660 mailbox hardware design with PL320 IPC driver
drivers/mailbox/pl320-ipc.c, below are summary for the difference
between them:

- The register offset is similiar, PL320 IPC driver has one more
  register IPCMxMSTATUS but Hi3660 doesn't have it;

- Hi3660 introduces the ipc lock with offset 0xA00 but PL320 doesn't
  have it;

- They have some conflicts for mailbox channel usage:

  Hi3660 introduces two extra operations:
  Unlocking (so have permission to access the channel)
  Occupying (so can exclusivly access the channel)

  Hi3660 introduces "MBOX_AUTO_ACK" mode, with this mode the kernel
  doesn't wait for acknowledge from remote and directly return back;
  as the first version for this patch I am planning to support this
  mode for CPU clock.

- PL320 registers have different semantics and usage with Hi3660's:

  PL320 register IPCMxMODE (offset 0x10) and Hi3660 register
  MBOX_MODE_REG (offset 0x10) have different semantics; PL320 doesn't
  use IPCMxMODE, but Hi3660 uses MBOX_MODE_REG to set the channel
  working mode (e.g. set "MBOX_AUTO_ACK" mode).

  PL320 register IPCMxMSET (offset 0x14) and Hi3660 register
  MBOX_IMASK_REG (offset 0x14) have different semantics; PL320
  IPCMxMSET is used to set the channel's source and destination,
  Hi3660 MBOX_IMASK_REG is used to mask interrupts for source and
  destination and only clear bit for which master need receive
  interrupt.

Though Hi3660 register definition is close to PL320 driver, but it's
seems hard to combine Hi3660 mailbox driver into PL320 driver
according to the register usage and flow. So I prefer to write one
dedicated Hi3660 mailbox driver.

Jassi, how about you think for this?

Thanks,
Leo Yan
