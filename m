From: felipe.balbi@linux.intel.com (Felipe Balbi)
Date: Tue, 03 May 2016 10:51:53 +0300
Subject: [PATCH] usb: xhci-mtk: fixup mouse wakeup failure during system
 suspend
In-Reply-To: <1462261458.11651.7.camel@mhfsdcap03>
References: <1461204293-18243-1-git-send-email-chunfeng.yun@mediatek.com>
 <1462261458.11651.7.camel@mhfsdcap03>
Message-ID: <87vb2vfujq.fsf@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

chunfeng yun <chunfeng.yun@mediatek.com> writes:
> On Thu, 2016-04-21 at 10:04 +0800, Chunfeng Yun wrote:
>> Click mouse after xhci suspend completion but before system suspend
>> completion, system will not be waken up by mouse if the duration of
>> them is larger than 20ms which is the device UFP's resume signaling

what is "them" here ? The duration of what is longer than 20ms ?

>> lasted. Another reason is that the SPM is not enabled before system

what's SPM ?

>> suspend compeltion, this causes SPM also not notice the resume signal.
           ^^^^^^^^^^
           completion

>> So in order to reduce the duration less than 20ms, make use of
>> syscore's suspend/resume interface.

no, this is the wrong approach

>> In fact it is a work around solution which only reduces the
>> probability of failure, because we can't ensure that the duration from
>> syscore's suspend completion to SPM working is always less than 20ms.

right, which means you're not really fixing anything. Morevoer, you make
it so that this won't work with multiple instances of the XHCI IP in
your SoC.

>> Because the syscore runs on irq disabled context, and xhci's
>> suspend/resume calls some sleeping functions, enable local irq
>> and then disable it during suspend/resume. This may be not a problem,
>> since only boot CPU is runing.

another problem :) calling local_irq_{enable,disable}() is an indication
that something's wrong.

>> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
>> ---
>>  drivers/usb/host/xhci-mtk.c |   31 ++++++++++++++++++++++++++++++-
>>  1 file changed, 30 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
>> index 79959f1..8277f02 100644
>> --- a/drivers/usb/host/xhci-mtk.c
>> +++ b/drivers/usb/host/xhci-mtk.c
>> @@ -28,6 +28,7 @@
>>  #include <linux/pm_runtime.h>
>>  #include <linux/regmap.h>
>>  #include <linux/regulator/consumer.h>
>> +#include <linux/syscore_ops.h>
>>  
>>  #include "xhci.h"
>>  #include "xhci-mtk.h"
>> @@ -490,6 +491,8 @@ static int xhci_mtk_setup(struct usb_hcd *hcd)
>>  	return xhci_gen_setup(hcd, xhci_mtk_quirks);
>>  }
>>  
>> +static struct device *xhci_mtk_syscore_dev;

now, what happens when you have more than one XHCI instance ?

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160503/58d632ac/attachment.sig>
