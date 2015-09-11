From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Sep 2015 13:40:45 +0100
Subject: master build: 1 failures 73 warnings (v4.2-11142-gb0a1ea5)
In-Reply-To: <20150911120150.GN12027@sirena.org.uk>
References: <E1ZaL9B-0006QE-Kh@optimist> <20150911120150.GN12027@sirena.org.uk>
Message-ID: <20150911124045.GA16833@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 11, 2015 at 01:01:51PM +0100, Mark Brown wrote:
> On Fri, Sep 11, 2015 at 11:01:35AM +0100, Build bot for Mark Brown wrote:
> 
> > 	arm64-allmodconfig
> > ../drivers/firmware/qcom_scm-32.c:196:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:221:2: error: implicit declaration of function 'secure_flush_area' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:239:2: error: implicit declaration of function 'outer_inv_range' [-Werror=implicit-function-declaration]
> > ../drivers/firmware/qcom_scm-32.c:331:4: error: expected string literal before '__asmeq'
> > ../drivers/firmware/qcom_scm-32.c:361:4: error: expected string literal before '__asmeq'
> 
> Today's mainline fails to build on arm64 due to the above, introduced by
> efaa6e266ba (firmware: qcom_scm-32: replace open-coded call to
> __cpuc_flush_dcache_area()) which introduces a call to
> secure_flush_area() which isn't defined on arm64.  This does not happen
> in -next as 626ffb400e1e781 (firmware: qcom: scm: Add function stubs for
> ARM64) which fixes this and IIRC other issues on arm64 - what is the
> plan for getting that change into mainline?

There's no way in hell that driver is going to build for arm64, so I'd
suggest something like the following until it's sorted out.

Will

--->8

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 99c69a3205c4..2f51e249829f 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -134,7 +134,7 @@ config ISCSI_IBFT
 
 config QCOM_SCM
 	bool
-	depends on ARM || ARM64
+	depends on ARM
 
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
