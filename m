From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 7 Dec 2013 18:10:52 +0000
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <201312052250.38986.arnd@arndb.de>
 <CAL_JsqLf0Ubi55mc-p0-qPwY0LzHEZ-SF9QwcELkKPfZH=9t_g@mail.gmail.com>
 <201312061741.33427.arnd@arndb.de>
 <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
Message-ID: <20131207181052.GR4360@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 06, 2013 at 02:01:51PM -0600, Rob Herring wrote:
> On Fri, Dec 6, 2013 at 10:41 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > This prevents you from building a plain v6 SMP kernel, and we've
> > had a variation of that since CONFIG_SMP was first marked non-BROKEN.
> 
> I'm saying a v6k enabled kernel would not work on pure v6 h/w. But
> since all implementations appear to support doubleword exclusives and
> there may not be any pure v6 only h/w, then we may never have a
> problem with the code below.

I wonder why we have the SMP_ON_UP option.  It's there so that we can
do exactly this - build a SMP kernel (so, one for V6K or later) _and_
have it run on non-SMP capable V6 platforms.

Now, while it's true that ARMv6 doesn't have the WFI instruction, and
that was introduced in ARMv6K, when we include support for ARMv6, we
don't use that instruction - we use its MCR equivalent.

Remember, we've specifically put work into the kernel so that ARMv6
can operate as part of the single zImage kernel precisely because we
have mixtures of SoCs which have this spread of architectures.

So, as far as I'm aware, today, a kernel which has V6, V6K and V7
will work across all those CPUs.

What's rather annoying in this thread is that you and Arnd are running
around seemingly making decisions on this without bothering to find out
the details, in persuit of endless cleanups.  Where is this heading?
Yet more fscking breakage of the ARM kernel, leading to platforms which
won't boot.  I'm getting rather sick and tired of cleaning up after
this kind of activity, so I'm going to tell you right now to stop this.

I've had to push a whole load of footbridge patches into stable kernels
during the last fortnight because of this.  For instance, Rob, your
changes to the way that VGA was supported on ARM pretty much broke the
whole thing leading to an oops on boot at 0xb80000.

Please stop this madness.
