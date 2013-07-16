From: akpm@linux-foundation.org (Andrew Morton)
Date: Tue, 16 Jul 2013 01:27:56 -0700
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <201307161008.07643.yann.morin.1998@free.fr>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716004727.b60b2c96.akpm@linux-foundation.org>
 <20130716005611.e4ccab02.akpm@linux-foundation.org>
 <201307161008.07643.yann.morin.1998@free.fr>
Message-ID: <20130716012756.31936d8d.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 16 Jul 2013 10:08:07 +0200 "Yann E. MORIN" <yann.morin.1998@free.fr> wrote:

> > Or, easier and faster, run some front-end script which generates
> > once-off Kconfig symbols.
> > 
> > 	if [ -x /bin/lz4c ]
> > 	then
> > 		echo CONFIG_HAVE_LZ4C
> > 	fi
> > 
> > then munge the output of that script into the Kconfig run and do
> > 
> > 	depends on HAVE_LZ4C
> 
> Yes, this is a better solution.
> 
> For what it's worth, this is what I'm doing in crosstool-NG: a script
> checks for optional pre-requisites, spits out a Kconfig blob which is
> included by the top-level Kconfig file.
> 
> Here is a snippet of generated Kconfig blob:
>     config HAVE_XZ
>         def_bool y
>     config HAVE_LZMA
>         bool
> 
> Which means we do have 'xz', but not 'lzma'. This is relatively trivial
> to do, so I'll tackle this this evening when I'm back home (unless
> someone beats me to it).

Cool, thanks.

It seems a bit inefficient to be evaluating commands in a Kconfig
setting where doesn't need that done.  For example, if someone has
selected LZO compression then they don't need to probe for lz4c.

That example sounds hard to solve in a simple fashion, but what about
the case where the config system is not going to look at an entire
subsystem?  Suppose for example, drivers/media/firewire wants to probe
for some executable, but the user hasn't selected firewire at all.

What I'm angling at is, rather than a single global front-end script,
can we embed the scripts in some fashion within the various Kconfig
files?  Say,

	script ./some-script.sh

and the config system will only evaluate that command if it is working
on that Kconfig file.  Obviously that requires a multiple-pass thing.

It's late, but you see what I mean ;)
