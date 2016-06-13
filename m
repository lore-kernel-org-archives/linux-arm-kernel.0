From: keescook@chromium.org (Kees Cook)
Date: Mon, 13 Jun 2016 16:17:25 -0700
Subject: [PATCH] ARM: mm: fix location of _etext
In-Reply-To: <20160613212515.GA1041@n2100.armlinux.org.uk>
References: <20160608231158.GA12159@www.outflux.net>
 <CAGXu5jJwtDqLALk+3QETK7Wia56yxFp30nO7vwwbNX49s5KVmg@mail.gmail.com>
 <20160613212515.GA1041@n2100.armlinux.org.uk>
Message-ID: <CAGXu5j+mQ8MK-vTyKhS=hmgXt4_QBYgan+i34VPHv8_0_wsxPg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 13, 2016 at 2:25 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Mon, Jun 13, 2016 at 01:23:29PM -0700, Kees Cook wrote:
>> On Wed, Jun 8, 2016 at 4:11 PM, Kees Cook <keescook@chromium.org> wrote:
>> > The _etext position is defined to be the end of the kernel text code,
>> > and should not include any part of the data segments. This interferes
>> > with things that might check memory ranges and expect executable code
>> > up to _etext.
>> >
>> > Signed-off-by: Kees Cook <keescook@chromium.org>
>>
>> Can someone give this an Ack? I'd like to land it as it is a
>> prerequisite to some usercopy hardening work I'm doing.
>
> We use _etext to place the end of the "kernel code" resource in
> /proc/iomem, and init_mm.end_code.  I don't think anything makes
> use of init_mm.end_code, but I'm more worried about the resource.

Yeah, I looked at the init_mm.end_code thing and it appears to be
entirely aesthetics. The kernel code resource in /proc/iomem is
correct to end at the end of the kernel (this is what all other
architectures have too). That resource is used by kexec, and shouldn't
care about losing non-executable memory regions.

> Currently, because of where _etext is placed, "kernel code" covers
> the read-only data and other read-only sections as well - I don't
> know whether we need to preserve that, but this change has a side
> effect of changing that.

include/asm-generic/vmlinux.lds.h documents the expected underscore
names (and things like mem_init_print_info() operate on them. (Also of
note is that _sdata through _edata is supposed to cover both ro and rw
data, which isn't true for ARM, but isn't causing problems.
mem_init_print_info() handles overlaps/embedded areas, but things like
core_kernel_text() don't expect non-executable code in _stext through
_etext).

>
> Maybe we also need a "kernel rodata" resource?

This is already tracked with the standard markers of __start_rodata
and __end_rodata.

If you want to be extra cautious, we could change kernel_code.end to
be __init_begin - 1, maybe?

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
