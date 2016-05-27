From: peter.griffin@linaro.org (Peter Griffin)
Date: Fri, 27 May 2016 17:13:29 +0100
Subject: [PATCH v4 01/18] remoteproc: st_xp70_rproc: add a xp70 slimcore
 rproc driver
In-Reply-To: <57484867.6030608@st.com>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-3-git-send-email-peter.griffin@linaro.org>
 <57484867.6030608@st.com>
Message-ID: <20160527161329.GA29319@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Patrice,

On Fri, 27 May 2016, Patrice Chotard wrote:
<snip>

> >+struct rproc *xp70_rproc_alloc(struct platform_device *pdev, char *fw_name);
> >+void xp70_rproc_put(struct st_xp70_rproc *xp70_rproc);
> >+
> >+#endif
> 
> Hi Peter
> 
> Applying this series on top of v4.6 kernel leads to the following
> compilation error due to patch 01/18 :
> 
> drivers/remoteproc/st_xp70_rproc.c: In function 'xp70_rproc_alloc':
> drivers/remoteproc/st_xp70_rproc.c:291:2: error: implicit
> declaration of function 'rproc_get_elf_ops'
> [-Werror=implicit-function-declaration]
>   elf_ops = rproc_get_elf_ops();
>   ^
>   LD [M]  drivers/remoteproc/remoteproc.o

Whoops. Looks like I forgot to include the first patch of the series. Doh! I will
include it when I send v5.

The missing patch looks like this. Bjorn do you have any issues with adding this
interface?

regards,

Peter.



>From 4664bb628cb5c99a43976a0b74ae1ee6cb05a68e Mon Sep 17 00:00:00 2001
From: Peter Griffin <peter.griffin@linaro.org>
Date: Wed, 25 May 2016 09:54:02 +0100
Subject: [PATCH 01/19] remoteproc: add a rproc_get_elf_ops interface

This allows us to re-use some of the generic fw_ops such
as rproc_elf_sanity_check() and rproc_elf_load_segments() whilst
overriding some of the others with our own implementation.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/remoteproc/remoteproc_elf_loader.c | 6 ++++++
 include/linux/remoteproc.h                 | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/remoteproc/remoteproc_elf_loader.c b/drivers/remoteproc/remoteproc_elf_loader.c
index ce283a5..a3e06df 100644
--- a/drivers/remoteproc/remoteproc_elf_loader.c
+++ b/drivers/remoteproc/remoteproc_elf_loader.c
@@ -335,3 +335,9 @@ const struct rproc_fw_ops rproc_elf_fw_ops = {
 	.sanity_check = rproc_elf_sanity_check,
 	.get_boot_addr = rproc_elf_get_boot_addr
 };
+
+const struct rproc_fw_ops *rproc_get_elf_ops(void)
+{
+	return &rproc_elf_fw_ops;
+}
+EXPORT_SYMBOL_GPL(rproc_get_elf_ops);
diff --git a/include/linux/remoteproc.h b/include/linux/remoteproc.h
index 9c4e138..b0b06c8 100644
--- a/include/linux/remoteproc.h
+++ b/include/linux/remoteproc.h
@@ -495,6 +495,8 @@ int rproc_boot(struct rproc *rproc);
 void rproc_shutdown(struct rproc *rproc);
 void rproc_report_crash(struct rproc *rproc, enum rproc_crash_type type);
 
+const struct rproc_fw_ops *rproc_get_elf_ops(void);
+
 static inline struct rproc_vdev *vdev_to_rvdev(struct virtio_device *vdev)
 {
 	return container_of(vdev, struct rproc_vdev, vdev);
-- 
1.9.1
