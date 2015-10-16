From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 21:19:06 +0200
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <56212C3E.8010603@codeaurora.org>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
 <5294153.vxTnuIq2gr@wuerfel> <56212C3E.8010603@codeaurora.org>
Message-ID: <6622700.vqj78zoFs4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 16 October 2015 09:56:30 Stephen Boyd wrote:
> On 10/15/2015 02:05 PM, Arnd Bergmann wrote:
> >
> >  This also seemed like the right place
> > to add a bugfix that I had in my queue:
> >
> > commit 73ebb85444b0472d90bb70a1a9e6b5df3f92c14c
> > Author: Arnd Bergmann <arnd@arndb.de>
> > Date:   Tue Oct 13 17:05:39 2015 +0200
> >
> >     soc: qcom/smem: add HWSPINLOCK dependency
> >     
> >     This fixes a build error when smem is enabled without hwspinlock:
> >     
> >     drivers/built-in.o: In function `qcom_smem_alloc':
> >     rockchip-efuse.c:(.text+0x7a3e4): undefined reference to `__hwspin_lock_timeout'
> >     rockchip-efuse.c:(.text+0x7a568): undefined reference to `__hwspin_unlock'
> >     drivers/built-in.o: In function `qcom_smem_remove':
> >     rockchip-efuse.c:(.text+0x7a5cc): undefined reference to `hwspin_lock_free'
> >     drivers/built-in.o: In function `qcom_smem_probe':
> >     rockchip-efuse.c:(.text+0x7a960): undefined reference to `hwspin_lock_request_specific'
> >     rockchip-efuse.c:(.text+0x7a988): undefined reference to `of_hwspin_lock_get_id'
> >     drivers/built-in.o: In function `qcom_smem_get':
> >     rockchip-efuse.c:(.text+0x7aa24): undefined reference to `__hwspin_lock_timeout'
> >     rockchip-efuse.c:(.text+0x7aafc): undefined reference to `__hwspin_unlock'
> >     
> 
> Can you share your .config? It looks like there are stubs for these, so
> I'm lost how we got undefined references.
> 
http://pastebin.com/HtrC510p

The problem is CONFIG_HWSPINLOCK=m && CONFIG_QCOM_SMEM=y. Sorry for sending
an incomplete patch description, I had not noticed those wrapper functions.

My patch fixes the issue, but does not allow you to build QCOM_SMEM without
HWSPINLOCK. If we want that configuration to be valid, we need one of
the two changes below:

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index eec76141d9b9..cae0ffa19bca 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -22,7 +22,7 @@ config QCOM_PM
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
-	depends on HWSPINLOCK
+	depends on HWSPINLOCK && !HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
 	  The driver provides an interface to items in a heap shared among all
diff --git a/include/linux/hwspinlock.h b/include/linux/hwspinlock.h
index 859d673d98c8..cdfd9fd2ba11 100644
--- a/include/linux/hwspinlock.h
+++ b/include/linux/hwspinlock.h
@@ -59,7 +59,7 @@ struct hwspinlock_pdata {
 	int base_id;
 };
 
-#if defined(CONFIG_HWSPINLOCK) || defined(CONFIG_HWSPINLOCK_MODULE)
+#if IS_REACHABLE(CONFIG_HWSPINLOCK)
 
 int hwspin_lock_register(struct hwspinlock_device *bank, struct device *dev,
 		const struct hwspinlock_ops *ops, int base_id, int num_locks);



	Arnd
