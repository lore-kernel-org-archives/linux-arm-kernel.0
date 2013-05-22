From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 22 May 2013 17:53:53 +0100
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <20130522155347.GJ1627@sirena.org.uk>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
 <20130522155347.GJ1627@sirena.org.uk>
Message-ID: <20130522165353.GB18714@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 22 May 2013, Mark Brown wrote:

> On Wed, May 22, 2013 at 01:47:33PM +0100, Lee Jones wrote:
> > This patch fixes a bug introduced in the v3.10 merge window.
> > 
> > Some platforms will not want external registers. Rather than setting up
> > lots of different clauses in the core ab8500 regulator driver not to
> > call ab8500-ext init() we just won't pass the initialisation data from
> > platform code. This patch checks for it and if it's missing, we won't
> > register the external regulators.
> 
> This seems problematic - if the regulators are unused then they
> shouldn't have anything enabled in the constraints

Right, that's what this does.

"we just won't pass the initialisation data from platform code."

'initialisation data' == 'constraints'.

> and the regulator
> driver ought to be read only in which case it doesn't matter if it's
> running or not, the worst that should happen is that the state can be
> read back.  I'd therefore expect the fix here to be in the board side
> code that enables the regulators.

It's both.

>From the platform side we have stopped passing the external regulator
driver's constraints for Snowball:

https://lkml.org/lkml/2013/5/22/280

All I've done here is stop the ext driver from crapping out with the
misleading error "Configuration error: size mismatch", because a)
it's not an error, it's expected and b) It's not a size mismatch,
instead we have chosen to keep the constraints back in the Snowball
(and u8505) case.

Strictly speaking 'this' part of the fix is not an -rc candidate, but
without it someone could waste a great deal of time finding out why
this 'error' has appeared when it's not actually an error at all. Thus,
it would be more than helpful if it made it into the -rcs along with
the real platform fix.

-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
