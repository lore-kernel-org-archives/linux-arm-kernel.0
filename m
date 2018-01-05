From: leo.yan@linaro.org (Leo Yan)
Date: Fri, 5 Jan 2018 16:08:55 +0800
Subject: [PATCH v4 2/3] mailbox: Add support for Hi3660 mailbox
In-Reply-To: <CABb+yY2z4jDWJdDY2WRw5Mhv+ArTuvLgqJ9RyVoUJj3O1d=o6A@mail.gmail.com>
References: <1513682145-19892-1-git-send-email-zhongkaihua@huawei.com>
 <1513682145-19892-3-git-send-email-zhongkaihua@huawei.com>
 <CABb+yY2z4jDWJdDY2WRw5Mhv+ArTuvLgqJ9RyVoUJj3O1d=o6A@mail.gmail.com>
Message-ID: <20180105080854.GB26855@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jassi,

On Fri, Jan 05, 2018 at 09:58:57AM +0530, Jassi Brar wrote:
> On Tue, Dec 19, 2017 at 4:45 PM, Kaihua Zhong <zhongkaihua@huawei.com> wrote:
> 
> .....
> > diff --git a/drivers/mailbox/hi3660-mailbox.c b/drivers/mailbox/hi3660-mailbox.c
> > new file mode 100644
> > index 0000000..3ceca40
> > --- /dev/null
> > +++ b/drivers/mailbox/hi3660-mailbox.c
> > @@ -0,0 +1,319 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +// Copyright (c) 2017 Hisilicon Limited.
> > +// Copyright (c) 2017 Linaro Limited.
> 
> A blank here please.

Will fix.

> > +#include <linux/bitops.h>
> > +#include <linux/delay.h>
> > +#include <linux/device.h>
> > +#include <linux/err.h>
> > +#include <linux/interrupt.h>
> > +#include <linux/io.h>
> > +#include <linux/iopoll.h>

Will add blank.

> .....
> > +
> > +static inline struct hi3660_mbox *to_hi3660_mbox(struct mbox_controller *mbox)
> >
> inline in .c is out of fasion these days

Will remove 'inline'.

> > +{
> > +       return container_of(mbox, struct hi3660_mbox, controller);
> > +}
> > +
> 
> ....
> > +
> > +static int hi3660_mbox_startup(struct mbox_chan *chan)
> > +{
> > +       int ret;
> > +
> > +       ret = hi3660_mbox_check_state(chan);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = hi3660_mbox_unlock(chan);
> > +       if (ret)
> > +               return ret;
> > +
> > +       ret = hi3660_mbox_acquire_channel(chan);
> > +       if (ret)
> > +               return ret;
> > +
> > +       return 0;
> > +}
> Do you not need to do "release channel" for shutdown() ?

>From my testing, the driver don't need "release channel" operations.

> .....
> > +
> > +static int hi3660_mbox_send_data(struct mbox_chan *chan, void *msg)
> > +{
> > +       return hi3660_mbox_send(chan, msg);
> >
> Please directly have hi3660_mbox_send as .send_data

Will fix.

Thanks,
Leo Yan
