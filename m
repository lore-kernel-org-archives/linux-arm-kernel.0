From: broonie@kernel.org (Mark Brown)
Date: Wed, 22 May 2013 10:53:47 -0500
Subject: [PATCH] regulator: ab8500-ext: Don't register without
 initialisation data
In-Reply-To: <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
References: <1369226853-16978-1-git-send-email-lee.jones@linaro.org>
 <1369226853-16978-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20130522155347.GJ1627@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 22, 2013 at 01:47:33PM +0100, Lee Jones wrote:
> This patch fixes a bug introduced in the v3.10 merge window.
> 
> Some platforms will not want external registers. Rather than setting up
> lots of different clauses in the core ab8500 regulator driver not to
> call ab8500-ext init() we just won't pass the initialisation data from
> platform code. This patch checks for it and if it's missing, we won't
> register the external regulators.

This seems problematic - if the regulators are unused then they
shouldn't have anything enabled in the constraints and the regulator
driver ought to be read only in which case it doesn't matter if it's
running or not, the worst that should happen is that the state can be
read back.  I'd therefore expect the fix here to be in the board side
code that enables the regulators.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130522/9e4f7de8/attachment.sig>
