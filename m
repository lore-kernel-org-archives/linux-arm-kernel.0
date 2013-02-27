From: paul.gortmaker@windriver.com (Paul Gortmaker)
Date: Wed, 27 Feb 2013 14:57:51 -0500
Subject: [PATCH] usb: limit OMAP related USB options to OMAP2PLUS platforms
In-Reply-To: <20130227195046.GA2300@arwen.pp.htv.fi>
References: <1361992119-2465-1-git-send-email-paul.gortmaker@windriver.com>
 <20130227195046.GA2300@arwen.pp.htv.fi>
Message-ID: <512E653F.1090706@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-02-27 02:51 PM, Felipe Balbi wrote:
> HI,
> 
> On Wed, Feb 27, 2013 at 02:08:39PM -0500, Paul Gortmaker wrote:
>> commit 57f6ce072e35770a63be0c5d5e82f90d8da7d665 ("usb: phy:
>> add a new driver for usb3 phy") added the new Kconfig option
>> OMAP_USB3, but it had no dependencies whatsoever, and hence
>> became available across all arch/platforms.
>>
>> Which presumably caused this to show up in x86 randconfig:
>>
>>     warning: (USB_MUSB_HDRC && OMAP_USB3) selects \
>>         OMAP_CONTROL_USB which has unmet direct \
>>         dependencies (USB_SUPPORT && ARCH_OMAP2PLUS)
>>
>> Then commit 6992819feb39cb9adac72170555d957d07f869f2 ("usb: phy:
>> fix Kconfig warning") was added.  However, this just deleted the
>> ARCH_OMAP2PLUS dependency from OMAP_CONTROL_USB, further
>> compounding the problem by opening up OMAP_CONTROL_USB to
>> all arch/platforms as well.
>>
>> Here we revert the change of 6992819feb to restore the dependency,
>> and add the same ARCH_OMAP2PLUS dependency to the new OMAP_USB3.
>>
>> Perhaps a more platform specific dependency could be chosen for
>> OMAP_USB3, but at least this keeps it from bleeding out to other
>> architectures and non-OMAP ARM platforms as it is currently doing.
>>
>> Cc: Felipe Balbi <balbi@ti.com>
>> Cc: Kishon Vijay Abraham I <kishon@ti.com>
>> Cc: Moiz Sonasath <m-sonasath@ti.com>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
>> ---
>>  drivers/usb/phy/Kconfig | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/usb/phy/Kconfig b/drivers/usb/phy/Kconfig
>> index 65217a5..40b8463 100644
>> --- a/drivers/usb/phy/Kconfig
>> +++ b/drivers/usb/phy/Kconfig
>> @@ -17,6 +17,7 @@ config OMAP_USB2
>>  
>>  config OMAP_USB3
>>  	tristate "OMAP USB3 PHY Driver"
>> +	depends on ARCH_OMAP2PLUS
>>  	select USB_OTG_UTILS
>>  	select OMAP_CONTROL_USB
>>  	help
>> @@ -27,6 +28,7 @@ config OMAP_USB3
>>  
>>  config OMAP_CONTROL_USB
>>  	tristate "OMAP CONTROL USB Driver"
>> +	depends on ARCH_OMAP2PLUS
> 
> I rather not add dependencies here and fix the selections of
> OMAP_CONTROL_USB.

I am not sure I understand what you mean, or why you wouldn't
want sane dependencies in place like those given above.  Perhaps
you can send an alternate patch so there is no ambiguity?

Paul.


> 
