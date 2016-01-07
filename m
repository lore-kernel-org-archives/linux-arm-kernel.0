From: keescook@chromium.org (Kees Cook)
Date: Thu, 7 Jan 2016 10:40:46 -0800
Subject: [PATCH v3] ARM: fix atags_to_fdt with stack-protector-strong
In-Reply-To: <20160107113029.GE19062@n2100.arm.linux.org.uk>
References: <20160106233656.GA9316@www.outflux.net>
 <20160107113029.GE19062@n2100.arm.linux.org.uk>
Message-ID: <CAGXu5jJS1RTpwA9TRCP1y1Qm-g0OXADSb1omr_5rNFirVTovuw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 7, 2016 at 3:30 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Jan 06, 2016 at 03:36:56PM -0800, Kees Cook wrote:
>> diff --git a/arch/arm/boot/compressed/Makefile b/arch/arm/boot/compressed/Makefile
>> index 3f9a9ebc77c3..d7d2c2981f65 100644
>> --- a/arch/arm/boot/compressed/Makefile
>> +++ b/arch/arm/boot/compressed/Makefile
>> @@ -106,6 +106,14 @@ ORIG_CFLAGS := $(KBUILD_CFLAGS)
>>  KBUILD_CFLAGS = $(subst -pg, , $(ORIG_CFLAGS))
>>  endif
>>
>> +# -fstack-protector-strong triggers protection checks in this code,
>> +# but it is being used too early to link to meaningful stack_chk logic.
>> +CFLAGS_atags_to_fdt.o := $(call cc-option, -fno-stack-protector)
>> +CFLAGS_fdt.o := $(call cc-option, -fno-stack-protector)
>> +CFLAGS_fdt_ro.o := $(call cc-option, -fno-stack-protector)
>> +CFLAGS_fdt_rw.o := $(call cc-option, -fno-stack-protector)
>> +CFLAGS_fdt_wip.o := $(call cc-option, -fno-stack-protector)
>
> This will result in "$(call cc-option, -fno-stack-protector)" being
> called five times when this Makefile is parsed, which seems very
> wasteful.  I'm sure there's better solutions to that - maybe caching
> the value in a variable in a higher level makefile (eg,
> arch/arm/Makefile) ?

Good point; I will adjust this to get a single invocation.

> Also, I suspect that all of the decompressor should be built with
> -fno-stack-protector as we don't have sufficient environment here.
> Maybe it should be placed in the global CFLAGS for the decompressor?

I prefer keeping it disabled in as narrow a range as possible. If
other code gains a level of complexity that it triggers the stack
protector code insertion, I think that's worth examining when it
happens. If this ever becomes an actual burden, then yeah, let's do it
for the whole decompressor, but I think it'd be best to revisit it if
it happens again.

-Kees

-- 
Kees Cook
Chrome OS & Brillo Security
