From: rogerq@ti.com (Roger Quadros)
Date: Mon, 15 Jul 2013 11:23:58 +0300
Subject: [PATCH 4/6] mfd: omap-usb-host: Put pins in IDLE state on suspend
In-Reply-To: <51E2A603.1000805@linaro.org>
References: <1373473081-27181-1-git-send-email-rogerq@ti.com>
 <1373473380-27515-1-git-send-email-rogerq@ti.com>
 <51E2A603.1000805@linaro.org>
Message-ID: <51E3B19E.80906@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/14/2013 04:22 PM, Kevin Hilman wrote:
> On 07/10/2013 05:23 PM, Roger Quadros wrote:
>> In order to support wake up from suspend use the pinctrl
>> framework to put the USB host pins in IDLE state during suspend.
>>
>> CC: Samuel Ortiz <sameo@linux.intel.com>
>> Signed-off-by: Roger Quadros <rogerq@ti.com>
> 
> [...]
> 
>> @@ -608,6 +618,14 @@ static int usbhs_omap_probe(struct platform_device *pdev)
>>  		return -ENOMEM;
>>  	}
>>  
>> +	if (!dev->pins || !dev->pins->idle_state) {
>> +		/* If IDLE pins are not available, we can't remote wakeup,
>> +		 * so prevent idling in that case.
>> +		 */
> 
> nit: multi-line comment style
> 
> Also, if there are no pins, aren't the pinctrl ops nops anyways?  IOW,
> not sure the need
> for this is clear, and it's not mentioned in the changelog.

The pinctrl ops are nops but the runtime suspend isn't. So in this case,
we'll never be able to wake up the USB controller.

I'll update the changelog to reflect this.

cheers,
-roger
