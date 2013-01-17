From: rogerq@ti.com (Roger Quadros)
Date: Thu, 17 Jan 2013 11:12:20 +0200
Subject: [PATCH v6 03/22] mfd: omap-usb-tll: Use devm_kzalloc/ioremap
 and clean up error path
In-Reply-To: <50F70164.3080105@mvista.com>
References: <1358347433-329-1-git-send-email-rogerq@ti.com>
 <1358347433-329-4-git-send-email-rogerq@ti.com> <50F70164.3080105@mvista.com>
Message-ID: <50F7C074.5070803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/16/2013 09:37 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 01/16/2013 05:43 PM, Roger Quadros wrote:
> 
>> Use devm_ variants of kzalloc() and ioremap(). Simplify the error path.
> 
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
>> ---
>>  drivers/mfd/omap-usb-tll.c |   36 +++++++++++-------------------------
>>  1 files changed, 11 insertions(+), 25 deletions(-)
> 
>> diff --git a/drivers/mfd/omap-usb-tll.c b/drivers/mfd/omap-usb-tll.c
>> index 9658e18..53ed10b 100644
>> --- a/drivers/mfd/omap-usb-tll.c
>> +++ b/drivers/mfd/omap-usb-tll.c
> [...]
>> -	base = ioremap(res->start, resource_size(res));
>> +	base = devm_request_and_ioremap(dev, res);
>>  	if (!base) {
>> -		dev_err(dev, "TLL ioremap failed\n");
>>  		ret = -ENOMEM;
> 
>    -EADDRNOTAVAIL as the comment to devm_request_and_ioremap() suggests.
> 

I changed it deliberately to ENOMEM, as I could not find EADDRNOTAVAIL
defined in all architectures.

ENOMEM shouldn't harm.

cheers,
-roger
