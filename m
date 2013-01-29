From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 29 Jan 2013 11:37:22 +0200
Subject: [RESEND PATCH v5 4/7] usb: chipidea: consolidate ci_role_driver's
 API for both roles
In-Reply-To: <20130128052158.GA8066@nchen-desktop>
References: <1358733418-17969-1-git-send-email-peter.chen@freescale.com>
 <1358733418-17969-5-git-send-email-peter.chen@freescale.com>
 <8738xqodhp.fsf@ashishki-desk.ger.corp.intel.com>
 <20130125033013.GB29795@nchen-desktop>
 <87sj5pbgwr.fsf@ashishki-desk.ger.corp.intel.com>
 <20130128052158.GA8066@nchen-desktop>
Message-ID: <87vcagmist.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Chen <peter.chen@freescale.com> writes:

> On Fri, Jan 25, 2013 at 02:12:20PM +0200, Alexander Shishkin wrote:
>> Peter Chen <peter.chen@freescale.com> writes:
>> 
>> > On Thu, Jan 24, 2013 at 04:35:30PM +0200, Alexander Shishkin wrote:
>> >> Peter Chen <peter.chen@freescale.com> writes:
>> >> 
>> >> > - Create init/destroy API for probe and remove
>> >> > - start/stop API are only used otg id switch process
>> >> > - Create the gadget at ci_hdrc_probe if the gadget is supported
>> >> > at that port, the main purpose for this is to avoid gadget module
>> >> > load fail at init.rc
>> >> 
>> @@ -402,6 +402,12 @@ static ssize_t store_role(struct device *dev, struct device_attribute *attr,
>>  	if (ret)
>>  		return ret;
>>  
>> +	/*
>> +	 * there won't be an interrupt in case of manual switching,
>> +	 * so we need to check vbus session manually
>> +	 */
>> +	ci_handle_vbus_change(ci);
>> +
> It may not be used as there will be a vbus interrupt.

Not if you write gadget to "role" file.

>>  	return count;
>>  }
>>  
>>  	}
>>  	dbg_remove_files(&ci->gadget.dev);
>>  	device_unregister(&ci->gadget.dev);
>> -	/* my kobject is dynamic, I swear! */
>> -	memset(&ci->gadget, 0, sizeof(ci->gadget));
> Any reason to delete it, another fix?

It is currently like this because start and stop functions are called
multiple times during the devices lifetime. This patch converts the
driver to only call start at driver's probe() and stop at driver's
remove().

>>  }
>>  
>>  /**
>> @@ -1842,13 +1839,11 @@ int ci_hdrc_gadget_init(struct ci13xxx *ci)
>>  	if (!rdrv)
>>  		return -ENOMEM;
>>  
>> -	rdrv->init	= udc_start;
>>  	rdrv->start	= udc_id_switch_for_device;
>>  	rdrv->stop	= udc_id_switch_for_host;
>> -	rdrv->destroy	= udc_stop;
> Where we call udc_start and udc_stop? And the udc_start should only be called
> one time.

ci_hdrc_gadget_init() and ci_hdrc_gadget_destroy(). Look closer at the
patch.

>> 
>> Which is shorter (32 insertions(+), 53 deletions(-)) and makes the main
>> probe easier on the eyes. What do you think?
> OK, not matter how to change it, it needs to cover below things:
> (Covers last email)
> - Gadget needs to be only initialized one time.

Yes, that's what we agreed on and that's what I'm suggesting in the
above patch.

> - Host/device function should be OK when the device on it or
> the usb cable connects to host during the boots up.

Should still work.

> - When the OTG port is at host mode, it should not call any
> register writing operations at gadget's API.

Furthermore, there shouldn't be any calls to the gadget api.

Regards,
--
Alex
