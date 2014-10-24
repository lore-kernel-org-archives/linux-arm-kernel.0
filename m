From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 24 Oct 2014 11:13:27 +0200
Subject: gcc 4.9 build warnings (was: Re: next build: 2674 warnings 1
 failures (next/next-20141022))
In-Reply-To: <CAOesGMh3ivsvrXpKj7J8tbSXnXutXJdkfm=sbo0j_eJVAQgFsg@mail.gmail.com>
References: <5447442c.a9ca440a.2060.5e09@mx.google.com>
 <3345399.JKaCjH1LWX@wuerfel>
 <CAOesGMh3ivsvrXpKj7J8tbSXnXutXJdkfm=sbo0j_eJVAQgFsg@mail.gmail.com>
Message-ID: <13842628.d0ipOeqpYt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 23 October 2014 13:33:13 Olof Johansson wrote:
> On Thu, Oct 23, 2014 at 1:31 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Thursday 23 October 2014 17:12:20 Russell King - ARM Linux wrote:
> >>
> >> > I haven't found the code in gcc that performs the type check for
> >> > printf, but I've found a comment about that code intentionally
> >> > resolving the type (printing 'unsigned int') when the typedef
> >> > does not match the expected type.
> >>
> >> If I had a copy of the GCC 4.9 source locally, I'd dig into it too and
> >> try to work out what's going on.  My gut feeling is that it's a bug in
> >> GCC rather than something which the kernel is doing wrong.
> >>
> >
> > I suspect it has something to do with the way that Olof's gcc is built,
> > since it doesn't happen for me using the same kernel source and gcc-4.9.1
> > or 4.10-prerelease.
> 
> Mine is a 4.9.1 built with segher's buildall scripts.
> 

Ok, that also explains the problems with the missing __linux__ macro, given
Ard's reply about bare-metal gcc.

I think we have two choices here:

a) change the buildall script so it actually builds a compiler that behaves
   in the way we expect for the kernel (__SIZE_TYPE__ and __linux__ at least,
   possibly others)

b) change the kernel to work with the way the bare-metal compiler is built,
   adding -D__linux__ in the ARM Makefile and applying Ard's workaround for
   __SIZE_TYPE__/__INT32_TYPE__/__UINT32_TYPE__/__UINTPTR_TYPE__.

Both options are a little hacky and I don't really like them, but I think
it makes sense to do one of them.

	Arnd
