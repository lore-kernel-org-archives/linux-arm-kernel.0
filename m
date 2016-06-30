From: julien.grall@arm.com (Julien Grall)
Date: Thu, 30 Jun 2016 16:33:19 +0100
Subject: [Xen-devel] [PATCH v2] xen/arm: register clocks used by the
 hypervisor
In-Reply-To: <20160630151523.GA29700@leverpostej>
References: <1467282752-14053-1-git-send-email-dirk.behme@de.bosch.com>
 <20160630142136.GE20363@leverpostej> <57753328.9060300@gmail.com>
 <20160630151523.GA29700@leverpostej>
Message-ID: <57753BBF.5000004@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 30/06/16 16:18, Mark Rutland wrote:
> On Thu, Jun 30, 2016 at 04:56:40PM +0200, Dirk Behme wrote:
>> On 30.06.2016 16:21, Mark Rutland wrote:
>>> On Thu, Jun 30, 2016 at 12:32:32PM +0200, Dirk Behme wrote:
>>>> +- clocks: one or more clocks to be registered.
>>>> +  Xen hypervisor drivers might replace native drivers, resulting in
>>>> +  clocks not registered by these native drivers. To avoid that these
>>>> +  unregistered clocks are disabled, then, e.g. by clk_disable_unused(),
>>>> +  register them in the hypervisor node.
>>>> +  An example for this are the clocks of the serial driver. If the clocks
>>>> +  used by the serial hardware interface are not registered by the serial
>>>> +  driver the serial output might stop once clk_disable_unused() is called.
>>>
>>> This shouldn't be described in terms of the Linux implementation details
>>> like clk_disable_unused. Those can change at any time, and don't define
>>> the contract as such.
>>
>> Ok. I remove that from the description. Thanks!
>
> Great, thanks.
>
>>> What exactly is the contract here? I assume that you don't want the
>>> kernel to alter the state of these clocks in any way,
>>
>> I don't think so. I think what we want is that the kernel just don't
>> disable the (from kernel's point of view) "unused" clocks. I think
>> we get this from the fact that using 'clk_ignore_unused' is a
>> working workaround for this issue.
>
> What if the clock (or a parent thereof) is shared with another device?
>
> Surely you don't want that other driver to change the rate (changing the
> rate of the UART behind Xen's back)?
>
> I appreciate that clk_ignore_unused might work on platforms today, but
> that relies on the behaviour of drivers, which might change. It may also
> not work on other platforms in future, in cases like the above.
>
>>> e.g. the rate cannot be changed, they must be left always on, parent
>>> clocks cannot be altered if that would result in momentary jitter.
>>>
>>> I suspect it may be necessary to do more to ensure that, but I'm not
>>> familiar enough with the clocks subsystem to say.
>>>
>>> Are we likely to need to care about regulators, GPIOs, resets, etc? I
>>> worry that this may be the tip of hte iceberg
>>
>> I don't think so. If there is a user in the kernel of the clock,
>> fine. Then hopefully the user in the kernel knows what he is doing
>> with the clock and then he should do what ever he wants.
>
> I'm not sure that's true. A user of the clock may know nothing about
> other users. As far as I can see, nothing prevents it from changing the
> clock rate.
>
> While drivers in the same kernel can co-ordinate to avoid problems such
> as that, we can't do that if we know nothing about the user hidden by
> Xen.
>
>  From looking at the Xen bug tracker, it's not clear which
> platforms/devices this is necessary for, so it's still not clear to me
> if we need to care about regulators, GPIOs, resets, and so on.
>
> Do we know which platforms in particular we need this for?

I believe this is necessary for all the platforms where the UART has a 
clock described in the firmware.

This workaround was first required on the arndale. Note that UART on 
Juno r2 has a clock described but 'clk_ignore_unused' is not necessary. 
I am wondering why it is working.

The number of devices used by Xen is very limited (UART, timer and 
SMMU). However we may also want to consider device passthrough where a 
clock would be handled by another guest.

Regards,

-- 
Julien Grall
