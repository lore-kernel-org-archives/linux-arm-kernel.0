From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 4 Jan 2012 15:15:57 +0100
Subject: [PATCH 3/3] of/irq: Add interrupts-names property to name an
 irq resource
In-Reply-To: <20120104071749.GA15503@ponder.secretlab.ca>
References: <1323095036-3739-1-git-send-email-b-cousson@ti.com>
 <1323095036-3739-4-git-send-email-b-cousson@ti.com>
 <20120104071749.GA15503@ponder.secretlab.ca>
Message-ID: <4F045F1D.2080207@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Grant,

On 1/4/2012 8:17 AM, Grant Likely wrote:
> On Mon, Dec 05, 2011 at 03:23:56PM +0100, Benoit Cousson wrote:
>> In a HW system, resources in general have name to identify them.
>> The is the case as well for IORESOURCE_IRQ resources filled by DT
>> "interrupts" entries.
>> The current DT mechanism is relying on the "interrupts" order to identify
>> the proper resource. This is error prone and not the natural way to
>> retrieve an information in general.
>
> I do not agree with this assessment.  interrupt property order has
> worked quite well for a very long time.  There are some uses cases
> that want to access it by-name, but I expect accessing by-index to
> continue to be the preferred method.  I'm going to drop this paragraph
> from the commit text.

OK, fair enough. My point was when the HW description is providing names 
to list several IRQ resources, giving a number instead is error prone. 
If, on the other side, the spec is providing something like IRQ_A, B or 
C, then yes, the by-index is the natural one.

Considering that most IPs will anyway only have one IRQ line, the 
by-index method will be the most widely used.

>> Moreover, the resource does support a name and an API is available to
>> allow a driver to retrieve the resource using the name instead of an
>> index.
>>
>> Add a interrupts-names property to allow the possiblity to provide a name
>> to any interrupts entries.
>> If the name is available, use it to name the resource, otherwise
>> keep the legacy device full name.
>>
>> Signed-off-by: Benoit Cousson<b-cousson@ti.com>
>> Cc: Grant Likely<grant.likely@secretlab.ca>
>> Cc: Rob Herring<rob.herring@calxeda.com>
>> ---
>>   .../devicetree/bindings/interrupts-names.txt       |   50 ++++++++++++++++++++
>>   drivers/of/irq.c                                   |   11 ++++-
>>   2 files changed, 60 insertions(+), 1 deletions(-)
>>   create mode 100644 Documentation/devicetree/bindings/interrupts-names.txt
>>
>> diff --git a/Documentation/devicetree/bindings/interrupts-names.txt b/Documentation/devicetree/bindings/interrupts-names.txt
>> new file mode 100644
>> index 0000000..d9a796d
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/interrupts-names.txt
>> @@ -0,0 +1,50 @@
>> +interrupts-names property
>> +
>> +In a HW system, physical resources in general have name to identify them.
>> +The is the case as well for interrupt lines.
>> +The current DT mechanism is relying on the "interrupts" order to identify
>> +the proper resource. The interrupts-names is adding the possiblity to
>> +provide a name to interrupts entries.
>> +
>> +Usage:
>> +
>> +This attribute must be used along with a regular interrupts entry. If not
>> +it will be simply ignored.
>
> This documentation is pretty much identical to the reg-names property
> description.  I'll merge the two into a single file.

OK.

>
>> +
>> +
>> +Example:
>> +
>> +
>> +l4-abe {
>> +	compatible = "simple-bus";
>> +	#address-cells =<2>;
>> +	#size-cells =<1>;
>> +	ranges =<0 0 0x48000000 0x00001000>, /* MPU path */
>> +		<1 0 0x49000000 0x00001000>; /* L3 path */
>> +	mcasp {
>> +		compatible = "ti,mcasp";
>> +		reg =<0 0x10 0x10>,<0 0x20 0x10>,
>> +		<1 0x10 0x10>,<1 0x20 0x10>;
>> +		reg-names = "mpu", "dat",
>> +			    "dma", "dma_dat";
>> +		interrupts =<11>,<12>;
>> +		interrupts-names = "rx", "tx";
>
> Nitpick: I'm going to change the property name to "interrupt-names"
> (dropping the 's' from interrupts).  After playing with the clock
> binding (clocks vs. clock-names) and looking at what could be done
> with the gpio binding (gpios vs. gpio-names), I think it 'feels' more
> consistent to drop the s.

Fully agree, I made a comment on that in the cover-letter because I was 
not fully happy with that either.

> Merged, thanks.

Cool, thanks.

Regards,
Benoit
