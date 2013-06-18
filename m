From: rogerq@ti.com (Roger Quadros)
Date: Tue, 18 Jun 2013 11:23:59 +0300
Subject: [PATCH] USB: initialize or shutdown PHY when add or remove host
 controller
In-Reply-To: <20130618080130.GC5461@arwen.pp.htv.fi>
References: <1371539701-11441-1-git-send-email-chao.xie@marvell.com>
 <20130618080130.GC5461@arwen.pp.htv.fi>
Message-ID: <51C0191F.2050104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/18/2013 11:01 AM, Felipe Balbi wrote:
> Hi,
> 
> On Tue, Jun 18, 2013 at 03:15:01AM -0400, Chao Xie wrote:
>> Some controller need software to initialize PHY before add
>> host controller, and shut down PHY after remove host controller.
>> Add the generic code for these controllers so they do not need
>> do it in its own host controller driver.
>>
>> Signed-off-by: Chao Xie <chao.xie@marvell.com>
>> ---
>>  drivers/usb/core/hcd.c |   19 ++++++++++++++++++-
>>  1 files changed, 18 insertions(+), 1 deletions(-)
>>
>> diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
>> index d53547d..b26196b 100644
>> --- a/drivers/usb/core/hcd.c
>> +++ b/drivers/usb/core/hcd.c
>> @@ -43,6 +43,7 @@
>>  
>>  #include <linux/usb.h>
>>  #include <linux/usb/hcd.h>
>> +#include <linux/usb/phy.h>
>>  
>>  #include "usb.h"
>>  
>> @@ -2531,12 +2532,22 @@ int usb_add_hcd(struct usb_hcd *hcd,
>>  	 */
>>  	set_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
>>  
>> +	/* Initialize the PHY before other hardware operation. */
>> +	if (hcd->phy) {
> 
> this looks wrong for two reasons:
> 
> a) you're not grabbing the PHY here.
> 
> 	You can't just assume another entity grabbed your PHY for you.

Isn't that done in the controller drivers e.g. ehci-fsl.c, ohci-omap, etc?
If the controllers don't want HCD core to manage the PHY they can just set it
to some error code.

cheers,
-roger
