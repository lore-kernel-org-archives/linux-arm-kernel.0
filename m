From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 8 Aug 2017 15:25:08 +0100
Subject: [PATCH] arm64: correct modules range of kernel virtual memory
 layout
In-Reply-To: <20170808141843.GL13355@arm.com>
References: <1502103886-19725-1-git-send-email-miles.chen@mediatek.com>
 <20170807131608.GA18817@arm.com>
 <CAKv+Gu9qD_-GNHus5txiqj9eHLpU5S7RX8QxYeUG17Ok0QNz-A@mail.gmail.com>
 <20170807140138.GB18817@arm.com> <1502167450.24380.21.camel@mtkswgap22>
 <1502170045.30154.5.camel@mtkswgap22> <20170808131909.GI13355@arm.com>
 <CAKv+Gu8RY7MLF85U7y0AQ5z4xm+t7nOSckL7r59D_N6t2pH2hQ@mail.gmail.com>
 <20170808141843.GL13355@arm.com>
Message-ID: <CAKv+Gu8=dUJhYZ7VHcf2cMV4Jzt7K0a60J9voRv-nC7VxuLS2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 August 2017 at 15:18, Will Deacon <will.deacon@arm.com> wrote:
> On Tue, Aug 08, 2017 at 03:04:55PM +0100, Ard Biesheuvel wrote:
>> On 8 August 2017 at 14:19, Will Deacon <will.deacon@arm.com> wrote:
>> > On Tue, Aug 08, 2017 at 01:27:25PM +0800, Miles Chen wrote:
>> >> On Tue, 2017-08-08 at 12:44 +0800, Miles Chen wrote:
>> >> > Agreed.MODULES_VADDR should be phased out. Considering the kernel
>> >> > modules live somewhere between [VMALLOC_START, VMALLOC_END) now:
>> >> > (arch/arm64/kernel/module.c:module_alloc). I suggest the following
>> >> > changes:
>> >> >
>> >> > 1. is_vmalloc_or_module_addr() should return is_vmalloc_addr() directly
>> >> > 2. arch/arm64/mm/dump.c does not need MODULES_VADDR and MODULES_END.
>> >> > 3. kasan uses [module_alloc_base, module_alloc_base + MODULES_VSIZE) to
>> >> > get the shadow memory? (the kernel modules still live in this range when
>> >> > kasan is enabled)
>> >> > 4. remove modules line in kernel memory layout
>> >> > (optional, thanks for Ard's feedback)
>> >> > 5. remove MODULE_VADDR, MODULES_END definition
>> >>
>> >> I was wrong about this. is_vmalloc_or_module_addr() is defined
>> >> in mm/vmalloc and it uses MODULES_VADDR and MODULES_END.
>> >> May it is better to give MODULES_VADDR and MODULES_END
>> >> proper values, not remove them.
>> >
>> > I think the only cases where the modules area isn't completely contained
>> > within vmalloc is where either randomization is disabled
>> > (CONFIG_RANDOMIZE_BASE=n) or we fail in kaslr_early_init. However, in both
>> > of these cases, module_alloc_base is set correctly, so perhaps we could
>> > defined MODULES_VADDR in terms of that oto get is_vmalloc_or_module_addr
>> > working properly.
>>
>> is_vmalloc_or_module_addr() already works properly: modules are loaded
>> into their own dedicated region, or in the vmalloc space otherwise.
>> Note that this even applies when disregarding KASRL: the module PLT
>> support uses the vmalloc region as overflow if the module region is
>> exhausted.
>
> I'm not sure I'd say it works properly in all cases. If we're placing
> modules in the vmalloc area, then the piece of VA space below that shouldn't
> be treated as the module area, otherwise we could say that
> is_vmalloc_or_module_addr() could return 1 for all areas of unused VA
> space, which I don't think is right.
>

OK, so what you're after is a is_vmalloc_or_module_addr() that returns
false for the module region if we're currently loading modules
elsewhere. What does that actually buy us? The module region will
either be used for modules, or remain unused.

AFAIK the main use case for is_vmalloc_or_module_addr() is to decide
whether the addresses is vmapped so that you can set ro or nx
attributes.

>> > We'd need to add some code to the table dumper to avoid
>> > printing the module area if it's contained within vmalloc, and that could
>> > also be used for the kernel memory layout print.
>> >
>>
>> I agree it may be misleading if the module region is empty while
>> modules have been loaded. But let's not conflate the module *region*
>> with the actual locations where modules are loaded: without
>> CONFIG_RANDOMIZE_MODULE_REGION_FULL=y, this is a 128 MB region that
>> overlaps the kernel .text section.
>
> Sure, but what use is there in communicating the module region if we don't
> actually load modules there? It only serves to confuse people IMO.
>

Yes, I get that. But as I said, module PLT support may result in
modules ending up anywhere in the VMALLOC space, so even if we have a
preferred 128 MB window, modules may live elsewhere as well. Having a
default window, and actual window *and* modules potentially turning up
in other places is even more confusing.

So I guess we could drop the 'modules' line in dmesg if
module_alloc_base points into the VMALLOC space, because that
guarantees us no modules will be allocated in the module region. Other
than that, I don't think tinkering with MODULES_VADDR is going to
improve things.
