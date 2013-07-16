From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Tue, 16 Jul 2013 10:08:07 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130716005611.e4ccab02.akpm@linux-foundation.org>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
Message-ID: <201307161008.07643.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew, All,

On Tuesday 16 July 2013 09:56:11 Andrew Morton wrote:
> On Tue, 16 Jul 2013 00:47:27 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> > On Mon, 15 Jul 2013 15:08:20 -0700 "H. Peter Anvin" <hpa@zytor.com> wrote:
> > > On 07/15/2013 03:03 PM, Andrew Morton wrote:
[--SNIP--]
> > > We keep running over the need to be able to have kconfig run tests on
> > > the build system (for toolchain support or for optional tools needed);
> > > running them in the Makefiles (i.e. at Kbuild time) is simply too late.
> > > 
> > 
> > Would it make sense to extend Kconfig's `depends'?
> > 
> > 	depends on $(shell-command)
> > 
> > I don't know how practical that would be to implement...

I'm afraid this will get rather ugly and not trivial.

Can we mix 'depends on SYMBOL' and 'depends on $(command)' ?
Can we mix both in a boolean expression such as 'depends on SYMBOL
&& $(command)' ?

What would be the condition for evaluating the dependency rule? Evaluation
at Kconfig read-time might not be enough, given this construct:

    config FOO
        depends on $(foo)
    comment "'foo' is missing, please install it"
        depends on !$(foo)

Also, I believe Kconfig should stay a config-only language, without
much esoteric features.

> Or, easier and faster, run some front-end script which generates
> once-off Kconfig symbols.
> 
> 	if [ -x /bin/lz4c ]
> 	then
> 		echo CONFIG_HAVE_LZ4C
> 	fi
> 
> then munge the output of that script into the Kconfig run and do
> 
> 	depends on HAVE_LZ4C

Yes, this is a better solution.

For what it's worth, this is what I'm doing in crosstool-NG: a script
checks for optional pre-requisites, spits out a Kconfig blob which is
included by the top-level Kconfig file.

Here is a snippet of generated Kconfig blob:
    config HAVE_XZ
        def_bool y
    config HAVE_LZMA
        bool

Which means we do have 'xz', but not 'lzma'. This is relatively trivial
to do, so I'll tackle this this evening when I'm back home (unless
someone beats me to it).

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
