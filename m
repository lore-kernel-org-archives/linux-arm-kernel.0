From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 21 May 2013 17:27:20 +0800
Subject: [PATCH] arm64: kernel: compiling issue,
 need 'EXPORT_SYMBOL_GPL(read_current_timer)'
In-Reply-To: <20130521085325.GB10453@mudshark.cambridge.arm.com>
References: <5199C725.8050102@asianux.com>
 <168084c28e8ba5124c05553e97463172@localhost>
 <20130520095606.GH31359@mudshark.cambridge.arm.com>
 <519AF2DC.2040200@asianux.com>
 <20130521085325.GB10453@mudshark.cambridge.arm.com>
Message-ID: <519B3DF8.9060902@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/21/2013 04:53 PM, Will Deacon wrote:
> On Tue, May 21, 2013 at 05:06:52AM +0100, Chen Gang wrote:
>> On 05/20/2013 05:56 PM, Will Deacon wrote:
>>> Should be ok once the arch timer driver has moved exclusively to virtual
>>> time. I'm also not sure we even need to implement read_current_timer() --
>>> it's only used for delay-loop calibration, which we don't need for the
>>> arch timer.
>>>
>>
>> For whether we need implement read_current_timer():
>>
>>   many platforms have implemented it (openrisc, arm, sparc, hexagon, avr32, x86).
>>   it is called by init/calibrate.c when 'ARCH_HAS_READ_CURRENT_TIMER' is defined.
>>   since arm64 can implement it, better to provide it as an architect features to let outside use.
> 
> No, that code is not needed on arm64 because we calibrate the delay loop
> statically using a known timer frequency.
> 
>> For the implementation of read_current_timer():
>>
>>   it has to face various configurations
>>     (e.g. CONFIG_ARM_ARCH_TIMER, arch_timer_read_zero, arch_counter_get_cntvct, arch_counter_get_cntpct)
>>   so better still use variable instead of.
>>     (excuse me, I do not know what is 'CNTVCT_EL0', is it like a constant number ?)
> 
> cntvct_el0 is a system register, which provides the virtual counter value.
> 
>> For the implementation of get_cycles()
>>
>>   if read_current_timer() is provided,
>>   better to let get_cycles() to call it, instead of implement once again.
> 
> You can implement it as a macro if you like, I'm just suggesting that we
> might not need read_current_timer after all.
> 
> Will
> 
> 

Thanks, I should try patch v2.  :-)

-- 
Chen Gang

Asianux Corporation
