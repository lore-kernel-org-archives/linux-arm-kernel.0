From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 May 2013 10:05:34 +0100
Subject: [PATCH] arch: configuration, deleting 'CONFIG_BUG' since
 always need it.
In-Reply-To: <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
References: <519DCBEF.3090208@asianux.com>
 <CAMuHMdU7QuzgmWCH145p8PVebBzPo8DBAvbY+0AZa2cmGXmRHw@mail.gmail.com>
Message-ID: <20130523090534.GJ18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 23, 2013 at 10:40:29AM +0200, Geert Uytterhoeven wrote:
> On Thu, May 23, 2013 at 9:57 AM, Chen Gang <gang.chen@asianux.com> wrote:
> > -config BUG
> > -       bool "BUG() support" if EXPERT
> > -       default y
> > -       help
> > -          Disabling this option eliminates support for BUG and WARN, reducing
> > -          the size of your kernel image and potentially quietly ignoring
> > -          numerous fatal conditions. You should only consider disabling this
> > -          option for embedded systems with no facilities for reporting errors.
> > -          Just say Y.
> 
> ... It's about reducing memory size on devices where you can't show bug or
> warning messages.

And turning off CONFIG_BUG causes lots of warning messages at compile time
about functions which are returning nothing which shouldn't.

The problem is: trying to fix that _will_ mean the result is a larger
kernel than if you just do the usual arch-implemented thing of placing
an defined faulting instruction at the BUG() site - which defeats the
purpose of turning off CONFIG_BUG.

Therefore, it's better that CONFIG_BUG always be y and we stop kidding
ourselves that it's possible to turn this off and safely save space.
