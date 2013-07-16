From: yann.morin.1998@free.fr (Yann E. MORIN)
Date: Tue, 16 Jul 2013 11:32:39 +0200
Subject: [PATCH -next 2/2] kbuild: fix for updated LZ4 tool with the new
 streaming format
In-Reply-To: <20130716092242.GD4402@pd.tnic>
References: <1367829775-4434-1-git-send-email-kyungsik.lee@lge.com>
 <201307161112.17901.yann.morin.1998@free.fr> <20130716092242.GD4402@pd.tnic>
Message-ID: <201307161132.39845.yann.morin.1998@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Borislav, All,

On Tuesday 16 July 2013 11:22:42 Borislav Petkov wrote:
> On Tue, Jul 16, 2013 at 11:12:17AM +0200, Yann E. MORIN wrote:
> > The goal is to avoid generating a non-buildable kernel in the first place.
> 
> I know, that's why I'm proposing to fail the build with the script run
> as one of the first things by make.

No, this is already too late: the given .config *is* already broken and
unbuildable.

> > > I.e., those steps:
> > > 1. make <whatever>config
> > > 2. make => A prereq. target runs the shell script.
> > 
> > This is too late, since this will bail out, and will give a false-positive
> > failure.
> 
> Huh? This will tell you: "you've selected X, but I don't have toolX
> needed for the build".
> 
> You install the tool and run make again. Checks pass, the build
> continues.

That does not work in two cases:
  - older distros that do not have the tool packaged
  - automatic test-harness that run thousands of randconfig a day

In the first case, this /could/ be overcome by the user compiling and
installing the package manually, but is mostly undoable in enterprise
environment with shared build machines, where each user would have to
install the same tool(s) again and again.

In the second case, this would yield a lot of false-positive in daily
reports.

Your solution mostly works with minimum overhead for a human user
interactively building a kernel, not with automated test harnesses.

> > While if we were to check for _known_ needed tools before calling into
> > Kconfig,
> 
> How would you do that? How do you know what the user is going to select
> *before* she even selects it?

The idea is to *avoid* the user being able to select unavailable options.

> You need to have a prepared .config to act upon.

The idea is to be always have a .config that is buildable with the current
toolset of the system, especially for esoteric and/or recent tools that are
not packaged and/or installed by default by the distros.

Regards,
Yann E. MORIN.

-- 
.-----------------.--------------------.------------------.--------------------.
|  Yann E. MORIN  | Real-Time Embedded | /"\ ASCII RIBBON | Erics' conspiracy: |
| +0/33 662376056 | Software  Designer | \ / CAMPAIGN     |   ^                |
| --==< O_o >==-- '------------.-------:  X  AGAINST      |  /e\  There is no  |
| http://ymorin.is-a-geek.org/ | (*_*) | / \ HTML MAIL    |  """  conspiracy.  |
'------------------------------'-------'------------------'--------------------'
