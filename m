From: deepak.sikri@st.com (deepaksi)
Date: Thu, 9 Sep 2010 09:47:54 +0530
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100908151232.GD32659@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
	<4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
	<4C84D6B3.80104@st.com>
	<20100908151232.GD32659@n2100.arm.linux.org.uk>
Message-ID: <4C885FF2.7060201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/8/2010 8:42 PM, Russell King - ARM Linux wrote:
> On Mon, Sep 06, 2010 at 05:25:31PM +0530, deepaksi wrote:
>   
>> On 9/3/2010 1:04 PM, Russell King - ARM Linux wrote:
>>     
>>> So how are wakeup sources configured if this callback does nothing?
>>> .
>>>       
>> In most of the architectures that I could refer across(including SPEAr
>> family -SPEAr13xx),
>> have a separate power management unit(PMU) which is required to be
>> configured to define the wake
>> up sources. The PMU takes care of waking up the system from sleep, as
>> and when the wake up
>> interrupts are triggered. This routing is independent of GIC, and hence
>> the handling was not added.
>>
>> Contrary to that, in some of our hardware architecture using VIC
>> (including SPEAr 3xx/6xx), there
>> was no explicit PMU, and the wake up trigger was exclusively done
>> through VIC, and hence the VIC
>> call backs had the necessary implementation.
>>     
> What I read into this is that you're using enable_irq_wake() in your
> drivers _and_ another mechanism to configure what wakes up the system
> via the PMU - maybe with drivers explicitly calling out to the PMU
> to achieve this?
>   

This is even true for the drivers already in the kernel for example
stmmac driver ( using synopsis GMAC core): drivers/net/stmmac/
if we don not check for the return type, then probably it makes sense to
remove the dunny handlers, else another alternative could be to modify
the enable_irq_wake() call, to return the proper values.

Changing the driver specific to SPEAr is fine, but SPEAr platform does
uses the existing drivers in the kernel.


> This sounds a little haphazard, especially from the drivers point of
> view.  Surely there's a more sensible solution to this rather than
> adding do-nothing irq_wake support?
> .
>
>   
How do you recommend to go about this ?
