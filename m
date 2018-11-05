From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 5 Nov 2018 19:14:50 +0000
Subject: [PATCH 0/6] ARM: compressed: clean up section layout and enable
 EFI debugging
In-Reply-To: <CAKv+Gu8rQZ49uB6qVqZj4QWGjCLv1LGcSkDrZ-TEZMN5JbQ6FQ@mail.gmail.com>
References: <20181105184438.19494-1-ard.biesheuvel@linaro.org>
 <20181105190908.GV30658@n2100.armlinux.org.uk>
 <CAKv+Gu8rQZ49uB6qVqZj4QWGjCLv1LGcSkDrZ-TEZMN5JbQ6FQ@mail.gmail.com>
Message-ID: <20181105191450.GX30658@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 05, 2018 at 08:10:48PM +0100, Ard Biesheuvel wrote:
> On 5 November 2018 at 20:09, Russell King - ARM Linux
> <linux@armlinux.org.uk> wrote:
> > On Mon, Nov 05, 2018 at 07:44:32PM +0100, Ard Biesheuvel wrote:
> >> Currently, the decompressor section layout is somewhat unusual: head.S
> >> puts code into a .start and a .text section, which are expected to be
> >> emitted back to back, unless other objects are included that define a
> >> .start section as well, in which case execution is expected to proceed
> >> linearly from head.S's section .start section into the other .start
> >> section and then onward into head.S's .text section.
> >>
> >> This relies on the input files to be consumed by the linker in the same
> >> order they were specified on the command line, but this is not actually
> >> guaranteed by the linker, so it is better to make the inclusion of this
> >> code specific by using function calls.
> >
> > I think you're wrong about that - as I've pointed out, this behaviour
> > is relied upon quite heavily when linking programs using GCC, so while
> > it may not be explicitly specified, the fact that GCC relies upon it
> > when creating shared libraries (using crti.o before any object files,
> > and crtn.o at the end) means that it's pretty much guaranteed.
> >
> > What is less guaranteed is proceeding between two sections, but these
> > separate sections in object files are combined into one .text section
> > in the output file, and so we know that code in .start will be present
> > _before_ any code in .text.
> >
> > Put the two things together, and the code from head.S will be listed
> > first, and therefore will be output first in the .start and .text
> > sections.  Other object files will have code placed into the output
> > .text section accordingly.
> >
> > So really I see no point to your patch 1 to 5, other than change for
> > change's sake.
> >
> > Can you _prove_ that there is a problem here - if you can, it's likely
> > that such a problem also affects gcc -shared too.
> >
> 
> As I replied in the other patch, GCC's builtin linker script uses
> SORT_NONE(), and probably does so for a reason.

To disregard any command line section sorting option that may be
supplied by the user.  That is not the case here.  Please read the
LD manual, specifically the "Input Section Wildcards" section.

Thanks.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
