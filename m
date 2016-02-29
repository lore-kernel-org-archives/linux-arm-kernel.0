From: rric@kernel.org (Robert Richter)
Date: Mon, 29 Feb 2016 20:45:22 +0100
Subject: [PATCH v12 3/5] dt, numa: Add NUMA dt binding implementation.
In-Reply-To: <56D48A5C.6040709@caviumnetworks.com>
References: <1456192703-2274-1-git-send-email-ddaney.cavm@gmail.com>
 <1456192703-2274-4-git-send-email-ddaney.cavm@gmail.com>
 <20160229172956.GF31343@rric.localdomain>
 <56D48A5C.6040709@caviumnetworks.com>
Message-ID: <20160229194522.GH31343@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 29.02.16 10:13:48, David Daney wrote:
> On 02/29/2016 09:29 AM, Robert Richter wrote:
> >On 22.02.16 17:58:21, David Daney wrote:
> >>From: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >>
> >>ADD device tree node parsing for NUMA topology using device
> >>"numa-node-id" property distance-map.
> >>
> >>Reviewed-by: Robert Richter <rrichter@cavium.com>
> >>Signed-off-by: Ganapatrao Kulkarni <gkulkarni@caviumnetworks.com>
> >>Signed-off-by: David Daney <david.daney@cavium.com>
> >>---
> >>  drivers/of/Kconfig   |   3 +
> >>  drivers/of/Makefile  |   1 +
> >>  drivers/of/of_numa.c | 211 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >>  include/linux/of.h   |   9 +++
> >>  4 files changed, 224 insertions(+)
> >>  create mode 100644 drivers/of/of_numa.c
> >>
> >>diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> >>index e2a4841..b3bec3a 100644
> >>--- a/drivers/of/Kconfig
> >>+++ b/drivers/of/Kconfig
> >>@@ -112,4 +112,7 @@ config OF_OVERLAY
> >>  	  While this option is selected automatically when needed, you can
> >>  	  enable it manually to improve device tree unit test coverage.
> >>
> >>+config OF_NUMA
> >
> >In arch/arm64/Kconfig you now need to:
> >
> >	select OF_NUMA if NUMA && OF
> >
> >This should depend here on OF and NUMA and enabled in that case. Why
> >moving that to arch code?
> 
> The dependency on of_numa.o is in the architecture specific code, so that is
> where the Kconfig select should be too.

If you grep for select in Kconfig files you will see that dependency
checkers in the form of select ... if ... are very rare. Since select
does not check for depends-on at all, defbool y is commonly used to
enable a config in case all dependencies match. If OF_NUMA only
supports ARM64, why not state this there? It is common to enable
certain configs in drivers/ only for a some archs.

> For new code, we try to avoid putting architecture specific things into the
> core Kconfig files.

But to avoid arch configs in generic Kconfigs, define HAVE_OF_NUMA,
add it as dependency to OF_NUMA and select it in arch/arm64/Kconfig.
OF_NUMA is then enabled with defbool y if all requirements are met.

This also addresses your concerns below.

-Robert

> Since arm64 is the only architecture that is currently using this, we don't
> want to select it for non-arm64 kernels that happen to select NUMA && OF.
> 
> I will restore the depends, as it is guard against errors in the
> architecture specific Kconfig select statements, but I am going to leave the
> NUMA && OF in the arm64/Kconfig for clarity.
> 
> >This duplicates code as the same needs to be
> >implemented for every arch.
> >
> 
> Better to duplicate a single Kconfig select statement a few times in
> architecture specific Kconfig files, than force people to continuously
> modify the depends in  drivers/of/Kconfig
