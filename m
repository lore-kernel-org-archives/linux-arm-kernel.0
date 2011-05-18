From: grant.likely@secretlab.ca (Grant Likely)
Date: Tue, 17 May 2011 21:13:33 -0600
Subject: device_tree binding for "amba bus"
In-Reply-To: <20110518002317.GE5913@n2100.arm.linux.org.uk>
References: <f9ae780a-2747-427f-826a-e0b510ca8afb@VA3EHSMHS001.ehs.local>
	<20110517224134.GC2266@n2100.arm.linux.org.uk>
	<64ff6672-0ce3-475b-b1c7-dc18bf2c2658@VA3EHSMHS005.ehs.local>
	<20110518002317.GE5913@n2100.arm.linux.org.uk>
Message-ID: <BANLkTim9fWLyQgSubcQt9dqZxhfKxK9sHw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 17, 2011 at 6:23 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, May 17, 2011 at 05:05:12PM -0700, Stephen Neuendorffer wrote:
>> In drivers/amba/bus.c:
>>
>> static int amba_get_enable_pclk(struct amba_device *pcdev)
>> {
>> ? ? ? struct clk *pclk = clk_get(&pcdev->dev, "apb_pclk");
>>
>> static int amba_get_enable_vcore(struct amba_device *pcdev)
>> {
>> ? ? ? struct regulator *vcore = regulator_get(&pcdev->dev, "vcore");
>>
>> So users of this bus have to have a clock and a regulator with those
>> exact names.
>> Is it your expectation that the clock/regulator names are standardized
>> across arch/arm?
>
> Let's fix one thing here.
>
> The second argument to clk_get is *not* a unique clock name. ?It is a
> _connection_ name for the device, to distinguish between different
> clocks on the same device. ?It does not identify _any_ particular
> clock on its own.

The draft device tree clock matching code reflects this too.  If an
"apb_pclk-clock" property (which is a phandle to a clock provider) is
provided by the device tree, then the dt clock decode logic will use
it to determine which clock source to use.  The current code is a bit
of an ugly hack, and the exact mechanics may change, but in principle
the device tree support code will continue to follow this model.
apb_pclk is the generic name, but it could be wired to any clock in
the system.

g.
