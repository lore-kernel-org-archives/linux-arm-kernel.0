From: akpm@linux-foundation.org (Andrew Morton)
Date: Thu, 18 Jul 2013 00:34:08 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <CAMuHMdXzcRxEBqavTx-kEq6CNAx5fYug0w8kjDw=vNfS2iX4Fw@mail.gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <201307161008.07643.yann.morin.1998@free.fr>
 <20130716180408.GA19863@merkur.ravnborg.org>
 <20130717211649.GA5619@merkur.ravnborg.org>
 <20130717223033.GF3385@free.fr>
 <CAMuHMdXzcRxEBqavTx-kEq6CNAx5fYug0w8kjDw=vNfS2iX4Fw@mail.gmail.com>
Message-ID: <20130718003408.bb9d5b51.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 18 Jul 2013 09:22:58 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> On Thu, Jul 18, 2013 at 12:30 AM, Yann E. MORIN <yann.morin.1998@free.fr> wrote:
> > On 2013-07-17 23:16 +0200, Sam Ravnborg spake thusly:
> >> > We could extend the symbol option part to retreive values from a binary.
> >> > Something like this:
> >> >
> >> > config FOOBAR
> >> >         bool
> >> >         option exec="true"
> >> >
> >> > FOOBAR would assume the value "y" if the command true has exit code == 0, otherwise "n".
> >> > And similar conversions for other types.
> >> >
> >> > This only extendt Kconfig slightly - using an already present method to import
> >> > external values.
> >> >
> >> > The drawback I see with this approach is that we may execute a lot of small programs
> >> > where the value is never used.
> >>
> >> Following is a quick patch implmenting this idea.
> >> You need to run gperf manually to enable this.
> >>
> >> "gperf -C scripts/kconfig/zconf.gperf > scripts/kconfig/zconf.hash.c"
> >>
> >> I did not figure out how to use the built-in rules to generate this file :-(
> >
> > make REGENERATE_PARSERS=y menuconfig
> >
> >> I have tested this lightly - as we should discuss if this is a viable way forward.
> >
> > Instead of extending the Kconfig language, I was thinking (as initially
> > suggested by Andrew) of generating a Kconfig file before all config
> > targets, and source that Kconfig file from $(TOPDIR)/Kconfig.
> 
> I also prefer the generated Kconfig file.
> It keeps all these checks in a single place, instead of spreading it over all
> Kconfig files. This allows to keep better control over the list of checks, and
> notice when it gets out-of-hand.

I prefer the "option exec" approach, actually.  That way the shell-outs
are colocated with the code which uses them and they will only be executed
if you've actually selected that subsystem for building (I think?).
