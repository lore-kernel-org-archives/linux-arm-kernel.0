From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 14 Sep 2015 13:16:11 +0200
Subject: [Xen-devel] [PATCH] efi/libstub/fdt: Standardize the names of EFI
 stub parameters
In-Reply-To: <55F6C01502000078000A2823@prv-mh.provo.novell.com>
References: <20150910112418.GC29293@leverpostej>
 <alpine.DEB.2.02.1509101223580.2672@kaball.uk.xensource.com>
 <20150910121514.GE29293@leverpostej>
 <alpine.DEB.2.02.1509101429480.2672@kaball.uk.xensource.com>
 <20150910144938.GI29293@leverpostej>
 <alpine.DEB.2.02.1509101655020.2672@kaball.uk.xensource.com>
 <20150910162302.GN29293@leverpostej>
 <20150911124643.GB4530@olila.local.net-space.pl>
 <alpine.DEB.2.02.1509111410180.2672@kaball.uk.xensource.com>
 <CAKv+Gu9rN7_mxk0huX+34HSCC_aTWVTkUZKQMB1+9U56fRnwsA@mail.gmail.com>
 <20150911154534.GD4530@olila.local.net-space.pl>
 <55F6886D.1090900@huawei.com>
 <CAKv+Gu-xAAd=xTOh+qZvPDthgbRPLy=YwT4xfi4dS53EgJRh1Q@mail.gmail.com>
 <55F693F5.8030203@huawei.com>
 <CAKv+Gu-2kyd3Gf3ceSa1jdgCjqJ8zBCesa4xehLiZ+VzergS3Q@mail.gmail.com>
 <55F6C01502000078000A2823@prv-mh.provo.novell.com>
Message-ID: <CAKv+Gu_k4-BqW7CQwB82-GfeXXNKk0bCjr=ZNFy1iDBNzKNWSg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 September 2015 at 12:39, Jan Beulich <JBeulich@suse.com> wrote:
>>>> On 14.09.15 at 11:36, <ard.biesheuvel@linaro.org> wrote:
>> On 14 September 2015 at 11:31, Shannon Zhao <zhaoshenglong@huawei.com> wrote:
>>> My understanding is that if there are no EFI_MEMORY_RUNTIME regions, it
>>> means we can't use runtime services and should not set the bit
>>> EFI_RUNTIME_SERVICES of efi.flags. But if efi_virtmap_init() return
>>> true, the bit will be set.
>>>
>>
>> As I said, if you don't want the EFI_RUNTIME_SERVICES bit to be set
>> for other reasons, don't rig efi_virtmap_init() to return false when
>> it shouldn't.
>>
>>>> The absence of such regions is allowed by the spec, so
>>>> efi_virtmap_init() is correct imo to return success.
>>>>
>>> Sorry, not well know about the spec. Could you point out where the spec
>>> says this?
>>>
>>
>> Well, I think it doesn't work that way. You are claiming that a memory
>> map without at least one EFI_MEMORY_RUNTIME constitutes an error
>> condition, so the burden is on you to provide a reference to the spec
>> that says you must have at least one such region.
>
> Sure, from a spec pov you're right. But where would runtime
> services code/data live when there's not a single region marked
> as needing a runtime mapping. IOW while the spec doesn't say
> so, assuming no runtime services when there's not at least one
> executable region with the runtime flag set could serve as a stop
> gap measure against flawed firmware.
>

That in itself is a fair point. But the argument being made was that
it is in itself a bug for no EFI_MEMORY_RUNTIME regions to exist,
while the actual purpose of the patch is to prevent the
RuntimeServices pointer from being dereferenced on platforms like Xen
that may not be able to implement them.

But actually, even in case of Xen, you will need some
EFI_MEMORY_RUNTIME regions anyway, since the f/w vendor field and the
config and runtime services table pointers are translated to virtual
addresses by the firmware, which means the OS needs to translate them
back to physical addresses in order to dereference them before the VA
mapping is up. (I still think not using SetVirtualAddressMap() at all
would be the best approach for arm64, but unfortunately, most of my
colleagues disagree with me)

-- 
Ard.
