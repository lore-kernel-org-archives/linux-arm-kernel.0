From: sean.wang@mediatek.com (Sean Wang)
Date: Sun, 15 Jul 2018 15:52:14 +0800
Subject: [PATCH v5 5/7] Bluetooth: Extend btuart driver for join more
 vendor devices
In-Reply-To: <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
References: <cover.1531150733.git.sean.wang@mediatek.com>
 <85d449cdd34bf47d72935a821915e825c64a2145.1531150733.git.sean.wang@mediatek.com>
 <70616B99-5A2D-417A-8815-246700EEF4E2@holtmann.org>
Message-ID: <1531641134.3955.19.camel@mtkswgap22>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2018-07-14 at 18:44 +0200, Marcel Holtmann wrote:
> Hi Sean,
> 
> > Adding an independent btuart.h header allows these essential definitions
> > can be reused in vendor driver. Also, struct btuart_vnd is extended with
> > additional callbacks such as .init initializing vendor data, .shtudown,
> > .recv and .send supporting SoC specific framing for that btuart can
> > simply adapt to various Bluetooth uart-based devices.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> > drivers/bluetooth/btuart.c | 73 ++++++++++++++++++++++++----------------------
> > drivers/bluetooth/btuart.h | 30 +++++++++++++++++++
> > 2 files changed, 68 insertions(+), 35 deletions(-)
> > create mode 100644 drivers/bluetooth/btuart.h
> > 
> > diff --git a/drivers/bluetooth/btuart.c b/drivers/bluetooth/btuart.c
> > index a900aac..65d0086 100644
> > --- a/drivers/bluetooth/btuart.c
> > +++ b/drivers/bluetooth/btuart.c
> > @@ -33,35 +33,11 @@
> > #include <net/bluetooth/hci_core.h>
> > 
> > #include "h4_recv.h"
> > +#include "btuart.h"
> > #include "btbcm.h"
> > 
> > #define VERSION "1.0"
> > 
> > -struct btuart_vnd {
> > -	const struct h4_recv_pkt *recv_pkts;
> > -	int recv_pkts_cnt;
> > -	unsigned int manufacturer;
> > -	int (*open)(struct hci_dev *hdev);
> > -	int (*close)(struct hci_dev *hdev);
> > -	int (*setup)(struct hci_dev *hdev);
> > -};
> > -
> > -struct btuart_dev {
> > -	struct hci_dev *hdev;
> > -	struct serdev_device *serdev;
> > -
> > -	struct work_struct tx_work;
> > -	unsigned long tx_state;
> > -	struct sk_buff_head txq;
> > -
> > -	struct sk_buff *rx_skb;
> > -
> > -	const struct btuart_vnd *vnd;
> > -};
> 
> I really like to avoid this since it is not clean. Frankly I prefer to keep the btuart.c driver for drivers that really just use H:4 as transport protocol. If the protocol is only H:4 alike and has extra headers, then it should be a separate driver.
> 

thanks for letting me know your concern. I think I'm a little over in reusing these existing methods and break something generic and its beauty.

I'll make the driver be a separate one based on btuart in the next version.


> The common H:4 handling is abstracted in h4_recv.h already anyway and we can add more pieces if needed. However I also wonder since you have extra framing that the complex H:4 state keeping might be not needed at all. So it could be simplified.
> 

okay, I will get rid of h4_recv.h and consider to use more simplified logic to handle the extra framing and its payload.

> Regards
> 
> Marcel


> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
