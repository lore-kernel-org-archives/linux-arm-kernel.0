From: b-cousson@ti.com (Cousson, Benoit)
Date: Thu, 19 Apr 2012 21:14:37 +0200
Subject: [PATCH v2 4/8] ARM: OMAP2+: hwmod: revise hardreset behavior
In-Reply-To: <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
References: <20120228053524.16278.59430.stgit@dusk>
 <20120228053654.16278.73632.stgit@dusk>
 <alpine.DEB.2.00.1204182253550.29048@utopia.booyaka.com>
 <4F90001E.8060201@ti.com>
 <alpine.DEB.2.00.1204191050110.29048@utopia.booyaka.com>
Message-ID: <4F90641D.3090208@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 4/19/2012 7:17 PM, Paul Walmsley wrote:
> Hi Beno?t,
>
> On Thu, 19 Apr 2012, Cousson, Benoit wrote:
>
>> The concern of the people doing SW in these embedded processors was mainly
>> because we were releasing the reset of processor without loading any SW first
>> and thus the processor was executing some random instructions.
>>
>> So if we consider a better hwmods definition, we can potentially fix the MMU
>> case:
>>
>>      'mmu_ipu':
>>          'rst_ipu_mmu_cache'
>>
>>      'mmu_dsp':
>>          'rst_dsp_mmu_cache'
>>
>>      'iva_config':
>>          'rst_logic'
>
> Wouldn't these still be "pseudo-hwmods?"  Or do each of these actually
> have address space, interconnect ports, etc.?

Yes, these ones are the only real IPs for MPU stand point, with 
interconnect port and configuration registers.

> Another approach that might not require defining pseudo-hwmods is to
> define a per-hard-reset-line flag that could be used to alter the way the
> hwmod code handles the hardreset line.

Yes, I think this is what Rajendra proposed long time ago...

>> But then we do have the processor resets that have to be exposed somewhere.
>>
>>      'ipu':
>>          'rst_cpu0'
>>          'rst_cpu1'
>>
>>      'dsp':
>>          'rst_dsp'
>>
>>      'iva':
>>          'rst_seq1'
>>          'rst_seq2'
>>
>> None of these one should be controlled automatically.
>
> Don't we still want to put these IP blocks into reset until a driver for
> these IP blocks is loaded?

Yes, indeed, my point is where are we going to declare these reset lines 
if we do not have any fake hwmods to store them.

>>>    	/*
>>> -	 * If an IP contains HW reset lines, then de-assert them in order
>>> -	 * to allow the module state transition. Otherwise the PRCM will
>>> return
>>> -	 * Intransition status, and the init will failed.
>>> +	 * If an IP block contains HW reset lines and any of them are
>>> +	 * asserted, we let integration code associated with that
>>> +	 * block handle the enable.  We've received very little
>>> +	 * information on what those driver authors need, and until
>>> +	 * detailed information is provided and the driver code is
>>> +	 * posted to the public lists, this is probably the best we
>>> +	 * can do.
>>
>> Maybe we should keep that with some mechanism to prevent it for some IP like
>> processors .
>>
>> I guess that with that patch, we cannot enable anymore IPU/DSP and IVA at boot
>> time.
>
> I am probably misunderstanding your comment, but I don't think there's any
> way at the moment to generically enable those IP blocks without driver
> integration code assistance.

Well, for the MMU we can, these are regular IPs (almost). The real 
issues was for the processors.

> If we leave the hardreset lines asserted in _enable(), then the PRCM
> status for those modules will be stuck in In-transition state, according
> to the previous comments in the code.  I think this will block PM idle
> transitions.  Also we have no way to restore the clockdomain idle settings
> during the second part of the hwmod enable sequence, I think, since it
> will need to be executed by driver integration code :-(
>
> And I don't think we can deassert the hardreset lines in _enable() right
> now, for the reason that you mentioned in your message: unless the driver
> integration code implements a custom reset function, we don't have any way
> to load code into the IP block before deasserting the hardreset.

Fully agree, what I was trying to highlight is that we do have two types 
of hardreset here: the processors ones and the MMU / Logic ones.
Only the processors do require some special management because a 
firmware has to be loaded first.

> So at this point I'd propose that we encourage these driver authors to
> implement custom reset functions for their IP blocks that load firmware if
> needed, and put them into idle, similar to what omap3_iva_idle() does in
> mach-omap2/pm34xx.c.  If the custom reset function takes the IP block out
> of hardreset, then the subsequent hwmod enable/idle/shutdown calls should
> work, after this patch.

First they will have to release their driver :-)

Regards,
Benoit
