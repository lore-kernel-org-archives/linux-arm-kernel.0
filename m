From: michal.simek@xilinx.com (Michal Simek)
Date: Thu, 19 Mar 2015 14:19:01 +0100
Subject: [PATCH v2] ARM: zynq: use restart_handler mechanism for slcr reset
In-Reply-To: <20150319124414.GG24619@jcartwri.amer.corp.natinst.com>
References: <1425049769-24929-1-git-send-email-joshc@ni.com>
 <BL2FFO11OLC004560F6047881E93573D75E2010@BL2FFO11OLC004.protection.gbl>
 <20150319124414.GG24619@jcartwri.amer.corp.natinst.com>
Message-ID: <BN1BFFO11FD008F29B247339CE49EAEA6AE2010@BN1BFFO11FD008.protection.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 01:44 PM, Josh Cartwright wrote:
> On Thu, Mar 19, 2015 at 11:44:23AM +0100, Michal Simek wrote:
>> On 02/27/2015 04:09 PM, Josh Cartwright wrote:
> [..]
>>> +++ b/arch/arm/mach-zynq/slcr.c
>>> @@ -15,6 +15,7 @@
>>>   */
>>>  
>>>  #include <linux/io.h>
>>> +#include <linux/reboot.h>
>>>  #include <linux/mfd/syscon.h>
>>>  #include <linux/of_address.h>
>>>  #include <linux/regmap.h>
>>> @@ -91,10 +92,9 @@ u32 zynq_slcr_get_device_id(void)
>>>  	return val;
>>>  }
>>>  
>>> -/**
>>> - * zynq_slcr_system_reset - Reset the entire system.
>>> - */
>>> -void zynq_slcr_system_reset(void)
>>> +static
>>> +int zynq_slcr_system_restart(struct notifier_block *nb,
>>> +			     unsigned long action, void *data)
>>>  {
>>
>> First of all sorry for delay.
> 
> No problem.  I suspect ZynqMP is keeping you busy.

yes.

> 
>> Any reason to remove kernel-doc format?
> 
> It didn't seem to provide anything meaningful, as it was just a
> restatement of the function name, and since this function has become
> static, it makes even less sense.

Even static function can do something interesting. The whole file
is using kernel-doc that's why please also keep it here. If any function
misses it then it is just a bug.


>> The rest looks good and I have also tested it.
> 
> Great!
> 
>> BTW: was also thinking about syscon-reboot option but it doesn't fit to
>> our reset sequence. :-(
> 
> Because of the code that handles this?

yep

> 
> 	/*
> 	 * Clear 0x0F000000 bits of reboot status register to workaround
> 	 * the FSBL not loading the bitstream after soft-reboot
> 	 * This is a temporary solution until we know more.
> 	 */
> 
> Has this FSBL bug been addressed?

To be honest the problem is that there could be users in the field which uses
old fsbl and will start to deal with this problem.

> 
> I suspect we could also drop the zynq_slcr_unlock() as well...we unlock
> the SLCR early at boot and don't lock it, AFAICT.

yes - it can be removed. SLCR are already unlocked and this is just useless.

> 
> With those two pieces dropped, I think we'd fit the syscon-reboot model.

yep - but unfortunately I don't think we can remove the first part.

Thanks,
Michal
