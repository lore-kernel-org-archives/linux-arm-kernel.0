From: sean.wang@mediatek.com (Sean Wang)
Date: Thu, 28 Jun 2018 11:06:13 +0800
Subject: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com>
 <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
 <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
Message-ID: <1530155173.29697.48.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2018-06-27 at 20:04 +0300, Andy Shevchenko wrote:
> On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> >> From: Sean Wang <sean.wang@mediatek.com>
> >>
> >
> >> +config BT_HCIBTUART_MTK
> >> +       tristate "MediaTek HCI UART driver"
> >> +       depends on BT_HCIBTUART
> >
> >> +       default y
> >
> > Perhaps it's an overkill for users which would like to have less
> > amount on stuff in kernel.
> >

Sure, the default y will be removed

> >
> >> +#include <asm/unaligned.h>
> >> +#include <linux/atomic.h>
> >> +#include <linux/clk.h>
> >> +#include <linux/firmware.h>
> >> +#include <linux/module.h>
> >> +#include <linux/pm_runtime.h>
> >> +#include <linux/serdev.h>
> 
> Perhaps alphabetically ordered?
> 

They seem already in alphabetically ordered

> + blank line.
> 

A blank line will be added here

> >
> >> +#include <net/bluetooth/bluetooth.h>
> >> +#include <net/bluetooth/hci_core.h>
> 
> >> +       /* Enable the power domain and clock the device requires. */
> >> +       pm_runtime_enable(dev);
> >> +       err = pm_runtime_get_sync(dev);
> >> +       if (err < 0)
> >> +               goto err_pm2;
> 
> Should be err_pm1 here.

Label err_pm1 and err_pm2 can be swapped for the readability and this
doesn't have any effect on the logic.

> Yes, that's correct.
> 
> >> +err_pm1:
> >> +       pm_runtime_put_sync(dev);
> >> +err_pm2:
> >> +       pm_runtime_disable(dev);
> 
> >> +#define MTK_WMT_CMD_SIZE       (MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
> >> +                                MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)
> 
> It would look slightly better if you start on new line like
> #define FOO \
>  (BAR + BAZ)
> 

Thanks for your pointing out. I also found that the macro is not being
used by anyone, it can be removed freely.

> >> +struct mtk_stp_hdr {
> >> +       __u8 prefix;
> >> +       __u8 dlen1:4;
> >> +       __u8 type:4;
> 
> >> +       __u8 dlen2:8;
> 
> u8 already 8 bit.
> 

the superfluous :8 for dlen2 will be removed

> >> +       __u8 cs;
> >> +} __packed;
> 
