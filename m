From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 8 Dec 2013 04:39:45 +0100
Subject: [PATCH] ARM: clean-up common multi-platform kconfig options
In-Reply-To: <20131207181052.GR4360@n2100.arm.linux.org.uk>
References: <1386262722-26016-1-git-send-email-robherring2@gmail.com>
 <CAL_JsqJmwPwVmNzibr8S-RH8ibwCzXVFMdJA-STPTHG+H0113w@mail.gmail.com>
 <20131207181052.GR4360@n2100.arm.linux.org.uk>
Message-ID: <201312080439.46063.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 07 December 2013, Russell King - ARM Linux wrote:
> So, as far as I'm aware, today, a kernel which has V6, V6K and V7
> will work across all those CPUs.
> 
> What's rather annoying in this thread is that you and Arnd are running
> around seemingly making decisions on this without bothering to find out
> the details, in persuit of endless cleanups.  Where is this heading?

I admit that we've been stumbling a bit in the dark at some points, but
that doesn't mean every idea ends up in a patch that even gets submitted.

What I've concluded so far is (please correct any statements that you
find are wrong):

* there is no harm in "select HAVE_SMP if CPU_V7" for multiplatform, as
  was the original suggestion. Whether we want to actually do that is
  open for discussion when someone submits a patch.

* It was a mistake (I guess mine) to 'select CPU_V6' from ARCH_MULTI_V6,
  since that makes V6K based platforms slower without a reason, and we
  probably want to do something else.

* A kernel which enables V6, V6K and V7 has a broken kuser_cmpxchg64
  implementation on pre-V6K CPUs.

* Most platforms (possibly every one but OMAP2) that select CPU_V6
  today are actually V6K compatible. It's probably worth asking those
  V6 platform maintainers to change their CPU selection after confirming
  that they are V6K-only.

* I'm still trying to understand the full implications of
  CONFIG_CPU_USE_DOMAIN, but according to the comment in 247055aa21ffe
  "ARM: 6384/1: Remove the domain switching on ARMv6k/v7 CPUs", it seems
  to be a bug to enable this on v6k or v7 CPUs, which we currently do
  whenever CPU_V6 (implied by CONFIG_MULTI_V6) is enabled.

	Arnd
