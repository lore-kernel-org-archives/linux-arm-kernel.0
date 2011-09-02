From: swarren@nvidia.com (Stephen Warren)
Date: Fri, 2 Sep 2011 09:04:42 -0700
Subject: [PATCH 2/4 v6] pinmux: add a driver for the U300 pinmux
In-Reply-To: <CACRpkdZ1kNbtOqw=X1mmM-bA+Gg2BbmO5_CT0sSQtBCK_WdwYw@mail.gmail.com>
References: <1314869552-5531-1-git-send-email-linus.walleij@stericsson.com>
	<74CDBE0F657A3D45AFBB94109FB122FF04B327A40C@HQMAIL01.nvidia.com>
	<CACRpkdZ1kNbtOqw=X1mmM-bA+Gg2BbmO5_CT0sSQtBCK_WdwYw@mail.gmail.com>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04B327A570@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote at Friday, September 02, 2011 2:12 AM:
> On Thu, Sep 1, 2011 at 11:33 PM, Stephen Warren <swarren@nvidia.com> wrote:
> 
> >> +static const struct u300_pmx_func u300_pmx_functions[] = {
> >> + ? ? {
> >> + ? ? ? ? ? ? .name = "power",
> >> + ? ? ? ? ? ? .groups = { POWERGRP_INDEX },
> >> + ? ? ? ? ? ? /* Mask is N/A */
> >> + ? ? },
> >
> > Hmmm. That's a lot of _INDEX defines that'd need to be set up, at least
> > to fully represent a chip like Tegra. Can the pinmux core be modified
> > such that the group list is an array of names (char*) rather than the
> > actual numeric IDs of the groups? Still, perhaps we could use the enum
> > we already have for this, so perhaps it isn't a big deal...
> 
> Well I could think about a lot of ways to do this, but it's basically up
> to the driver, the U300 is just some simple example of what you can
> do, it's just trying to satisfy the API.
> 
> Maybe as part of writing the nVidia driver you find a clever
> mechanism for doing this, if it's looking generally useful at that
> point then let's move it to the core I'd say.

The reason I asked about the pinmux core handling this is because the
driver op get_function_groups:

+	int (*get_function_groups) (struct pinctrl_dev *pctldev,
+				  unsigned selector,
+				  unsigned ** const groups,
+				  unsigned * const num_groups);

returns an array of integer indexes. I think the only way to get rid of
the index definitions in the drivers is to allow get_function_groups to
return an array of strings instead.

Well, I suppose the implementation of get_function_groups could convert
from an internal array of strings to the returned array of integers at
run-time, but that doesn't seem like a great idea.

-- 
nvpublic
