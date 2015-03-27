From: minipli@googlemail.com (Mathias Krause)
Date: Fri, 27 Mar 2015 08:16:38 +0100
Subject: String literals in __init functions
In-Reply-To: <20150326151557.61dfad84272aff10aaa4eba7@linux-foundation.org>
References: <5512F6C6.1020304@free.fr> <1427306517.2717.0.camel@perches.com>
 <5513FE2F.3040306@free.fr> <1427386390.15849.13.camel@perches.com>
 <CA+rthh9Fb2q+O_wicc6eNcbo6SzwOVZed=tnThJLF-xuoQ-+Cw@mail.gmail.com>
 <1427392393.15849.16.camel@perches.com>
 <CA+rthh8irf+tTSbomivu=bgN-L1k99TQ-q6UYgmMRC1PNOG7qw@mail.gmail.com>
 <20150326144058.56ef6916b00ad38030296089@linux-foundation.org>
 <1427407120.15849.34.camel@perches.com>
 <20150326151557.61dfad84272aff10aaa4eba7@linux-foundation.org>
Message-ID: <CA+rthh-_GeuCkkzQEXKwHPxKRy_24AdEC0ZdvYAnadEaEjBeqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26 March 2015 at 23:15, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Thu, 26 Mar 2015 14:58:40 -0700 Joe Perches <joe@perches.com> wrote:
>
>> > I'd have thought that a function-wide
>> >     __attribute__((__string_section__(foo))
>> > wouldn't be a ton of work to implement.
>>
>> Maybe not.
>>
>> Could some future version of gcc move string constants
>> in a function to a specific section marked in a manner
>> similar to what Andrew described above?
>
> One thing which might complexicate this is
>
> void foo()
> {
>         p("bar");
> }
>
> void  __attribute__((__string_section__(.init.rodata)) zot()
> {
>         p("bar");
> }
>
> It would be silly to create two instances of "bar".

No it wouldn't, because the "bar" in foo() has a different life time
than the "bar" in zot(). The compiler simply cannot know what the life
time of a section will be, so can only merge string within the same
section.

Beside that, your example is wrong and would generate a section
mismatch because zot() is not marked with __init so it's a function
that can be called after init. If one does, however, that p() will get
passed a dangling pointer. That's what modpost will complain about.

>
> Change it thusly:
>
>
> #define __mark_str(str) \
>         ({ static const char var[] __attribute__((__section__(".init.string"))) = str; var; })
>
> void foo()
> {
>         p("bar");
> }
>
> void zot()
> {
>         p(__mark_str("bar"));
> }
>
>
> and we indeed get two copies of "bar".
>
> It would be nice not to do that, but I guess that losing this
> optimization is a reasonable compromise.

As I said, it's legit to get two copies here, as the compiler simply
cannot deduce any semantics from the section name. However, this is a
synthetic example as in real life use-cases you'll only seldom have
the same format string be used twice. So this is, at best, a minor
issue.


Thanks,
Mathias
