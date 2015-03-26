From: joe@perches.com (Joe Perches)
Date: Thu, 26 Mar 2015 10:53:13 -0700
Subject: String literals in __init functions
In-Reply-To: <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
Message-ID: <1427392393.15849.16.camel@perches.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-03-26 at 17:37 +0100, Mathias Krause wrote:
> On 26 March 2015 at 17:13, Joe Perches <joe@perches.com> wrote:
> > On Thu, 2015-03-26 at 13:40 +0100, Mason wrote:
> >> On 25/03/2015 19:01, Joe Perches wrote:
> >> > On Wed, 2015-03-25 at 18:56 +0100, Mason wrote:
> >> >
> >> >> AFAIU, functions only used at system init are tagged __init to have
> >> >> the linker store them in a separate .init.text section, so memory can
> >> >> be reclaimed once initialization is complete. Is that correct?
> >> >>
> >> >> The corresponding tag for data is __initdata (section .init.data)
> >> >>
> >> >> I started wondering if the string literals used in an __init functions
> >> >> were automatically marked __initdata.
> >> >>
> >> >> Looking at the objdump output, I see that the string literals are,
> >> >> in fact, stored in the .rodata section. I suppose that .rodata is NOT
> >> >> reclaimed after init?
> >> >>
> >> >> [...]
> >> >>
> >> >> Did I miss something in init.h?
> >> >> Or should it be done like above to reclaim string literals?
> >> >
> >> > No, you didn't miss anything.
> >> >
> >> > One proposal:
> >> >
> >> > https://lkml.org/lkml/2014/8/21/255
> >>
> >> Thanks for the link!
> >>
> >> Here's the equivalent gmane link for my own reference:
> >> http://thread.gmane.org/gmane.linux.kernel/1771969
> >>
> >> Basically, if I understand correctly, Ingo NAKed the patch, saying
> >> this should be done automatically by the toolchain. That would make
> >> for an interesting side-project...
> >
> > True.  It's probably not feasible though.
> >
> > Tracking string deduplication/reuse would be pretty difficult.
> 
> Yep, that's why I simply didn't attempt to write a "toolchain" to
> automatically put strings into the appropriate section. String
> annotation and deduplication is best done in the compiler. It already
> does impressive tricks to limit the amount of actual strings ending up
> in the binary. If one would try to write a compiler plugin to
> automatically flag __init / __exit strings it would have to be an LTO
> pass as only there one would have the complete view where the string
> will end up. It's not as simple as blindly marking all strings used in
> __init / __exit functions to end up in the corresponding .rodata
> section because those strings may be passed to functions that want to
> keep a pointer, e.g. as an object name. But not all functions do! So
> only an LTO pass *may* see the whole usage of a possible __init /
> __exit string. Therefore I'm still not convinced that solving the
> problem in the toolchain is the right thing to do. It's *way* more
> complicated and probably gets it wrong more often than not. Therefore
> the straight simple approach of manually marking the strings is IMHO
> the best solution. Unfortunately, not everyone shares this opinion :/

At least a few do though.

The first 4 patches still apply and are useful in my opinion.

Maybe you could resend them as a new patch set and cc Andrew Morton.
(cc'd here too)
