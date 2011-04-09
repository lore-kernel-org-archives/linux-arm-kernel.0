From: jslaby@suse.cz (Jiri Slaby)
Date: Sat, 09 Apr 2011 18:42:40 +0200
Subject: V4L/ARM: videobuf-dma-contig no longer works on my ARM machine
In-Reply-To: <201104091711.00191.jkrzyszt@tis.icnet.pl>
References: <201009301335.51643.jkrzyszt@tis.icnet.pl>
	<201104090333.52312.jkrzyszt@tis.icnet.pl>
	<20110409071624.GE5573@n2100.arm.linux.org.uk>
	<201104091711.00191.jkrzyszt@tis.icnet.pl>
Message-ID: <4DA08C80.5040205@suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09/2011 05:10 PM, Janusz Krzysztofik wrote:
> (CC: Jiri Slaby, the author of the problematic change; truncate subject)
> 
> On Sat, 09 Apr 2011, at 09:16:24, Russell King - ARM Linux wrote:
>> On Sat, Apr 09, 2011 at 03:33:39AM +0200, Janusz Krzysztofik wrote:
>>> Since there were no actual problems reported before, I suppose the
>>> old code, which was passing to remap_pfn_range() a physical page
>>> number calculated from dma_alloc_coherent() privided dma_handle,
>>> worked correctly on all platforms actually using
>>> videobud-dma-config.

No, it didn't when IOMMU was used. Because remap_pfn_range didn't get a
physical page address.

>>> Now, on my ARM machine, a completely
>>> different, then completely wrong physical address, calculated as
>>> virt_to_phys(dma_alloc_coherent()), is used instead of the
>>> dma_handle, which causes the machine to hang.
>>
>> virt_to_phys(dma_alloc_coherent()) is and always has been invalid,
>> and will break on several architectures apart from ARM.

Yes, the fix is broken for some archs. Feel free to revert it until it
is fixed properly.

Sound pcm mmap had a similar problem and solved that by a bit hackish
way (see snd_pcm_default_mmap).

I saw a discussion about how to sort it out in the sound subsystem and
do that in a clean manner. Maybe somebody else remembers where it was.

thanks,
-- 
js
suse labs
