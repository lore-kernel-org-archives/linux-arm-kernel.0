From: dianders@chromium.org (Doug Anderson)
Date: Mon, 3 Aug 2015 15:53:46 -0700
Subject: [PATCH 1/2] ARM: dts: rockchip: reserve unusable memory region on
 rk3288
In-Reply-To: <10674303.GIsaEKUXGC@diego>
References: <15143985.aGzb1oeyb9@diego>
 <CAD=FV=W2LSQh4e9+=ooTf34VzM_yPZn497DqSVEdb1kehZbqQQ@mail.gmail.com>
 <10674303.GIsaEKUXGC@diego>
Message-ID: <CAD=FV=V3=2azZJzNtfqBa-RZ_s+p5rbGFbPveRtuYudd_TJk6Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Aug 3, 2015 at 3:38 PM, Heiko St?bner <heiko@sntech.de> wrote:
>> I don't object to just reserving this memory, but I do object a little
>> to this implementation.
>>
>> It's 16 MB we're talking about here, which is pretty small compared to
>> the 4G of memory that you must have when this is a problem.  However,
>> at some point we might want to try to actually use this 16 MB.
>>
>> The memory is actually _not_ unusable, it's only unusable for DMA.  In
>> theory the kernel is supposed to have a way to mark memory as unusable
>> for DMA which would then allow us to use this memory for non-DMA
>> purposes...
>>
>> Nobody ever managed to figure this out in the Chrome OS tree (it was
>> 16 megs so we just reserved it and never got back around to it), but
>> when folks were looking at it they looked at things like ZONE_DMA,
>> dma_set_mask_and_coherent, etc.
>>
>> In any case, to leave the door open for people to fix this in the
>> future, it seems prudent to fix this in code like
>> <https://chromium-review.googlesource.com/#/c/245107/> rather than to
>> put the limit in DTS.
>
> hmm, a counter argument in favor of even having the stopgap section disabling
> the memory in the dts might be, that as Jeffy said all current Rockchip socs
> are affected, even the rk3368.
>
> So a future real solution would be declaring the usable dma area in devicetree
> anyway and not in kernel code. So in my mind devices can disable the memory
> for now in dt and later (once something usable is defined) can switch the soc-
> level devicetree to this one, describing the actually usable dma area.
>
> Old devicetrees would keep working anyway and could switch at their
> convenience. So I don't see a real transistion problem here (aka no API
> breakage or so)?

OK, interesting point.

OK, we can do this in device tree, but we should probably at least
have a comment saying that it's only a problem for DMA?  ...or at
least something in the commit message?

-Doug
