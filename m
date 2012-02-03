From: khilman@ti.com (Kevin Hilman)
Date: Fri, 03 Feb 2012 10:41:01 -0800
Subject: [PATCH RFC idle 2/3] arm: Avoid invoking RCU when CPU is idle
In-Reply-To: <4F2B1307.5010207@gmail.com> (Rob Herring's message of "Thu, 02
 Feb 2012 16:49:43 -0600")
References: <20120202004253.GA10946@linux.vnet.ibm.com>
 <1328143404-11038-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <1328143404-11038-2-git-send-email-paulmck@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202012234050.2759@xanadu.home>
 <20120202044439.GD2435@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021159560.2759@xanadu.home>
 <20120202174337.GS2518@linux.vnet.ibm.com>
 <alpine.LFD.2.02.1202021257340.2759@xanadu.home>
 <20120202190708.GE2518@linux.vnet.ibm.com> <87obtgc1xx.fsf@ti.com>
 <4F2B1307.5010207@gmail.com>
Message-ID: <87k4437oaq.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rob Herring <robherring2@gmail.com> writes:

> On 02/02/2012 04:20 PM, Kevin Hilman wrote:
>> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> writes:
>> 
>> [...]
>> 
>>>>> The two options I see are:
>>>>>
>>>>> 1.	Rip tracing out of the inner idle loops and everything that
>>>>> 	they invoke.
>>>>
>>>> What I suggested above.  But as I said I know sh*t about that tracing 
>>>> implementation so that's an easy suggestion for me to make.
>>>
>>> Works for me as well.  ;-)
>> 
>> While I must admit not having a better suggestion, I for one would vote
>> strongly against removing tracing from the idle path.
>> 
>> Being a PM developer and maintainer, much of the code I work on and
>> maintain happens to be run in the bowels of the idle path.  Not having
>> the ability to trace this code would be a major step backwards IMO.
>
> How is it a step backwards if it is already broken. 

Well, I didn't know it was broken. ;) And, as Paul mentioned, this has
been broken for a long time. Apparently it's been working well enough
for nobody to notice until recently.

> Obviously you haven't actually used any tracing here because it
> doesn't work right with things as is.

It's been working well enough for me to debug several idle path problems
with tracing.  Admittedly, this has been primarily on UP systems, but
I've recently started using the tracing on SMP as well.  (however, due
to "coupled" low-power states on OMAP, large parts of the idle path are
effectively UP since one CPU0 has to wait for CPU1 to hit a low-power
state before it can.)

> What exactly do you want to trace at this level. By the point you are in
> this code, the path is somewhat known and problems you have are likely
> h/w issues. 

Not really. 

There is still quite a bit of software between the decision to enter
idle and the hardware taking over.  On OMAP for example, we have power
domains, clock domains and clocks that are managed during idle, and
these layers contain tracepoints.

Add to that the runtime PM management of some devices that are coupled
to the CPU (because they share a power domain, etc).  Runtime PM
contains tracepoints.

Add to that possible voltage scaling during idle using regulators.
Regulator framework has tracepoints.

That can lead to quite a bit of tracing info *after* the decision to
enter idle.

> If you are trying to go thru a very precise sequence of
> saving cpu state and flushing caches, you don't want calls out to
> tracing code that could very easily change the behavior.

I'm more worried about the power domain and voltage domain transitions
(or lack thereof) when trying to debug why a particular low-power state
was not hit.

Kevin
