From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 23:05:27 +0200
Subject: [GIT PULL] qcom SoC changes for 4.4 *RESEND*
In-Reply-To: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
References: <1444860627-8258-1-git-send-email-agross@codeaurora.org>
Message-ID: <5294153.vxTnuIq2gr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 14 October 2015 17:10:27 Andy Gross wrote:
> Qualcomm ARM Based SoC Updates for 4.4
> 
> * Implement id_table driver matching in SMD
> * Avoid NULL pointer exception on remove of SMEM
> * Reorder SMEM/SMD configs
> * Make qcom_smem_get() return a pointer
> * Handle big endian CPUs correctly in SMEM
> * Represent SMD channel layout in structures
> * Use __iowrite32_copy() in SMD
> * Remove use of VLAIs in SMD
> * Handle big endian CPUs correctly in SMD/RPM
> * Handle big endian CPUs corretly in SMD
> * Reject sending SMD packets that are too large
> * Fix endianness issue in SCM __qcom_scm_is_call_available
> * Add missing prototype for qcom_scm_is_available()
> * Correct SMEM items for upper channels
> * Use architecture level to build SCM correctly
> * Delete unneeded of_node_put in SMD
> * Correct active/slep state flagging in SMD/RPM
> * Move RPM message ram out of SMEM DT node
> 

Pulled into next/drivers, but please try to make the changelogs more readable
in the future. No point listing each small patch here, instead say what you've
done overall and what the major things are. Right now, the merge commit
just duplicates the information like this:

commit 90bb7e0e4f1ad8714f39db232ef14c588297346d
Merge: 5462b10af11d d0bfd7c9b162
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Thu Oct 15 22:56:52 2015 +0200

    Merge tag 'qcom-soc-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm into next/drivers
    
    Pull "Qualcomm ARM Based SoC Updates for 4.4" from Andy Gross:
    
    * Implement id_table driver matching in SMD
    * Avoid NULL pointer exception on remove of SMEM
    * Reorder SMEM/SMD configs
    * Make qcom_smem_get() return a pointer
    * Handle big endian CPUs correctly in SMEM
    * Represent SMD channel layout in structures
    * Use __iowrite32_copy() in SMD
    * Remove use of VLAIs in SMD
    * Handle big endian CPUs correctly in SMD/RPM
    * Handle big endian CPUs corretly in SMD
    * Reject sending SMD packets that are too large
    * Fix endianness issue in SCM __qcom_scm_is_call_available
    * Add missing prototype for qcom_scm_is_available()
    * Correct SMEM items for upper channels
    * Use architecture level to build SCM correctly
    * Delete unneeded of_node_put in SMD
    * Correct active/slep state flagging in SMD/RPM
    * Move RPM message ram out of SMEM DT node
    
    * tag 'qcom-soc-for-4.4' of git://codeaurora.org/quic/kernel/agross-msm:
      soc: qcom: smem: Move RPM message ram out of smem DT node
      soc: qcom: smd-rpm: Correct the active vs sleep state flagging
      soc: qcom: smd: delete unneeded of_node_put
      firmware: qcom-scm: build for correct architecture level
      soc: qcom: smd: Correct SMEM items for upper channels
      qcom-scm: add missing prototype for qcom_scm_is_available()
      qcom-scm: fix endianess issue in __qcom_scm_is_call_available
      soc: qcom: smd: Reject send of too big packets
      soc: qcom: smd: Handle big endian CPUs
      soc: qcom: smd_rpm: Handle big endian CPUs
      soc: qcom: smd: Remove use of VLAIS
      soc: qcom: smd: Use __iowrite32_copy() instead of open-coding it
      soc: qcom: smd: Represent channel layout in structures
      soc: qcom: smem: Handle big endian CPUs
      soc: qcom: Make qcom_smem_get() return a pointer
      soc: qcom: Reorder SMEM/SMD configs
      soc: qcom: smem: Avoid NULL pointer exception on remove
      soc: qcom: smd: Implement id_table driver matching

which looks a bit silly. This also seemed like the right place
to add a bugfix that I had in my queue:

commit 73ebb85444b0472d90bb70a1a9e6b5df3f92c14c
Author: Arnd Bergmann <arnd@arndb.de>
Date:   Tue Oct 13 17:05:39 2015 +0200

    soc: qcom/smem: add HWSPINLOCK dependency
    
    This fixes a build error when smem is enabled without hwspinlock:
    
    drivers/built-in.o: In function `qcom_smem_alloc':
    rockchip-efuse.c:(.text+0x7a3e4): undefined reference to `__hwspin_lock_timeout'
    rockchip-efuse.c:(.text+0x7a568): undefined reference to `__hwspin_unlock'
    drivers/built-in.o: In function `qcom_smem_remove':
    rockchip-efuse.c:(.text+0x7a5cc): undefined reference to `hwspin_lock_free'
    drivers/built-in.o: In function `qcom_smem_probe':
    rockchip-efuse.c:(.text+0x7a960): undefined reference to `hwspin_lock_request_specific'
    rockchip-efuse.c:(.text+0x7a988): undefined reference to `of_hwspin_lock_get_id'
    drivers/built-in.o: In function `qcom_smem_get':
    rockchip-efuse.c:(.text+0x7aa24): undefined reference to `__hwspin_lock_timeout'
    rockchip-efuse.c:(.text+0x7aafc): undefined reference to `__hwspin_unlock'
    
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
index 3e4d2133c3d2..eec76141d9b9 100644
--- a/drivers/soc/qcom/Kconfig
+++ b/drivers/soc/qcom/Kconfig
@@ -22,6 +22,7 @@ config QCOM_PM
 config QCOM_SMEM
 	tristate "Qualcomm Shared Memory Manager (SMEM)"
 	depends on ARCH_QCOM
+	depends on HWSPINLOCK
 	help
 	  Say y here to enable support for the Qualcomm Shared Memory Manager.
 	  The driver provides an interface to items in a heap shared among all

and I applied that on top.

	Arnd
