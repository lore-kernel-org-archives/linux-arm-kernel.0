From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Thu, 18 Jul 2013 09:47:02 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130718003408.bb9d5b51.akpm@linux-foundation.org>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <CAMuHMdXzcRxEBqavTx-kEq6CNAx5fYug0w8kjDw=vNfS2iX4Fw@mail.gmail.com>
 <20130718003408.bb9d5b51.akpm@linux-foundation.org>
Message-ID: <201307180947.02456.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, All,

On Thursday 18 July 2013 09:34:08 Andrew Morton wrote:
> On Thu, 18 Jul 2013 09:22:58 +0200 Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Thu, Jul 18, 2013 at 12:30 AM, Yann E. MORIN <yann.morin.1998@free.fr> wrote:
> > > On 2013-07-17 23:16 +0200, Sam Ravnborg spake thusly:
> > >> > We could extend the symbol option part to retreive values from a binary.
> > >> > Something like this:
> > >> >
> > >> > config FOOBAR
> > >> >         bool
> > >> >         option exec="true"
> > >> >
> > >> > FOOBAR would assume the value "y" if the command true has exit code == 0, otherwise "n".
> > >> > And similar conversions for other types.
> > >> >
> > >> > This only extendt Kconfig slightly - using an already present method to import
> > >> > external values.
> > >> Following is a quick patch implmenting this idea.
> > >> You need to run gperf manually to enable this.
> > >>
> > >> "gperf -C scripts/kconfig/zconf.gperf > scripts/kconfig/zconf.hash.c"
> > >>
> > >> I did not figure out how to use the built-in rules to generate this file :-(
> > >
> > > make REGENERATE_PARSERS=y menuconfig
> > >
> > >> I have tested this lightly - as we should discuss if this is a viable way forward.
> > >
> > > Instead of extending the Kconfig language, I was thinking (as initially
> > > suggested by Andrew) of generating a Kconfig file before all config
> > > targets, and source that Kconfig file from $(TOPDIR)/Kconfig.
> > 
> > I also prefer the generated Kconfig file.
> > It keeps all these checks in a single place, instead of spreading it over all
> > Kconfig files. This allows to keep better control over the list of checks, and
> > notice when it gets out-of-hand.
> 
> I prefer the "option exec" approach, actually.  That way the shell-outs
> are colocated with the code which uses

Indeed, but in this case, all the checks will be spread-out in the Kconfig
files, and not easily locatable. Having all in a single script will also
more easily raise eyebrows when that script appears in a diffstat. Noticing
the 'exec' option risks being a bit less easy.

But, that's not my call to decide. ;-)

> them and they will only be executed
> if you've actually selected that subsystem for building (I think?).

If I understand the code correctly (which is still to be proven), the
exec option is run at parse-time, once.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
