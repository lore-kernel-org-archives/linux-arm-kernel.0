From: julien.grall@arm.com (Julien Grall)
Date: Tue, 12 Jul 2016 10:21:12 +0100
Subject: [PATCH v3] xen/arm: enable clocks used by the hypervisor
In-Reply-To: <146799758568.73491.4432005583661196579@resonance>
References: <1467963871-31556-1-git-send-email-dirk.behme@de.bosch.com>
 <577F73B3.8090807@arm.com> <146799758568.73491.4432005583661196579@resonance>
Message-ID: <5784B688.7050903@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On 08/07/16 18:06, Michael Turquette wrote:
> Quoting Julien Grall (2016-07-08 02:34:43)
>> Hi Dirk,
>>
>> On 08/07/16 08:44, Dirk Behme wrote:
>>> Xen hypervisor drivers might replace native OS drivers. The result is
>>> that some important clocks that are enabled by the OS in the non-Xen
>>> case are not properly enabled in the presence of Xen. The clocks
>>> property enumerates the clocks that must be enabled by the Xen clock
>>> consumer.
>>>
>>> An example is a serial driver enabled by the hypervisor. Xen must
>>
>> I would say "An example is the UART used by the hypervisor."
>>
>>> consume and enable these clocks in the OS to ensure behavior continues
>>> after firmware configures the UART hardware and corresponding clock
>>> harder.
>>
>> What do you mean by "harder"?
>>
>> Also, relying on DOM0 to enable the clock looks very wrong to me and you
>> give an example which prove that. The UART will be used before hand by
>> Xen, however it will not be possible to use it if you expect DOM0 to
>> enable the clock (or even modify the clock frequency).
>>
>> The clock should be enabled either by the firmware or Xen. But not DOM0.
>> DOM0 should not touch this clock at all.
>>
>> Furthermore, this property could be used for clock associated to device
>> that will be passthrough-ed to a guest. In this case, the clock would be
>> enabled even if the device is not in use which will result more power
>> consumption.
>
> Is there a need to pass clock references through to guests? If so the
> unmerged CLK_ENABLE_HAND_OFF[0] feature might be useful to you? If this
> flag is set on a given clk, it will be enabled at the time it is
> registered by the clk provider driver, and it's enable_count reference
> counter will be "handed off" to the first consumer that calls clk_get()
> and clk_prepare_enable() on it. This means the clock CAN be gated by
> it's proper driver, but it will be enabled at boot time as well.

Some driver requires to have the clock in hand to be able to configure 
the clock (such as setting the rate). So we would have to find a way to 
let the guest using the clock either by assigning the clock or some PV 
clock driver.

However, platform device passthrough (i.e non-pci device) cannot be done 
generically. The user has to provide a lots of information manually 
(such as MMIO, IRQ, device tree node...). So I am not sure if we want to 
have a generic solution here.

I though it would be worth to mention it because we may (or not) use 
this clock to tell DOM0 (don't touch it).

> This is useful for use cases like splash screens where the bootloader
> configures the display and plays some animation, and we want the linux
> kernel to take over the display controller hardware without cutting
> clocks, blanking or reseting it. Handing off the clock reference count
> helps achieve this.

 From my understanding, any device used by Xen would be in a similar 
situation, although there will be no driver in Linux. The current patch 
(as well as the v4) is calling clk_prepare_enable for each clock used by 
Xen. Could enabling the clock create unexpected behavior such as the 
UART loosing/dropping characters?

Regards,

-- 
Julien Grall
