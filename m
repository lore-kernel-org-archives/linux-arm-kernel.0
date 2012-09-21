From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Fri, 21 Sep 2012 21:31:15 +0200
Subject: [RFC 0/6] pinctrl: samsung: Remove static platform-specific data
In-Reply-To: <505CB4A3.9050707@wwwdotorg.org>
References: <1348131197-25506-1-git-send-email-t.figa@samsung.com>
 <505CB4A3.9050707@wwwdotorg.org>
Message-ID: <3531529.1enE84BHSJ@flatron>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Thanks for your comments.

On Friday 21 of September 2012 12:40:35 Stephen Warren wrote:
> On 09/20/2012 02:53 AM, Tomasz Figa wrote:
> > This RFC series is a work on replacing static platform-specific data in
> > pinctrl-samsung driver with data dynamically parsed from device tree.
> 
> Hmm. I tend to think this is exactly the opposite of the correct
> direction; you end up wasting a whole ton of time during the boot
> process parsing data out of the device tree only to end up with exactly
> the same tables that you would have just put into the kernel anyway.

Yes, I'm aware that parsing all those information from device tree won't be 
free. I have even considering simplifying the binding to something like

	samsung,pin-bank = <offset count func pud drv conpdn pudpdn>;

listing widths of fields in fixed order, with some fields allowed to be 
zero, meaning that given bank doesn't support this control. It would 
simplify the parsing to just iterating over a table under a single 
property. What do you think?

I have decided to post the original variant to get some comments earlier, 
as I already had all the rest of patches based on it.

> Is
> it really likely that future SoCs will change information such as the
> width of the pullup/pulldown bitfield, but not change anything else
> that's not already in this binding. If that isn't the case, the binding
> won't be complete enough to describe any new features on future SoCs
> anyway.

Looking at the history of Samsung SoCs and specifics of this subsystem, 
there isn't much likely to change other than the bindings already account 
for (and the binding represents whatever the driver accounts for).

> > It aims at reducing the SoC-specific part of the driver and thus the
> > amount of modifications to driver sources when adding support for next
> > SoCs (like Exynos4x12).
> > 
> > Furthermore, moving definitions of pin banks to device tree will allow
> > to simplify GPIO and GEINT specification to a format similar to used
> > previously by gpiolib-based implementation, using a phandle to the bank
> > and pin index inside the bank, e.g.
> > 
> > 	gpios = <&gpa1 4 0>;
> > 	interrupt-parent = <&gpa1>;
> > 	interrupts = <4 0>;
> 
> I don't think those two are correlated; the GPIO specifier format could
> just as easily be <bank pin> irrespective of whether the pinctrl driver
> contains SoC-specific tables or not.

Correct me if I'm wrong, but each bank needs to have its own subnode to be 
able to address pins like this. That was the starting point of the whole 
series and the idea that if all the banks (which are SoC-specific) have to 
be defined anyway, maybe it wouldn't be too bad to put all the SoC-specific 
parameters there too.

> > Any comments are welcome.
> > 
> > TODO:
> >  - bindings documentation
> 
> That's unfortunate; it would be the most interesting part to review. I
> guess I'll try to work out the binding from the examples in patch 6.

Sorry about that. I thought the examples would be sufficient. Still, I was 
focused at getting comments about the idea of moving such data to DT in 
general, not the bindings, which are most likely to change, in particular.

Best regards,
Tomasz Figa
