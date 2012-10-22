From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 22 Oct 2012 11:48:29 -0600
Subject: [PATCH v2 2/2] USB: doc: Binding document for ehci-platform driver
In-Reply-To: <Pine.LNX.4.44L0.1210221324580.1724-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1210221324580.1724-100000@iolanthe.rowland.org>
Message-ID: <508586ED.1010106@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/22/2012 11:34 AM, Alan Stern wrote:
> On Mon, 22 Oct 2012, Stephen Warren wrote:
> 
>> On 10/20/2012 04:10 PM, Tony Prisk wrote:
>>> Add a binding document for ehci-platform driver.
> 
>>> +Optional properties:
>>> +- caps-offset : offset to the capabilities register (default = 0)
>>> +- has-tt : controller has transaction translator(s).
>>> +- has-synopsys-hc-bug : controller has the synopsys hc bug
>>
>> That would normally be determined by the driver based on the particular
>> compatible value that is in device tree.
> 
> I don't understand this comment.  Isn't "has-synopsys-hc-bug" the 
> compatible value in question?

"compatible value" in this context means that value of the property
named "compatible".

>>> +- big-endian : descriptors and registers are both big endian. This
>>> +  is the equivalent of specifying big-endian-desc and big-endian-regs.
>>> +OR
>>> +- big-endian-desc : descriptors are in big-endian format
>>> +- big-endian-regs : mmio is in big-endian format
>>
>> Hmmm. That looks odd. Presumably if those properties aren't specified,
>> the default is little-endian? Shouldn't this be a tri-state: big,
>> little, native, with default native? I don't know what the EHCI
>> specification mandates here (and if it does mandate something, the
>> default should match the specification). Isn't this something that
>> readl/writel would take care of, or are there cases where the register
>> endianness of just this one HW block mismatches all other HW blocks?
> 
> The EHCI spec assumes a PCI implementation; it doesn't consider other
> sorts.  And it doesn't say anything about the endianness of multi-byte
> descriptors in memory.

OK, so does this binding default to assuming little-endian (which I
assume matches PCI), unless the big-endian properties are given? Is the
case of little-endian EHCI registers on a big-endian CPU a common enough
thing that adding a third state native-endian wouldn't be useful?
