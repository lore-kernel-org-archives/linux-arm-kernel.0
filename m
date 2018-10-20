From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Sat, 20 Oct 2018 22:10:45 +0800
Subject: [PATCH v3 3/4] arm64: implement live patching
In-Reply-To: <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz>
References: <20181001140910.086E768BC7@newverein.lst.de>
 <20181001141652.5478C68BE1@newverein.lst.de>
 <alpine.LSU.2.21.1810171051560.21847@pobox.suse.cz>
 <20181018125820.iw54zbirq74ulknj@linux-8ccs>
 <CAKv+Gu_yNBN+Rpw98MAZaxzSjm20qMYD7+fiJ1fBHoUeDr9fBA@mail.gmail.com>
 <alpine.LSU.2.21.1810191714540.4692@pobox.suse.cz>
Message-ID: <CAKv+Gu8Vg9-CwvU-u9gNGmtB7gTapuCPHjU5v7FWnPsVy6vptA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19 October 2018 at 23:21, Miroslav Benes <mbenes@suse.cz> wrote:
>
>> >> Ad relocations. I checked that everything in struct mod_arch_specific
>> >> stays after the module is load. Both core and init get SHF_ALLOC set
>> >> (mod->arch.core.plt->sh_flags in module_frob_arch_sections(). It is
>> >> important because apply_relocate_add() may use those sections
>> >> through module_emit_plt_entry() call.
>> >
>> >
>> > Yes, it looks like the needed .plt sections will remain in module
>> > memory. However, I think I found a slight issue... :/
>> >
>> > In module_frob_arch_sections(), mod->arch.core.plt is set to an offset
>> > within info->sechdrs:
>> >
>> >             if (!strcmp(secstrings + sechdrs[i].sh_name, ".plt"))
>> >                     mod->arch.core.plt = sechdrs + i;
>> >
>> > sechdrs is from info->sechdrs, which is freed at the end of
>> > load_module() via free_copy(). So although the relevant plt section(s)
>> > are in module memory, mod->arch.core.plt will point to invalid memory
>> > after info is freed. In other words, the section (.plt) *is* in memory
>> > but the section header (struct elf64_shdr) containing section metadata
>> > like sh_addr, sh_size etc., is not.
>> >
>>
>> Just for my understanding: this only matters for live patching, right?
>
> Yes. Live patching can do deferred relocations. When a module is loaded
> and livepatched, the relevant symbols in the patching module are resolved.
> We call apply_relocate_add(), which is arch-specific, and we must be sure
> that everything used by apply_relocate_add() is preserved in the patching
> module after it is loaded.
>

So I suppose this could get interesting in cases where modules are far
away from the kernel (i.e., more than -/+ 128 MB). Fortunately, the
modules themselves are always placed in a 128 MB window, but this
window could be out of reach for branches into the kernel proper. If
we find ourselves in the situation where we need to patch calls into
the kernel proper to point into this module, this may get interesting,
since the PLT entries *must* be allocated along with the module that
contains the branch instruction, or the PLT entry itself may be out of
range, defeating the purpose.


>> The original PLT support was implemented to support loading modules
>> outside of the -/+ 128 MB range of an arm64 relative branch/jump
>> instruction, and was later enhanced [for the same reason] to support
>> emitting a trampoline for the ftrace entrypoint.
>
> Regards,
> Miroslav
