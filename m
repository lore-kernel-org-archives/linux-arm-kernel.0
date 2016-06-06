From: wmills@ti.com (William Mills)
Date: Mon, 6 Jun 2016 08:19:05 -0400
Subject: [RFC v2 4/4] ARM: keystone: dma-coherent with safe fallback
In-Reply-To: <20160606115918.GG6831@leverpostej>
References: <1465183229-24147-1-git-send-email-wmills@ti.com>
 <1465183229-24147-5-git-send-email-wmills@ti.com>
 <20160606085627.GA6831@leverpostej>
 <20160606114321.GJ1041@n2100.armlinux.org.uk>
 <20160606115918.GG6831@leverpostej>
Message-ID: <57556A39.2000505@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 06/06/2016 07:59 AM, Mark Rutland wrote:
> On Mon, Jun 06, 2016 at 12:43:21PM +0100, Russell King - ARM Linux wrote:
>> On Mon, Jun 06, 2016 at 09:56:27AM +0100, Mark Rutland wrote:
>>> I very much do not like this. As I previously mentioned [1],
>>> dma-coherent has de-facto semantics today. This series deliberately
>>> changes that, and inverts the relationship between DT and kernel (as the
>>> describption in the DT would now depend on the configuration of the
>>> kernel).
>>
>> dma-coherent's semantics are not very well defined - just grep for it
>> in Documention/devicetree/ and you'll find several different wordings
>> for what this property means.
> 
> Indeed. This is the tip of the iceberg w.r.t. under-specification of
> memory attribute usage.
> 
>> Anyway, my point here is that all of these merely say that the hardware
>> is coherent in _some regard_ - it doesn't specify under what conditions
>> DMA coherency is guaranteed by the hardware.  It happens that on ARM,
>> most platforms give that guarantee when using inner shared mappings.  If
>> we were to use some other sharing, or disable sharing altogether (eg, by
>> disabling SMP support) then all these platforms would immediately break.
>>
>> In other words, DMA coherence today already depends on the kernel's setup
>> of the page tables corresponding to the requirements of the hardware.
> 
> I agree that whether or not devices are coherent in practice depends on
> the kernel's configuration. The flip side, as you point out, is that
> devices are coherent when a specific set of attributes are used.
> 
> i.e. that if you read dma-coherent as meaning "coherent iff Normal,
> Inner Shareable, Inner WB Cacheable, Outer WB Cacheable", then
> dma-coherent consistently describes the same thing, rather than
> depending on the configuration of the OS.
>

Even w/o inner / outer it seems to me it is under specified.
What about a system where main DDR memory is DMA coherent but an on chip
SRAM needs manual flush/invalidate?  Right now dma coherency is all or
nothing.  In the above case you would need to ensure that the device
never tried to use that SRAM for dma transactions even though the device
is perfectly capable with the right hand-holding.  Alternatively you
could use the SRAM but penalize the normal case of DDR.

> DT is a datastructure provided to the kernel, potentially without deep
> internal knowledge of that kernel configuration. Having a consistent
> rule that is independent of the kernel configuration seems worth aiming
> for.
> 
> A dma-outer-coherent property would allow us to accurately describe the
> keystone case in the same way, independent of kernel configuration.
> 
>> Keystone II is just slightly different - and as I understand it, TI
>> followed one of the early specifications that ARM Ltd produced.  That
>> specification may have contained errors, but unfortunately, we now have
>> a situation where there is hardware out there which followed in good
>> faith.
> 
> To be clear, I am not arguing against supporting keystone. I just wish
> to avoid muddying the waters further w.r.t. the semantics of
> dma-coherent, which I believe can be salvaged and made consistent.
> 
> Clearly, those semantics are the point of contention here.
>

To me this seems like a choice between embracing outer-shared or
treating it like a quirk of some early armv7 devices.  With ARM's
current recommendations to use inner-shared for everything in many
contexts (like ARM servers etc), I was assuming you would want the latter.

Thanks for looking.  This is not the patch that I expected to generate
the most discussion.  :)

-- Bill
