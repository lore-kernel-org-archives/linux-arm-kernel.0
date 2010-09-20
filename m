From: robherring2@gmail.com (Rob Herring)
Date: Mon, 20 Sep 2010 11:55:50 -0500
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <20100920150749.GF30793@n2100.arm.linux.org.uk>
References: <47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
	<4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
	<4C84D6B3.80104@st.com>
	<20100908151232.GD32659@n2100.arm.linux.org.uk>
	<4C885FF2.7060201@st.com> <4C976541.6000203@st.com>
	<20100920134808.GD30793@n2100.arm.linux.org.uk>
	<4C97760A.60404@gmail.com>
	<20100920150749.GF30793@n2100.arm.linux.org.uk>
Message-ID: <4C979216.3000706@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 09/20/2010 10:07 AM, Russell King - ARM Linux wrote:
> On Mon, Sep 20, 2010 at 09:56:10AM -0500, Rob Herring wrote:
>> On 09/20/2010 08:48 AM, Russell King - ARM Linux wrote:
>>> On Mon, Sep 20, 2010 at 07:14:33PM +0530, deepaksi wrote:
>>>> I request you to provide some more inputs on this, so that we can close
>>>> the issue.
>>>
>>> I don't know, especially so without seeing the drivers.
>>
>> Assuming there is no powergating of the GIC, then this patch should be
>> sufficient depending on one question.
>
> The GIC provides no wakeup capabilities.  Providing a dummy 'set_wake'
> function means that driver authors will expect a successful
> enable_irq_wake() to work - when it results in precisely nothing
> being done.

There is no programming distinction between an irq and an wakeup if the 
GIC is powered on in suspend which is platform dependent. It is only a 
s/w distinction of what interrupts you allow to wake you up. If GIC 
remains powered, then it can assert nirq to the core and wake-up. If the 
core is powered down, the external power controller can monitor the NIRQ 
line to wake-up the core. So the powergating of the core has no impact 
on the prvgramming of the GIC for wake-up.

>
> With the situation described, what I envisage is drivers doing something
> like:
>
> 	err = enable_irq_wake(irq);
> 	if (err == 0) {
> 		/* everything is fine, don't need to do anything else */
> 	} else if (err == -ENXIO) {
> 		/* IRQ controller doesn't support wakeups, try something else */
> 	} else {
> 		/* an error occurred trying to enable wakeups */
> 	}
>
> If we go around adding dummy set_irq_wake functions to IRQ controllers
> which don't support wakeup, then there's no way for drivers to know
> this, and there is no method (other than by #ifdeffery) for them to
> sort out this mess.

How about adding a set_wake function ptr as a parameter to 
gic_dist_init? If a platform needs more than the basic operation, they 
can override it.

It doesn't make sense to push the platform dependent behavior of an 
interrupt controller into the drivers. enable_irq_wake is the defined 
way to enable wakeup. Why suggest drivers implement a custom interface 
for that? That will introduce ifdeffery in common drivers like ARM 
Primecell blocks.

Rob
