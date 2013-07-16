From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Tue, 16 Jul 2013 11:25:14 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <CAGVrzcaTMckMKUObknT8abPyOzetuHzWtNPkF=Ae4zz7huShkQ@mail.gmail.com>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <CAGVrzcaTMckMKUObknT8abPyOzetuHzWtNPkF=Ae4zz7huShkQ@mail.gmail.com>
Message-ID: <201307161125.14491.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Florian, All,

On Tuesday 16 July 2013 11:13:24 Florian Fainelli wrote:
> 2013/7/16 Andrew Morton <akpm@linux-foundation.org>:
> > On Tue, 16 Jul 2013 00:47:27 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> >> On Mon, 15 Jul 2013 15:08:20 -0700 "H. Peter Anvin" <hpa@zytor.com> wrote:
> >>
> >> > On 07/15/2013 03:03 PM, Andrew Morton wrote:
> >> > >
> >> > > I don't know how to do this.  Any suggestions?
> >> > >
> >> > > It has to be done at `make config' time.  We'd need to probe for the
> >> > > presence of lz4c and then....  what?
> >> > >
> >> > > Is there any precedent for this?
> >> > >
> >> > > I don't think we can just ignore the absence of lz4c - the user has
> >> > > selected a config which his system cannot build.  The problem lies
> >> > > within randconfig itself.
> >> > >
> >> >
> >> > We keep running over the need to be able to have kconfig run tests on
> >> > the build system (for toolchain support or for optional tools needed);
> >> > running them in the Makefiles (i.e. at Kbuild time) is simply too late.
> >> >
> >>
> >> Would it make sense to extend Kconfig's `depends'?
> >>
> >>       depends on $(shell-command)
> >>
> >> I don't know how practical that would be to implement...
> >
> > Or, easier and faster, run some front-end script which generates
> > once-off Kconfig symbols.
> >
> >         if [ -x /bin/lz4c ]
> >         then
> >                 echo CONFIG_HAVE_LZ4C
> >         fi
> >
> > then munge the output of that script into the Kconfig run and do
> >
> >         depends on HAVE_LZ4C
> 
> That does sound nice to avoid the build error, but will eventually
> make it harder to diagnose why the kernel has not been compressed with
> the specific compression tool, some kind of warning should also be
> emitted maybe?

Either a warning at check-time, or a comment in Kconfig, such as:
    config COMPRESS_LZ4
        depends on HAVE_LZ4
    comment "'lz4' missing, LZ4 compression not available"
        depends on !HAVE_LZ4

Either way is fine with me. ;-)

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
