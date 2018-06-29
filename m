From: sean.wang@mediatek.com (Sean Wang)
Date: Fri, 29 Jun 2018 17:47:26 +0800
Subject: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <20180628051941.GF629@localhost>
References: <cover.1530004712.git.sean.wang@mediatek.com>
 <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
 <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
 <1530155173.29697.48.camel@mtkswgap22> <20180628051941.GF629@localhost>
Message-ID: <1530265646.6245.6.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-06-28 at 07:19 +0200, Johan Hovold wrote:
> On Thu, Jun 28, 2018 at 11:06:13AM +0800, Sean Wang wrote:
> > On Wed, 2018-06-27 at 20:04 +0300, Andy Shevchenko wrote:
> > > On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
> > > <andy.shevchenko@gmail.com> wrote:
> > > > On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
> > > >> From: Sean Wang <sean.wang@mediatek.com>
> 
> > > >> +#include <net/bluetooth/bluetooth.h>
> > > >> +#include <net/bluetooth/hci_core.h>
> > > 
> > > >> +       /* Enable the power domain and clock the device requires. */
> > > >> +       pm_runtime_enable(dev);
> > > >> +       err = pm_runtime_get_sync(dev);
> > > >> +       if (err < 0)
> > > >> +               goto err_pm2;
> 
> > > >> +err_pm1:
> > > >> +       pm_runtime_put_sync(dev);
> > > >> +err_pm2:
> > > >> +       pm_runtime_disable(dev);
> 
> Please name error labels after what they do, not using numbers (see
> CodingStyle). Here you could use err_disable_rpm instead of err_pm2, for
> example.
> 
> Also, if you really want to undo pm_runtime_get_sync() failing above,
> you still need a pm_runtime_put_noidle() to balance the usage count.
> 

I'll give a reasonable naming for these labels and add a
pm_runtime_put_noidle() in the path undoing failing
pm_runtime_get_sync().

> > > >> +struct mtk_stp_hdr {
> > > >> +       __u8 prefix;
> > > >> +       __u8 dlen1:4;
> > > >> +       __u8 type:4;
> > > 
> > > >> +       __u8 dlen2:8;
> > > >> +       __u8 cs;
> > > >> +} __packed;
> 
> Perhaps too much context have been lost here, but unless you're sharing
> this struct with user space, you should be using u8 (without __) above
> (and elsewhere).
> 

These struct don't be shard with user space so I will turn __u8 into u8.

Thanks so much for all suggestions. 

> Johan
