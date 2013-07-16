From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Tue, 16 Jul 2013 11:12:17 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130716090546.GB4402@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <20130716012756.31936d8d.akpm@linux-foundation.org>
 <20130716090546.GB4402@pd.tnic>
Message-ID: <201307161112.17901.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Borislav, All,

On Tuesday 16 July 2013 11:05:46 Borislav Petkov wrote:
> On Tue, Jul 16, 2013 at 01:27:56AM -0700, Andrew Morton wrote:
> > What I'm angling at is, rather than a single global front-end script,
> > can we embed the scripts in some fashion within the various Kconfig
> > files?  Say,
> > 
> > 	script ./some-script.sh
> > 
> > and the config system will only evaluate that command if it is working
> > on that Kconfig file.  Obviously that requires a multiple-pass thing.
> 
> What's wrong with simply grepping the .config we've just created for
> *enabled* symbols which require userspace support, check for the
> presence of said support and bail out if none?

The goal is to avoid generating a non-buildable kernel in the first place.
This is very usefull for automatic check harness that run randconfig, for
example (but may have more use-cases).

> I.e., those steps:
> 1. make <whatever>config
> 2. make => A prereq. target runs the shell script.

This is too late, since this will bail out, and will give a false-positive
failure.

While if we were to check for _known_ needed tools before calling into
Kconfig, we can simply hide non-available config options, and even inform
the user *why* the option is not available.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
