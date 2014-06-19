From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Thu, 19 Jun 2014 10:08:31 -0400
Subject: [PATCH v4 1/6] Documentation: arm: define DT idle states bindings
In-Reply-To: <000001cf8b90$d6a6f090$83f4d1b0$@arm.com>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-2-git-send-email-lorenzo.pieralisi@arm.com>
 <alpine.LFD.2.11.1406111240010.25775@knanqh.ubzr>
 <20140613164954.GA16745@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406131306160.25775@knanqh.ubzr>
 <20140618173648.GB31573@e102568-lin.cambridge.arm.com>
 <53A1E818.6030400@ti.com> <000001cf8b90$d6a6f090$83f4d1b0$@arm.com>
Message-ID: <53A2EEDF.4030403@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Charles,

On Thursday 19 June 2014 03:33 AM, Charles Garcia-Tobin wrote:
> 
> 
>> -----Original Message-----
>> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
>> Sent: 18 June 2014 20:27
>> To: Lorenzo Pieralisi; Nicolas Pitre

[..]

>>> +===========================================
>>> +3 - state node
>>> +===========================================
>>> +
>>> +A state node represents an idle state description and must be
>> defined as
>>> +follows:
>>> +
>>> +- state node
>>> +
>>> +	Description: must be child of the idle-states node
>>> +
>>> +	The state node name shall follow standard device tree naming
>>> +	rules ([5], 2.2.1 "Node names"), in particular state nodes which
>>> +	are siblings within a single common parent must be given a unique
>> name.
>>> +
>>> +	The idle state entered by executing the wfi instruction
>> (idle_standby
>>> +	SBSA,[3][4]) is considered standard on all ARM platforms and
>> therefore
>>> +	must not be listed.
>>> +
>>> +	To correctly specify idle states timing and energy related
>> properties,
>>> +	the following definitions identify the different execution phases
>>> +	a CPU goes through to enter and exit idle states and the implied
>>> +	energy metrics:
>>> +
>>> +
>> 	..__[EXEC]__|__[PREP]__|__[ENTRY]__|__[IDLE]__|__[EXIT]__|__[EXEC]
>> __..
>>> +		    |          |           |          |          |
>>> +
>>> +		    |<------ entry ------->|
>>> +		    |       latency        |
>>> +						      |<- exit ->|
>>> +						      |  latency |
>>> +		    |<-------- min-residency -------->|
>>> +			       |<-------  wakeup-latency ------->|
>>> +
>> I don't know the wakeup latency makes much sense and also correct.
>> Hardware wakeup latency is actually exit latency. Is it for failed
>> or abort-able ilde case ? We are adding this as a new parameter
>> at least from idle states perspective. I think we should just
>> avoid it.
>>
> 
> Hi Santosh, 
> 
> To me wake up latency makes up a lot of sense. It is not always the same as
> exit latency, it will depend on your system, and just how smart it is. In
> some cases the [ENTRY] period may not be negligible in which case exit
> latency will be less than the wake up latency. 
> In addition, it will generally always be shorter than entry+exit which is
> the default value if omitted, this assumes the PREP time is not abortable,
> but this is the safer assumption to make.
> Wake up latency is really the number that folk have in their head for what
> you'd stick into the pm_qos to veto entry into states when you are latency
> constrained. 
> The one thing that really is an optimisation here is having a separate exit
> latency, which is being proposed for use in core selection for the
> scheduler.
> So if anything was going to be made optional pending new scheduler patches
> should that not be entry/exit latency? 
>  
PM QOS angle Nico pointed out and its clear. The wakeup latency as such is a
worst case wakeup latency from QOS perspective so considering the aborted idle
case it makes sense to have conservative number which includes entry + exit.

If you look at current idle governors, only exit latency and target residency
is being used. No matter how we represent it, as long idle governor or idle
C-state selection logic gets that information, things should be fine. So
from that view your point of entry/exit optional makes sense considering
wakeup latency can convey that information indirectly.

Regards,
Santosh
