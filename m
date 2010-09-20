From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 20 Sep 2010 16:07:49 +0100
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <4C97760A.60404@gmail.com>
References: <47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
	<4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
	<4C84D6B3.80104@st.com>
	<20100908151232.GD32659@n2100.arm.linux.org.uk>
	<4C885FF2.7060201@st.com> <4C976541.6000203@st.com>
	<20100920134808.GD30793@n2100.arm.linux.org.uk>
	<4C97760A.60404@gmail.com>
Message-ID: <20100920150749.GF30793@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 20, 2010 at 09:56:10AM -0500, Rob Herring wrote:
> On 09/20/2010 08:48 AM, Russell King - ARM Linux wrote:
>> On Mon, Sep 20, 2010 at 07:14:33PM +0530, deepaksi wrote:
>>> I request you to provide some more inputs on this, so that we can close
>>> the issue.
>>
>> I don't know, especially so without seeing the drivers.
>
> Assuming there is no powergating of the GIC, then this patch should be  
> sufficient depending on one question.

The GIC provides no wakeup capabilities.  Providing a dummy 'set_wake'
function means that driver authors will expect a successful
enable_irq_wake() to work - when it results in precisely nothing
being done.

With the situation described, what I envisage is drivers doing something
like:

	err = enable_irq_wake(irq);
	if (err == 0) {
		/* everything is fine, don't need to do anything else */
	} else if (err == -ENXIO) {
		/* IRQ controller doesn't support wakeups, try something else */
	} else {
		/* an error occurred trying to enable wakeups */
	}

If we go around adding dummy set_irq_wake functions to IRQ controllers
which don't support wakeup, then there's no way for drivers to know
this, and there is no method (other than by #ifdeffery) for them to
sort out this mess.
