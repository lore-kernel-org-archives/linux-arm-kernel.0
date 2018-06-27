From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 27 Jun 2018 20:04:19 +0300
Subject: [PATCH v4 6/7] Bluetooth: mediatek: Add protocol support for
 MediaTek serial devices
In-Reply-To: <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
References: <cover.1530004712.git.sean.wang@mediatek.com>
 <48215a1276c36af7ad581c3d83759fe9f55e3c4b.1530004712.git.sean.wang@mediatek.com>
 <CAHp75VehTeyyzR4bPKK3hFDTVqZnhdNy5vcBFJCSH_Zrx+QrKA@mail.gmail.com>
Message-ID: <CAHp75VedHLw52J_ymh3iYf2w=r8d+Kqg=fJZmBGnaCrEbNEPdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 7:59 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Wed, Jun 27, 2018 at 8:43 AM,  <sean.wang@mediatek.com> wrote:
>> From: Sean Wang <sean.wang@mediatek.com>
>>
>
>> +config BT_HCIBTUART_MTK
>> +       tristate "MediaTek HCI UART driver"
>> +       depends on BT_HCIBTUART
>
>> +       default y
>
> Perhaps it's an overkill for users which would like to have less
> amount on stuff in kernel.
>
>
>> +#include <asm/unaligned.h>
>> +#include <linux/atomic.h>
>> +#include <linux/clk.h>
>> +#include <linux/firmware.h>
>> +#include <linux/module.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/serdev.h>

Perhaps alphabetically ordered?

+ blank line.

>
>> +#include <net/bluetooth/bluetooth.h>
>> +#include <net/bluetooth/hci_core.h>

>> +       /* Enable the power domain and clock the device requires. */
>> +       pm_runtime_enable(dev);
>> +       err = pm_runtime_get_sync(dev);
>> +       if (err < 0)
>> +               goto err_pm2;

Should be err_pm1 here.
Yes, that's correct.

>> +err_pm1:
>> +       pm_runtime_put_sync(dev);
>> +err_pm2:
>> +       pm_runtime_disable(dev);

>> +#define MTK_WMT_CMD_SIZE       (MTK_WMT_HDR_SIZE + MTK_STP_HDR_SIZE + \
>> +                                MTK_STP_TLR_SIZE + HCI_ACL_HDR_SIZE)

It would look slightly better if you start on new line like
#define FOO \
 (BAR + BAZ)

>> +struct mtk_stp_hdr {
>> +       __u8 prefix;
>> +       __u8 dlen1:4;
>> +       __u8 type:4;

>> +       __u8 dlen2:8;

u8 already 8 bit.

>> +       __u8 cs;
>> +} __packed;

-- 
With Best Regards,
Andy Shevchenko
