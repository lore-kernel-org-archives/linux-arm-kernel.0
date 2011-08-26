From: b-cousson@ti.com (Cousson, Benoit)
Date: Fri, 26 Aug 2011 16:13:15 +0200
Subject: How to handle named resources with DT?
In-Reply-To: <201108261258.32880.arnd@arndb.de>
References: <20110809205723.GE11568@ponder.secretlab.ca>
	<877h6173wm.fsf@ti.com> <20110826041200.GD2308@yookeroo.fritz.box>
	<201108261258.32880.arnd@arndb.de>
Message-ID: <4E57A9FB.5030404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/26/2011 12:58 PM, Arnd Bergmann wrote:
> On Friday 26 August 2011, David Gibson wrote:
>> Seriously, how many times do I have to say it?

[...]

>> Insisting that the names come from the DT is to mistakenly think of
>> the DT as an extension of the kernel's internal interfaces, instead of
>> as the external and OS neutral data structure it actually is.

You are wrongly interpreting the consequence: a smart Linux guy added a 
_byname API, without seeing the real cause: most HW resources have a 
name to identify them and not a number.

> Agreed, that was my main point anyway: Getting the name from the
> device tree would be a huge mistake.

No, it would not. In fact, storing name in DT is even much more aligned 
with the goal of DT for my point of view, since it is supposed to 
describe the HW without any assumption about the OS usage. DT data are 
supposed to be driven by the HW specs.


The ordering you are relying on for the moment is purely arbitrary and 
do not have any signification for the HW point of view. Just have a look 
at a HW spec and you will see that most signals have a *name*, not a 
number, to identify them.

Without that, you have to add some unnecessary and error prone 
processing to the original information:
- Encode an information that is there originally (resource name from the 
HW spec) into a arbitrary number without any meaning: Why tx_irq should 
be before the rx_irq and after the err_irq???
- Remove the original name to confuse people.
- Expect the driver to use a number that does not come from the HW spec 
but from a DT binding text file to figure out what resource it has to use.
- Pray that the driver guy didn't wrongly interpret the irq #2138469 to 
be the tx_irq instead of the rx_irq.

That's a lot of (error prone) indirections that can be avoided by using 
the name directly.


If you extend a little bit the scope of the discussion and start 
considering that clocks, voltage rails, reset lines are as well a 
resources for the IP point of view, do you really think that using a 
number to identify a clock or a voltage will really make sense?
Guess what? The current clock binding is using clock name...

In order to have a consistent way of using resources in DT, it makes 
sense to have the ability to provide a name for any kind of resources.
BTW, adding a name should not prevent people to use the legacy by index 
method.


Moreover, anybody deserve to have a name... Otherwise we will end up 
with situation like that:

resource #6: Who are you?
resource #2: The new #2.
resource #6: Who is #1?
resource #2: You are #6.
resource #6: I am not a number, I am a free resource.


Regards,
Benoit
