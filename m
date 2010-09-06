From: deepak.sikri@st.com (deepaksi)
Date: Mon, 6 Sep 2010 17:25:31 +0530
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100903073421.GF26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
	<4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
Message-ID: <4C84D6B3.80104@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/3/2010 1:04 PM, Russell King - ARM Linux wrote:
> On Fri, Sep 03, 2010 at 11:54:06AM +0530, deepaksi wrote:
>   
>> On 9/2/2010 3:53 PM, Russell King - ARM Linux wrote:
>>     
>>> On Mon, Aug 30, 2010 at 04:09:12PM +0530, Viresh KUMAR wrote:
>>>   
>>>       
>>>> From: Deepak Sikri <deepak.sikri@st.com>
>>>>
>>>>     
>>>>         
>>> The reason being?
>>>
>>>   
>>>       
>> For configuring the wake up sources ( normally in the PM framework for
>> suspend resume operations), you need to use the following set of api
>> enable_irq_wake(). This handler has a appropriate callback for the vic,
>> similar to the plugin that we have added in for gic which does enable
>> the wake interrupt sources only. But since gic handler did not had this
>> call back associated was always returning -ENXIO, which was breaking the
>> existing drivers. In case no checks are provided for the return value of 
>> enable_irq_wake(), the things were fine.
>>     
> So how are wakeup sources configured if this callback does nothing?
> .
>
>   
In most of the architectures that I could refer across(including SPEAr
family -SPEAr13xx),
have a separate power management unit(PMU) which is required to be
configured to define the wake
up sources. The PMU takes care of waking up the system from sleep, as
and when the wake up
interrupts are triggered. This routing is independent of GIC, and hence
the handling was not added.

Contrary to that, in some of our hardware architecture using VIC
(including SPEAr 3xx/6xx), there
was no explicit PMU, and the wake up trigger was exclusively done
through VIC, and hence the VIC
call backs had the necessary implementation.
