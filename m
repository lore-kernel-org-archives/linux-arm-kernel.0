From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 27 Aug 2014 07:58:30 +0200
Subject: [PATCH v3 1/5] of: Add NVIDIA Tegra Legacy Interrupt Controller
 binding
In-Reply-To: <53FCCAF1.9050504@wwwdotorg.org>
References: <1409035264-16999-1-git-send-email-thierry.reding@gmail.com>
 <53FCCAF1.9050504@wwwdotorg.org>
Message-ID: <20140827055829.GD15640@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 26, 2014 at 11:59:13AM -0600, Stephen Warren wrote:
> On 08/26/2014 12:41 AM, Thierry Reding wrote:
> >From: Thierry Reding <treding@nvidia.com>
> >
> >The Legacy Interrupt Controller found on NVIDIA Tegra SoCs is used by
> >the AVP coprocessor and can also serve as a backup for the ARM Cortex
> >CPU's local interrupt controller (GIC).
> >
> >The LIC is subdivided into multiple identical units, each handling 32
> >possible interrupt sources.
> 
> If I apply this series without patch 2, which is necessary to test the
> support for compatibility with old DTs, then I get the following very early
> on in boot:
> 
> Other than that, I would apply this.

Ugh... this is because before patch 3 the code would always initialize
all five controllers, even on Tegra20 where it doesn't exist. Patch 3
adds a check for that based on the chip ID, which due to other patches
merged for v3.17 isn't available at this point. One solution would be
for this to be moved into an initcall to make sure it's called after
initialization of the fuse driver so that tegra_get_chip_id() can read
the chip ID. But since you're not at all a fan of that I guess the best
we can do is to match on the top-level machine compatible instead of
using the chip ID.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140827/82920ae3/attachment.sig>
