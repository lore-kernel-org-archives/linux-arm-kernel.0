From: minipli@googlemail.com (Mathias Krause)
Date: Fri, 27 Mar 2015 08:05:09 +0100
Subject: String literals in __init functions
In-Reply-To: <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
Message-ID: <CA+rthh9H4C6b=eGdNmFj3Vb+rHUCPOuaDL1h5i_WXWtNGZYS2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 22:40, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 26 Mar 2015 21:49:06 +0100 Mathias Krause <minipli@googlemail.com> wrote:
>
>> Andrew, what's your opinion on such a patch set? Do you too think it's
>> useful? Or do you share Ingo's fear about the additional maintenance
>> burden?
>
> I don't think the burden would be toooo high, although it will mess the
> code up a bit.
>
> The post-build checking for section reference mismatches will help,
> although that seems to have got itself turned off (what happened
> there?).

Seem to be working fine here.

This is make M=lib/, building the test module:
  CC [M]  lib/test_module.o
  Building modules, stage 2.
  MODPOST 1 modules
  LD [M]  lib/test_module.ko

This is the same module with two pi_info() calls in a non-__init
function, therefore generating section mismatches:
  CC [M]  lib/test_module.o
  Building modules, stage 2.
  MODPOST 1 modules
WARNING: modpost: Found 2 section mismatch(es).
To see full details build your kernel with:
'make CONFIG_DEBUG_SECTION_MISMATCH=y'
  LD [M]  lib/test_module.ko

> Did anyone look at writing a postprocessor for the .s files?  It
> doesn't look like it will be too hard from an initial peek.
>
> Did anyone ask the gcc developers?  I'd have thought that a function-wide
>
>         __attribute__((__string_section__(foo))
>
> wouldn't be a ton of work to implement.

The point is you cannot blindly mark all strings referenced from
__init / __exit code to end up in a matching string section because
strings in this code might have to live longer when passed to
functions keeping a pointer on them. For example, the name passed to
class_create() won't be copied. If that one would go into the
.init.rodata section automatically, we would have dangling pointers
after the .init.* memory got freed.
To know if it's safe to automatically put a string into an .init /
.exit section one needs to see the whole code. That's why I'm
reasoning it needs to be an LTO pass, not a .s post-processor or
function wide section attribute. Or, as in my approach, a source level
annotation.

Thanks,
Mathias
