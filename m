From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 12 Dec 2016 16:57:44 +0000
Subject: [PATCH 1/1] arm/module: maximum utilization of module area.
In-Reply-To: <alpine.LFD.2.20.1612121026250.1657@knanqh.ubzr>
References: <1481012975-44478-1-git-send-email-maninder1.s@samsung.com>
 <CGME20161212102403epcas4p2e039072e2acdc3d20c1b8ac86e823375@epcas4p2.samsung.com>
 <20161212112230epcms5p6af05aef34f72eab15061a166d18cff00@epcms5p6>
 <alpine.LFD.2.20.1612121026250.1657@knanqh.ubzr>
Message-ID: <CAKv+Gu9kboYtEwZygYz8PnwQsLuRgibFfyJNcsE6tjG+xvDkeQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 December 2016 at 15:28, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> On Mon, 12 Dec 2016, Vaneet Narang wrote:
>
>> Hi,
>>
>> >A PC24 relocation has a range of +/-32MB.  This means that where-ever
>> >the module is placed, it must be capable of reaching any function
>> >within the kernel text, which may itself be quite large (eg, 8MB, or
>> >possibly larger).  The module area exists to allow modules to be
>> >located in an area where PC24 relocations are able to reach all of the
>> >kernel text on sensibly configured kernels, thereby allowing for
>> >optimal performance.
>> >
>> >If you wish to load large modules, then enable ARM_MODULE_PLTS, which
>> >will use the less efficient PLT method (which is basically an indirect
>> >function call) for relocations that PC24 can't handle, and will allow
>> >the module to be loaded into the vmalloc area.
>> >
>> >Growing the module area so that smaller modules also get penalised by
>> >the PLT indirection is not sane.
>>
>> This is exactly what i am saying. These changes are useful to accomdate
>> 22MB modules without enabling ARM_MODULE_PLTS.
>
> I think you need to figure out why you need such a huge module in the
> first place.  That is very uncommon indeed.
>

Also, note that the module PLT code was recently optimized, to remove
some pathological behavior which severely affected load times of large
modules.

Can you quantify the performance hit you are taking when using module
PLTs? And the actual increase in memory footprint?
