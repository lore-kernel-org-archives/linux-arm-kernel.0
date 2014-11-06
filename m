From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 6 Nov 2014 13:59:00 +0100
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <2700572.p8cKrIiMH5@wuerfel>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <CAKv+Gu-0jenous5sLPp+QJa3qRk-RiBgG1vVYP_RmVw0uXaysw@mail.gmail.com>
 <20141106114919.GL26297@ulmo> <2700572.p8cKrIiMH5@wuerfel>
Message-ID: <20141106125857.GA12260@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 06, 2014 at 12:56:27PM +0100, Arnd Bergmann wrote:
> On Thursday 06 November 2014 12:49:22 Thierry Reding wrote:
> > GCC complains about the format specifier being wrong. %zu/%zd are the
> > correct specifiers for variables of type size_t/ssize_t, so wherever a
> > size_t or ssize_t is used as parameter it should have a corresponding
> > %zu or %zd specifier.
> > 
> > Why not just fix it properly instead of mucking about with the size_t
> > typedef?
> > 
> 
> Yes, but where are %zu and %zd implemented in gcc? I've looked but
> couldn't find it. For all I can tell is that gcc's own interpretation
> of %z doesn't match its definition of __SIZE_TYPE__ when building for
> bare-metal.

I think the code you're looking for is gcc/c-family/c-format.c in
function format_type_warning() (and its callers). Now my understanding
of GCC internals is fairly limited, but what I think is happening is
that the matching happens on the exact typedef, so even if size_t is
typedef'd to unsigned int and the argument is of type unsigned int the
check will still fail and cause the warning.

Interestingly I can't seem to reproduce these warnings, neither with the
native compiler on my system nor a 4.9.0 ARM cross-compiler. I've used
the attached source file as a test case (derived from the code at line
1244 in drivers/regmap/regmap.c, which causes the warning in one of your
logs). Can you verify that the same warning happens when you run your
compiler on that? I've tried compiling with something like this:

	$ gcc -Wall -Wextra -Wformat=2 -c test.c

I don't think all of these are necessary, plain -Wformat /should/ be
enough.

It's weird because both operands of the division are size_t, so I'm
guessing the compiler looses the type information at some point.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: test.c
Type: text/x-c
Size: 126 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/afcf7781/attachment-0001.bin>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141106/afcf7781/attachment-0001.sig>
