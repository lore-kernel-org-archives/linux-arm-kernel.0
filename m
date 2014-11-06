From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 06 Nov 2014 14:20:53 +0100
Subject: gcc 4.9 build warnings (was: Re: arm-soc build: 2917 warnings 0
 failures (arm-soc/v3.18-rc1-20-g06c0773))
In-Reply-To: <CAKv+Gu85h2hMsxtYrMeb_s0KdGfozQf908nmt_BvjhoFQdneow@mail.gmail.com>
References: <544a2a2e.a2db440a.6eeb.ffffaef3@mx.google.com>
 <20141106125857.GA12260@ulmo>
 <CAKv+Gu85h2hMsxtYrMeb_s0KdGfozQf908nmt_BvjhoFQdneow@mail.gmail.com>
Message-ID: <3756555.kWWoRymX5y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 06 November 2014 14:08:37 Ard Biesheuvel wrote:
> On 6 November 2014 13:59, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Thu, Nov 06, 2014 at 12:56:27PM +0100, Arnd Bergmann wrote:
> >> On Thursday 06 November 2014 12:49:22 Thierry Reding wrote:
> >> > GCC complains about the format specifier being wrong. %zu/%zd are the
> >> > correct specifiers for variables of type size_t/ssize_t, so wherever a
> >> > size_t or ssize_t is used as parameter it should have a corresponding
> >> > %zu or %zd specifier.
> >> >
> >> > Why not just fix it properly instead of mucking about with the size_t
> >> > typedef?
> >> >
> >>
> >> Yes, but where are %zu and %zd implemented in gcc? I've looked but
> >> couldn't find it. For all I can tell is that gcc's own interpretation
> >> of %z doesn't match its definition of __SIZE_TYPE__ when building for
> >> bare-metal.
> >
> > I think the code you're looking for is gcc/c-family/c-format.c in
> > function format_type_warning() (and its callers). Now my understanding
> > of GCC internals is fairly limited, but what I think is happening is
> > that the matching happens on the exact typedef, so even if size_t is
> > typedef'd to unsigned int and the argument is of type unsigned int the
> > check will still fail and cause the warning.
> >
> 
> Yes, that is what it looks like.

My reading is different, given this comment:

  /* If ARG_TYPE is a typedef with a misleading name (for example,
     size_t but not the standard size_t expected by printf %zu), avoid
     printing the typedef name.  */

I think what happens is that %z accepts size_t only when it is
defined to the right type, but prints a message with the raw
scalar type if the typedef does not match what %z expects.

> > Interestingly I can't seem to reproduce these warnings, neither with the
> > native compiler on my system nor a 4.9.0 ARM cross-compiler. I've used
> > the attached source file as a test case (derived from the code at line
> > 1244 in drivers/regmap/regmap.c, which causes the warning in one of your
> 
> The mystery is that arm-linux-gnueabihf-gcc does not produce the
> warning, whereas Olof's arm-none-eabi-gcc does (built from the same
> source version, as far as we can tell)

Right, and as Russell pointed out, that compiler has other issues
as well: the size of 'enum' is different and it does not define the
__linux__ macro.

	Arnd
