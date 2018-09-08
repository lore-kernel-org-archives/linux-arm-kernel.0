From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Sat, 8 Sep 2018 13:24:13 +0200
Subject: [PATCH 0/2] Follow-up patches for Cedrus v9
In-Reply-To: <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
References: <20180907163347.32312-1-contact@paulk.fr>
 <11104c03-97ac-8b36-7d75-dfecb8fcce10@xs4all.nl>
 <CAGb2v67F2a-kYFRb_f+CyhzkHf5+Y+h01=SE-rxJ=-Oj-ma1BA@mail.gmail.com>
Message-ID: <3c4e5a98-4dbd-9a8c-8dab-612a923f0eb9@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/08/2018 12:22 PM, Chen-Yu Tsai wrote:
> On Sat, Sep 8, 2018 at 6:06 PM Hans Verkuil <hverkuil@xs4all.nl> wrote:
>>
>> On 09/07/2018 06:33 PM, Paul Kocialkowski wrote:
>>> This brings the requested modifications on top of version 9 of the
>>> Cedrus VPU driver, that implements stateless video decoding using the
>>> Request API.
>>>
>>> Paul Kocialkowski (2):
>>>   media: cedrus: Fix error reporting in request validation
>>>   media: cedrus: Add TODO file with tasks to complete before unstaging
>>>
>>>  drivers/staging/media/sunxi/cedrus/TODO     |  7 +++++++
>>>  drivers/staging/media/sunxi/cedrus/cedrus.c | 15 ++++++++++++---
>>>  2 files changed, 19 insertions(+), 3 deletions(-)
>>>  create mode 100644 drivers/staging/media/sunxi/cedrus/TODO
>>>
>>
>> So close...
>>
>> When compiling under e.g. intel I get errors since it doesn't know about
>> the sunxi_sram_claim/release function and the PHYS_PFN_OFFSET define.
>>
>> Is it possible to add stub functions to linux/soc/sunxi/sunxi_sram.h
>> if CONFIG_SUNXI_SRAM is not defined? That would be the best fix for that.
>>
>> The use of PHYS_PFN_OFFSET is weird: are you sure this is the right
>> way? I see that drivers/of/device.c also sets dev->dma_pfn_offset, which
>> makes me wonder if this information shouldn't come from the device tree.
>>
>> You are the only driver that uses this define directly, which makes me
>> suspicious.
> 
> On Allwinner platforms, some devices do DMA directly on the memory BUS
> with the DRAM controller. In such cases, the DRAM has no offset. In all
> other cases where the DMA goes through the common system bus and the DRAM
> offset is either 0x40000000 or 0x20000000, depending on the SoC. Since the
> former case is not described in the device tree (this is being worked on
> by Maxime BTW), the dma_pfn_offset is not the value it should be. AFAIK
> only the display and media subsystems (VPU, camera, TS) are wired this
> way.
> 
> In drivers/gpu/drm/sun4i/sun4i_backend.c (the display driver) we use
> PHYS_OFFSET, which is pretty much the same thing.
>

OK, in that case just put #ifdef PHYS_PFN_OFFSET around that line together
with a comment that this will eventually come from the device tree.

Regards,

	Hans
