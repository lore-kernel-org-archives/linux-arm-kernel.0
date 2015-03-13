From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 13 Mar 2015 12:52:09 +0100
Subject: [RFT/RFC PATCH 6/6] ARM: keep .text and .fixup regions together
In-Reply-To: <CAKv+Gu-bhir4J-vavJAzTYKEvrB5G9ijtLALbtmQOz-yvNAU9Q@mail.gmail.com>
References: <1426181892-15440-1-git-send-email-ard.biesheuvel@linaro.org>
 <3810696.X76shyuPzC@wuerfel>
 <CAKv+Gu-bhir4J-vavJAzTYKEvrB5G9ijtLALbtmQOz-yvNAU9Q@mail.gmail.com>
Message-ID: <4174992.WOHRCcIhdN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 13 March 2015 12:26:11 Ard Biesheuvel wrote:
> On 13 March 2015 at 12:18, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 12 March 2015 21:22:02 Russell King - ARM Linux wrote:
> >> On Thu, Mar 12, 2015 at 10:18:26PM +0100, Ard Biesheuvel wrote:
> >> > >> Note that the TEXT_TEXT macro will emit *(.text) again but this should be
> >> > >> harmless.
> >> > >
> >> > > However, I wonder if by doing this, we're weakening the ability for
> >> > > kallsyms final link to succeed:
> >> > >
> >> > > /* .text section. Map to function alignment to avoid address changes
> >> > >  * during second ld run in second ld pass when generating System.map */
> >> > >
> >> > > Can we not just move .fixup before TEXT_TEXT?  The only thing between it
> >> > > and .text would be .text.hot.
> >> > >
> >> >
> >> > Putting .fixup before .text already helps, but not enough for the
> >> > .config Arnd gave me that I have been testing this with.
> >> >
> >> > What *(.text .fixup) does (i.e., putting both section names inside the
> >> > parentheses), is emitting both sections for each input object file, so
> >> > they will always be close to the object that it refers to, so it is
> >> > not the same thing.
> >>
> >> I'll suggest a different solution then - how about modifying
> >> asm-generic/vmlinux.lds.h to change *(.text) to *(.text .text.fixup)
> >> and we move all the .fixup sections to .text.fixup ?  Arnd?
> >
> > No objections from me, but I really don't know enough about the possible
> > side-effects this may have on the other architectures, so we need to
> > run this by the linux-arch mailing list.
> >
> 
> I don't think it could affect any other architecture if nobody is
> populating .text.fixup yet.

Ah, I missed that part of the suggestion. Yes, sounds good to me then.

	Arnd
