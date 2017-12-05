From: keescook@chromium.org (Kees Cook)
Date: Tue, 5 Dec 2017 12:14:46 -0800
Subject: [PATCH] Arm: mm: ftrace: Only set text back to ro after kernel
 has been marked ro
In-Reply-To: <20171205200935.GY10595@n2100.armlinux.org.uk>
References: <20170823135836.52fb44fc@gandalf.local.home>
 <CAGXu5jLaQozk-TuZd8o=CK2kBcj3EFqD+VQtGX-DehU=c_TAkg@mail.gmail.com>
 <20170823150351.606ba09f@gandalf.local.home>
 <20171205114709.f6aj6i426keq2cn5@camel2.lan>
 <20171205131416.GW10595@n2100.armlinux.org.uk>
 <20171205132339.behn34z6b7ci2m4j@camel2.lan>
 <5b9b86cf-4b62-c984-fe52-a22df8fce33c@raspberrypi.org>
 <20171205133601.GX10595@n2100.armlinux.org.uk>
 <CAGXu5jJb0PCSuC4DuOkh5-901iVLcmmPpn1G7UBq3-r9DaeMvw@mail.gmail.com>
 <20171205200935.GY10595@n2100.armlinux.org.uk>
Message-ID: <CAGXu5jKvVpyLs0+zP34mG=XyGSkzeKFj6WtW+tTfKv7tLKsD2g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 5, 2017 at 12:09 PM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
> On Tue, Dec 05, 2017 at 11:35:59AM -0800, Kees Cook wrote:
>> We don't _need_ to, but they're all contiguous, so the ro_perms array
>> used by set_kernel_text_*() is actually only a single entry:
>>
>> static struct section_perm ro_perms[] = {
>>         /* Make kernel code and rodata RX (set RO). */
>>         {
>>                 .name   = "text/rodata RO",
>>                 .start  = (unsigned long)_stext,
>>                 .end    = (unsigned long)__init_begin,
>> ...
>
> Well, they may not be contiguous - it depends on DEBUG_ALIGN_RODATA.

Maybe I'm picking a slightly wrong word. I guess I meant adjacent. The
range _stext to __init_begin is all read-only, though there may be
padding (controlled by DEBUG_ALIGN_RODATA), to allow a split for NX
markings on rodata.

> Either way, we have __start_rodata_section_aligned, which is either
> the start of the read-only data section, or the start of the first
> section beyond __start_rodata if DEBUG_ALIGN_RODATA is not set.
>
> Given that __start_rodata_section_aligned will always be less than
> __init_begin, is there any reason not to make the above end at
> __start_rodata_section_aligned, thereby allowing more of the read-only
> data (in the case of DEBUG_ALIGN_RODATA=n) or all of the read-only
> data (in the case of DEBUG_ALIGN_RODATA=y) to remain write-protected?

Sure, there's no reason not to split this into two entries. It'll
require some reworking of the function calls to get it right,
obviously.

-Kees

-- 
Kees Cook
Pixel Security
