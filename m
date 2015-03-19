From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 19 Mar 2015 12:28:46 -0600
Subject: [PATCHv2 3/3] Documentation: DT bindings: Tegra AHB: note base
 address change
In-Reply-To: <alpine.DEB.2.02.1503191706340.9480@utopia.booyaka.com>
References: <20150317083221.32662.14647.stgit@baseline>
 <20150317083221.32662.96822.stgit@baseline>
 <20150317103806.GU8656@n2100.arm.linux.org.uk>
 <alpine.DEB.2.02.1503191525450.9480@utopia.booyaka.com>
 <550AEE6B.5080301@wwwdotorg.org>
 <alpine.DEB.2.02.1503191601520.9480@utopia.booyaka.com>
 <550AFF52.6070503@wwwdotorg.org>
 <alpine.DEB.2.02.1503191706340.9480@utopia.booyaka.com>
Message-ID: <550B155E.9050308@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/19/2015 11:55 AM, Paul Walmsley wrote:
> On Thu, 19 Mar 2015, Stephen Warren wrote:
>
>> The binding document is supposed to say what value the reg property should
>> have.
>
> If you look at other DT binding documentation in the kernel, this is
> generally not the case.  Consider these examples:
>
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/brcm,bcm2835-i2c.txt
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-omap.txt
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/i2c/i2c-exynos5.txt

That is because there are no special requirements for the reg values 
beyond the HW documentation.

However, if we need the reg value to contain something other than the 
base address that's in the HW documentation, we clearly need to document 
that exception. How else would anyone know about the exception?

The example doesn't count because (a) it's not normative (b) an example 
wouldn't explain why an exception needs to be made or how to calculate 
the exception value for cases other than the specific example given.

...
>> If we require some unusual offset in the reg property (i.e. something
>> other than what the HW documentation describes as the module base address),
>> that ought to be documented. We do have this situation for this module at
>> present, although the documentation unfortunately doesn't explicitly call this
>> out even though the example alludes to it.
>>
>> I do think we should at least fix the example so it isn't confusing and
>> inconsistent with expected practice. We could either switch the example to
>> Tegra210 so we only provide the best example going forward, or have separate
>> examples for Tegra20/210 to highlight the difference.
>>
>> We should also add documentation that Chips before Tegra210 (or
>> Tegra132?) *require* the extra offset. Any code or DT written to the
>> existing (admittedly slightly implicit) binding needs to continue to
>> work, so we should document this unusual requirement, even if we enhance
>> the Linux driver to accept either mode of operation.
>
> After the two driver patches (after rmk's requested changes) are applied,
> no unusual offset will be required, but if the legacy offset is specified,
> it will be transparently handled.
>
> As I see it, there are three possible cases:
>
> 1. the legacy, incorrect base address is used, in which case everything
> will still work but there will be a warning;
>
> 2. the correct base address (from a hardware SoC integration point of
> view) is used, in which case everything will work with no warnings,
>
> 3. a novel, completely incorrect base address is used, in which case the
> IP block won't work at all and the driver will fail completely
>
> After the patches, the driver now handles the first two cases.  If you
> would like the DT binding documentation practice changed to attempt to
> address the third case, by requiring DT binding documentation to contain
> lists of the correct IP integration data for every possible chip that
> contains that IP block, as you mention above, such a change would be a
> major delta from existing kernel practice, so would certainly mandate
> submitting a patch for the common DT binding documentation file at

That's not what I'm asking for. I want exceptions to standard practice 
documented, which is that reg contains whatever the HW documentation 
says it should. There's no need to enumerate all the valid values; the 
HW documentation does that. However, if the DT binding requires 
something other than what the HW documentation says, we must document that.

> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/submitting-patches.txt
>
>> Other OSs and old versions of Linux will still need the exception for
>> older SoCs.
>
> How about this: I will send a patch for the DT binding documentation to
> note that versions of Linux prior to v4.1 (unless Torvalds runs another
> poll) require the four-byte-offset base address.  Is that sufficient to
> address your concerns with this series?

Almost yes.

We should not document Linux 4.1 as the cut-off. DT bindings are 
supposed to be OS agnostic. While it's practically unlikely, it is 
entirely possible for some other OS to have already implemented support 
for this binding, and the current binding is an ABI. We have no control 
over if/when any non-Linux code is updated to add support for a 0-based 
offset for existing SoCs, and certainly no versions of Linux or any 
other OS can be updated retro-actively except perhaps a few linux-stable 
versions. We can however write the binding in such a way as support for 
new SoCs requires the new 0-based address, since there is no binding 
specification for those new chips yet, and the time when you add the new 
binding documentation is the first time any OS could possibly add 
conformant support for it.

In summary, I believe the binding document must state that 
T20/30/114/124 require the offset of 4 in reg value, and newer chips 
require no offset in the reg value. We can still always accept either in 
the Linux kernel going forward based on the principle of being lenient 
re: input data.
