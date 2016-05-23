From: carlo@caione.org (Carlo Caione)
Date: Mon, 23 May 2016 13:43:58 +0200
Subject: [PATCH v2 1/4] soc: Amlogic: Add secure monitor driver
In-Reply-To: <5742EBC4.3050704@gmail.com>
References: <1463583382-15614-1-git-send-email-carlo@caione.org>
 <1463583382-15614-2-git-send-email-carlo@caione.org>
 <5742EBC4.3050704@gmail.com>
Message-ID: <20160523114358.GC17269@mephisto>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/05/16 13:38, Matthias Brugger wrote:
> 

[...]
> >+#include <stdarg.h>
> >+#include <asm/cacheflush.h>
> >+#include <asm/compiler.h>
> >+#include <linux/arm-smccc.h>
> >+#include <linux/io.h>
> >+#include <linux/ioport.h>
> >+#include <linux/module.h>
> >+#include <linux/platform_device.h>
> >+#include <linux/of.h>
> >+#include <linux/smp.h>
> >+
> >+#include <linux/soc/meson/meson_sm.h>
> >+
> >+#define SM_MEM_SIZE	0x1000
> >+
> >+/*
> >+ * To read from / write to the secure monitor we use two bounce buffers. The
> >+ * physical addresses of the two buffers are obtained by querying the secure
> >+ * monitor itself.
> >+ */
> >+
> >+static u32 sm_phy_in_base;
> >+static u32 sm_phy_out_base;
> 
> You can put this two variable in meson_sm_probe, right?

Yeah, actually no need to be there.

> >+
> >+static void __iomem *sm_sharemem_in_base;
> >+static void __iomem *sm_sharemem_out_base;
> >+
> >+struct meson_sm_data {
> >+	u32 cmd;
> >+	u32 arg0;
> >+	u32 arg1;
> >+	u32 arg2;
> >+	u32 arg3;
> >+	u32 arg4;
> >+	u32 ret;
> >+};
> >+
> >+static void __meson_sm_call(void *info)
> >+{
> >+	struct meson_sm_data *data = info;
> >+	struct arm_smccc_res res;
> >+
> >+	arm_smccc_smc(data->cmd,
> >+		      data->arg0, data->arg1, data->arg2,
> >+		      data->arg3, data->arg4, 0, 0, &res);
> >+	data->ret = res.a0;
> >+}
> >+
> >+u32 meson_sm_call(u32 cmd, u32 arg0, u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> 
> Can the function be static or will it be called from another driver?

It _can_ be called from another driver. It depends on the SMC used, so
better making it available.

> 
> >+{
> >+	struct meson_sm_data data;
> >+
> >+	data.cmd = cmd;
> >+	data.arg0 = arg0;
> >+	data.arg1 = arg1;
> >+	data.arg2 = arg2;
> >+	data.arg3 = arg3;
> >+	data.arg4 = arg4;
> >+	data.ret = 0;
> >+
> >+	__meson_sm_call(&data);
> >+
> >+	return data.ret;
> >+}
> >+
> >+u32 meson_sm_call_read(void *buffer, u32 cmd, u32 arg0, u32 arg1,
> >+		       u32 arg2, u32 arg3, u32 arg4)
> >+{
> >+	u32 size;
> >+
> >+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
> >+
> >+	if (!size || size > SM_MEM_SIZE)
> >+		return -EINVAL;
> >+
> >+	memcpy(buffer, sm_sharemem_out_base, size);
> >+	return size;
> >+}
> 
> This function will be needed to be exported to be callable from modules.

Fix in v3.

> >+
> >+u32 meson_sm_call_write(void *buffer, unsigned int b_size, u32 cmd, u32 arg0,
> >+			u32 arg1, u32 arg2, u32 arg3, u32 arg4)
> >+{
> >+	u32 size;
> >+
> >+	if (b_size > SM_MEM_SIZE)
> >+		return -EINVAL;
> >+
> >+	memcpy(sm_sharemem_in_base, buffer, b_size);
> >+
> >+	size = meson_sm_call(cmd, arg0, arg1, arg2, arg3, arg4);
> >+
> >+	if (!size)
> >+		return -EINVAL;
> >+
> >+	return size;
> >+}
> >+
> 
> Same here.

Thanks.

Cheers,

-- 
Carlo Caione
