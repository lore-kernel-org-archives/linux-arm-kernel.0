From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Jan 2014 16:32:19 -0800
Subject: [PATCH RFC 04/10] base: power: Add generic OF-based power
 domain look-up
In-Reply-To: <52DD4DB1.2050200@samsung.com>
References: <1389469372-17199-1-git-send-email-tomasz.figa@gmail.com>
 <1389469372-17199-5-git-send-email-tomasz.figa@gmail.com>
 <87r48a8t99.fsf@linaro.org> <52DD4DB1.2050200@samsung.com>
Message-ID: <20140123003219.GG13785@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20, Tomasz Figa wrote:
> Hi Kevin,
> 
> On 14.01.2014 16:42, Kevin Hilman wrote:
> >Tomasz Figa <tomasz.figa@gmail.com> writes:
> >
> >>This patch introduces generic code to perform power domain look-up using
> >>device tree and automatically bind devices to their power domains.
> >>Generic device tree binding is introduced to specify power domains of
> >>devices in their device tree nodes.
> >>
> >>Backwards compatibility with legacy Samsung-specific power domain
> >>bindings is provided, but for now the new code is not compiled when
> >>CONFIG_ARCH_EXYNOS is selected to avoid collision with legacy code. This
> >>will change as soon as Exynos power domain code gets converted to use
> >>the generic framework in further patch.
> >>
> >>Signed-off-by: Tomasz Figa <tomasz.figa@gmail.com>
> >
> >I haven't read through this in detail yet, but wanted to make sure that
> >the DT representation can handle nested power domains.  At least
> >SH-mobile has a hierarchy of power domains and the genpd code can handle
> >that, so wanted to make sure that the DT representation can handle it as
> >well.
> 
> The representation of power domains themselves as implied by this
> patch is fully platform-specific. The only generic part is the
> #power-domain-cells property, which defines the number of cells
> needed to identify the power domain of given provider. You are free
> to have any platform-specific properties (or even generic ones,
> added on top of this patch) to let you specify the hierarchy in DT.
> 

(Semi-related to this thread, but not really the patchset)

I'd like to have a way to say that this power domain is a
subdomain of another domain provided by a different power domain
provider driver. From what I can tell, the only way to reparent
domains as of today is by name or reference and you have to make
a function call to do it (pm_genpd_add_subdomain_names() or
pm_genpd_add_subdomain()). This is annoying in the case where all
the power domains are not regsitered within the same driver
because we don't know which driver comes first.

It would be great if there was a way to specify this relationship
explicitly when initializing a power domain so that the
reparenting is done automatically without requiring any explicit
function call. Perhaps DT could specify this? Or we could add
another field to the generic_power_domain struct like parent_name?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
