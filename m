From: lho@apm.com (Loc Ho)
Date: Wed, 6 May 2015 11:12:20 -0700
Subject: [PATCH v8 0/4] edac: Add APM X-Gene SoC memory controller EDAC
 driver
In-Reply-To: <2150970.xGYLhDU9BR@wuerfel>
References: <1430884947-16787-1-git-send-email-lho@apm.com>
 <2150970.xGYLhDU9BR@wuerfel>
Message-ID: <CAPw-ZTkuZWNM9D_wJRfQq009KeL1coyYKXhqhWV+FWW6C=xRiA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd/Borislav/Rob,

> > v8:
> > * Change ASM_EDAC_H to __ASM_EDAC_H in file edac.h
> > * Add WARN_ONCE in stub function atomic_scrub
> > * Update DTS binding documentation (with only memory controller node)
> > * Temporary remove L1/L2, L3, and SoC driver code and update memory driver
> >   code accordingly
> >
> >
>
> I don't see how this is helping. You still use a syscon reference for the
> pcp node after I told you not to, and you are completely leaving out the
> other nodes, which makes it impossible to tell what your plan is for those.
>
>
> Please come up with a plan that makes it possible to have proper support
> for all the devices in the future. Leaving out bits because you know that
> adding them later will be hard is not a good solution: if you screw up
> the design now, adding them later will be even harder.


Okay... Let me summary the issue at hand and let us all agree:

1. Whether to have an single driver for APM EDAC or multiple instance
of 4 different drivers. With single driver, it does not scale in the
future when we add/remove memory controllers and CPU domains. This is
also agreed by Rob Herring from review of the DTS nodes. For L3 and
SoC EDAC, they are less of an issue as I don't see a situation that we
would have multiple instances.

2. With regard to the top level PCP interrupt, they are just for
status and once configured, it will not be touch. Therefore, I keep
the current implementation. With an single driver, there is no need to
worry about read/modify/write as it will be guarded with an lock. For
multiple instance, I am thinking that the xgene_edac_mc module will
provide exported lock functions for the other drivers.

If I am missing anything, let me know.

-Loc
