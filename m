From: pavel@ucw.cz (Pavel Machek)
Date: Tue, 7 Feb 2017 08:36:07 +0100
Subject: [PATCHv2 1/2] arch: Move CONFIG_DEBUG_RODATA and
 CONFIG_SET_MODULE_RONX to be common
In-Reply-To: <f88765d3-4c45-542e-892b-33a6c3c3c4d2@redhat.com>
References: <1486144343-24998-1-git-send-email-labbott@redhat.com>
 <1486144343-24998-2-git-send-email-labbott@redhat.com>
 <CAGXu5jK6_y=dWHUDBto7ykN_sSOQ6Gx+sZs_gQ1Hoh5DjP-fTw@mail.gmail.com>
 <20170203202919.GE27312@n2100.armlinux.org.uk>
 <CAGXu5j+HOTHRrFJFMsMaAvqcTAUoEBuphzrYAr7VAjJQU9_RYA@mail.gmail.com>
 <f88765d3-4c45-542e-892b-33a6c3c3c4d2@redhat.com>
Message-ID: <20170207073607.GA32054@amd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 2017-02-06 10:47:45, Laura Abbott wrote:
> On 02/03/2017 01:08 PM, Kees Cook wrote:
> > On Fri, Feb 3, 2017 at 12:29 PM, Russell King - ARM Linux
> > <linux@armlinux.org.uk> wrote:
> >> On Fri, Feb 03, 2017 at 11:45:56AM -0800, Kees Cook wrote:
> >>> On Fri, Feb 3, 2017 at 9:52 AM, Laura Abbott <labbott@redhat.com> wrote:
> >>>> diff --git a/arch/Kconfig b/arch/Kconfig
> >>>> index 99839c2..22ee01e 100644
> >>>> --- a/arch/Kconfig
> >>>> +++ b/arch/Kconfig
> >>>> @@ -781,4 +781,32 @@ config VMAP_STACK
> >>>>           the stack to map directly to the KASAN shadow map using a formula
> >>>>           that is incorrect if the stack is in vmalloc space.
> >>>>
> >>>> +config ARCH_NO_STRICT_RWX_DEFAULTS
> >>>> +       def_bool n
> >>>> +
> >>>> +config ARCH_HAS_STRICT_KERNEL_RWX
> >>>> +       def_bool n
> >>>> +
> >>>> +config DEBUG_RODATA
> >>>> +       def_bool y if !ARCH_NO_STRICT_RWX_DEFAULTS
> >>>> +       prompt "Make kernel text and rodata read-only" if ARCH_NO_STRICT_RWX_DEFAULTS
> >>>
> >>> Ah! Yes, perfect. I totally forgot about using conditional "prompt"
> >>> lines. Nice!
> >>
> >> It's no different from the more usual:
> >>
> >>         bool "Make kernel text and rodata read-only" if ARCH_NO_STRICT_RWX_DEFAULTS
> >>         default y if !ARCH_NO_STRICT_RWX_DEFAULTS
> >>         depends on ARCH_HAS_STRICT_KERNEL_RWX
> >>
> >> But... I really don't like this - way too many negations and negatives
> >> which make it difficult to figure out what's going on here.
> >>
> >> The situation we have today is:
> >>
> >> -config DEBUG_RODATA
> >> -       bool "Make kernel text and rodata read-only"
> >> -       depends on MMU && !XIP_KERNEL
> >> -       default y if CPU_V7
> >>
> >> which is "allow the user to select DEBUG_RODATA if building a MMU non-XIP
> >> kernel", suggesting that the user turns it on for ARMv7 CPUs.
> >>
> >> That changes with this and the above:
> >>
> >> +       select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> >> +       select ARCH_HAS_STRICT_MODULE_RWX if MMU
> >> +       select ARCH_NO_STRICT_RWX_DEFAULTS if !CPU_V7
> >>
> >> This means that ARCH_HAS_STRICT_KERNEL_RWX is set for a MMU non-XIP
> >> kernel, which carries the same pre-condition for DEBUG_RODATA - no
> >> problem there.
> >>
> >> However, ARCH_NO_STRICT_RWX_DEFAULTS is set for non-ARMv7 CPUs, which
> >> means the "Make kernel text and rodata read-only" prompt _is_ provided
> >> for those.  However, for all ARMv7 systems, we go from "suggesting that
> >> the user enables the option" to "you don't have a choice, you get this
> >> whether you want it or not."
> >>
> >> I'd prefer to keep it off for my development systems, where I don't
> >> care about kernel security.  If we don't wish to do that as a general
> >> rule, can we make it dependent on EMBEDDED?
> >>
> >> Given that on ARM it can add up to 4MB to the kernel image - there
> >> _will_ be about 1MB before the .text section, the padding on between
> >> __modver and __ex_table which for me is around 626k, the padding
> >> between .notes and the init sections start with .vectors (the space
> >> between __ex_table and end of .notes is only 4124, which gets padded
> >> up to 1MB) and lastly the padding between the .init section and the
> >> data section (for me around 593k).  This all adds up to an increase
> >> in kernel image size of 3.2MB on 14.2MB - an increase of 22%.
> >>
> >> So no, I'm really not happy with that.
> > 
> > Ah yeah, good point. We have three cases: unsupported, mandatory,
> > optional, but we have the case of setting the default for the optional
> > case. Maybe something like this?
> > 
> > config STRICT_KERNEL_RWX
> >   bool "Make kernel text and rodata read-only" if ARCH_OPTIONAL_KERNEL_RWX
> >   depends on ARCH_HAS_STRICT_KERNEL_RWX
> >   default ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> > 
> > unsupported:
> > !ARCH_HAS_STRICT_KERNEL_RWX
> > 
> > mandatory:
> > ARCH_HAS_STRICT_KERNEL_RWX
> > !ARCH_OPTIONAL_KERNEL_RWX
> > 
> > optional:
> > ARCH_HAS_STRICT_KERNEL_RWX
> > ARCH_OPTIONAL_KERNEL_RWX
> > with default controlled by ARCH_OPTIONAL_KERNEL_RWX_DEFAULT
> > 
> > Then arm is:
> >   select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
> >   select ARCH_HAS_STRICT_MODULE_RWX if MMU
> >   select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
> >   select ARCH_OPTIONAL_KERNEL_RWX_DEFAULT if CPU_V7
> > 
> > x86 and arm64 are:
> >   select ARCH_HAS_STRICT_KERNEL_RWX
> >   select ARCH_HAS_STRICT_MODULE_RWX
> > 
> > ?
> > 
> > -Kees
> > 
> 
> Yes, that looks good. I wanted it to be mandatory to avoid the
> mindset of "optional means we don't need it" but I see there
> are some cases where it's better to turn it off. I'll see if
> I can emphasize this properly in the help text ("Say Y here
> unless you love security exploits running in production")

What about fixing the memory wastage, instead? If you want something
almost-always-on, it should not waste megabytes of memory.

And BTW it is help text, not advertising for your favourite feature.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 181 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170207/41000471/attachment-0001.sig>
