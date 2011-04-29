From: j.glisse@gmail.com (Jerome Glisse)
Date: Fri, 29 Apr 2011 09:34:05 -0400
Subject: [Linaro-mm-sig] [RFC] ARM DMA mapping TODO, v1
In-Reply-To: <4DBAA9B4.3070306@vmware.com>
References: <201104212129.17013.arnd@arndb.de>
	<20110428093039.GU17290@n2100.arm.linux.org.uk>
	<1304024836.2513.198.camel@pasglop>
	<201104291326.25634.arnd@arndb.de> <4DBAA9B4.3070306@vmware.com>
Message-ID: <BANLkTinNMxpAcjpBR7r1f1RA31kww=v6Fw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 29, 2011 at 8:06 AM, Thomas Hellstrom <thellstrom@vmware.com> wrote:
> On 04/29/2011 01:26 PM, Arnd Bergmann wrote:
>>
>> On Thursday 28 April 2011, Benjamin Herrenschmidt wrote:
>>
>>>>>
>>>>> For PCI you can have the flag propagate from the PHB down, for busses
>>>>> without a bus type (platform) then whoever instanciate them (the
>>>>> platform code) can set that appropriately.
>>>>>
>>>>
>>>> How can you do that when it changes mid-bus heirarchy? ?I'm thinking
>>>> of the situation where the DRM stuff is on a child bus below the
>>>> root bus, and the root bus has DMA coherent devices on it but the DRM
>>>> stuff doesn't.
>>>>
>>>
>>> But that's not PCI right ? IE. with PCI, coherency is a property of the
>>> PHB...
>>>
>>
>> That is my understanding at least, but I'd like to have a confirmation
>> from the DRM folks.
>>
>> I believe that the PC graphics cards that have noncoherent DMA mappings
>> are all of the unified memory (integrated into the northbridge) kind,
>> so they are not on the same host bridge as all regular PCI devices,
>> even if they appear as a PCI device.
>>
>
> I think Jerome has mentioned at one point that the Radeon graphics cards
> support
> non-coherent mappings.
>
> Fwiw, the PowerVR SGX MMU also supports this mode of operation, although it
> being functional I guess depends on the system implementation.
>
> /Thomas
>

Radeon memory controller can do non snooped pci transaction, as far as
i have tested most of the x86 pci bridge don't try to be coherent then
ie they don't analyze pci dma and ask for cpu flush they just perform
the request (and i guess it's what all bridge will do), so it endup
being noncoherent. I haven't done any benchmark of how faster it's for
the GPU when it's not snooping but i guess it can give 50% boost as it
likely drastictly reduce pci transaction overhead.

I am talking here about device that you plug into any pci or pcie
slot, so it's not igp integrated into northbridge or into the cpu.

Cheers,
Jerome
