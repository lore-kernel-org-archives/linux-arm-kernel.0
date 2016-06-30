From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 29 Jun 2016 22:57:45 -0700
Subject: [PATCH v3 2/2] remoteproc: qcom: Introduce WCNSS peripheral
 image loader
In-Reply-To: <5773F6CC.6000605@linaro.org>
References: <1467147506-753-1-git-send-email-bjorn.andersson@linaro.org>
 <1467147506-753-2-git-send-email-bjorn.andersson@linaro.org>
 <5773F6CC.6000605@linaro.org>
Message-ID: <20160630055745.GI1190@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 29 Jun 09:26 PDT 2016, Srinivas Kandagatla wrote:

> Hi Bjorn,
> 
> Few comments below,
> 

Thanks!

> On 28/06/16 21:58, Bjorn Andersson wrote:
[..]
> 
> checkpatch reports:
> total: 0 errors, 16 warnings, 853 lines checked
> 

Yeah, there's 16 cases left where I think it's worth going a few chars
over 80 to keep the code readable...

> 
> >
> >diff --git a/drivers/remoteproc/Kconfig b/drivers/remoteproc/Kconfig
> >index 7c9fa6906f94..898820350cb6 100644
> >--- a/drivers/remoteproc/Kconfig
> >+++ b/drivers/remoteproc/Kconfig
> >@@ -90,6 +90,16 @@ config QCOM_Q6V5_PIL
> >  	  Say y here to support the Qualcomm Peripherial Image Loader for the
> >  	  Hexagon V5 based remote processors.
> >
> >+config QCOM_WCNSS_PIL
> >+	tristate "Qualcomm WCNSS Peripheral Image Loader"
> 
> Some of the symbols needs exporting,
> If you build these as modules, you would end up with below errors.
> 
> 
> ERROR: "qcom_wcnss_assign_iris" [drivers/remoteproc/qcom_wcnss_iris.ko]
> undefined!
> ERROR: "qcom_iris_disable" [drivers/remoteproc/qcom_wcnss.ko] undefined!
> ERROR: "qcom_iris_enable" [drivers/remoteproc/qcom_wcnss.ko] undefined!
> /workspace/linaro/dev/scripts/Makefile.modpost:91: recipe for target
> '__modpost' failed
> make[2]: *** [__modpost] Error 1
> 

I was expecting qcom_wcnss.c and qcom_wcnss_iris.c to be compiled into
the same kernel module, so this should not be the case. I will have a
look.

> 
> 
> >+	depends on OF && ARCH_QCOM
> >+	select QCOM_MDT_LOADER
> >+	select QCOM_SCM
> >+	select REMOTEPROC
> >+	help
> >+	  Say y here to support the Peripherial Image Loader for the Qualcomm
> >+	  Wireless Connectivity Subsystem.
> 
> s/Peripherial/Peripheral
> 

Thanks

> >+
> >  config ST_REMOTEPROC
> >  	tristate "ST remoteproc support"
> >  	depends on ARCH_STI
> >diff --git a/drivers/remoteproc/Makefile b/drivers/remoteproc/Makefile
[..]
> >+obj-$(CONFIG_QCOM_WCNSS_PIL)		+= qcom_wcnss.o qcom_wcnss_iris.o
> 
> May be we should have two symbols here, one for wcnss and other for
> wcnss_iris.
> 

I should define these two such that they will be linked into the same
module; as there's no reason to have either one without the other.

Thanks for spotting this.

> >  obj-$(CONFIG_ST_REMOTEPROC)		+= st_remoteproc.o
> >diff --git a/drivers/remoteproc/qcom_wcnss.c b/drivers/remoteproc/qcom_wcnss.c
[.]
> >+static const struct rproc_ops wcnss_ops;
> Do you need this here?
> 

Not any more, thanks.

> >+
[..]
> >+static int wcnss_load(struct rproc *rproc, const struct firmware *fw)
> >+{
> >+	struct qcom_wcnss *wcnss = (struct qcom_wcnss *)rproc->priv;
> >+	phys_addr_t fw_addr;
> >+	size_t fw_size;
> >+	bool relocate;
> >+	int ret;
> >+
> >+	ret = qcom_scm_pas_init_image(WCNSS_PAS_ID, fw->data, fw->size);
> >+	if (ret) {
> >+		dev_err(&rproc->dev, "invalid firmware metadata\n");
> >+		return -EINVAL;
> Should we not return the the actual error code here?
> 

I see no harm in doing so, I'll update it.

> >+	}
> >+
> >+	ret = qcom_mdt_parse(fw, &fw_addr, &fw_size, &relocate);
> >+	if (ret) {
> >+		dev_err(&rproc->dev, "failed to parse mdt header\n");
> >+		return ret;
> >+	}
> >+
> >+	if (relocate) {
> >+		wcnss->mem_reloc = fw_addr;
> >+
> >+		ret = qcom_scm_pas_mem_setup(WCNSS_PAS_ID, wcnss->mem_phys, fw_size);
> >+		if (ret) {
> >+			dev_err(&rproc->dev, "unable to setup relocation\n");
> >+			return -EINVAL;
> 
> Same as above..

Dito

> >+		}
> >+	}
> >+
> >+	return qcom_mdt_load(rproc, fw, rproc->firmware);
> >+}
> >+
[..]
> >+static irqreturn_t wcnss_handover_interrupt(int irq, void *dev)
> >+{
> >+	/*
> >+	 * XXX: At this point we're supposed to release the resources that we
> XXX ???
> 

This comment describes a discrepancy from the way these things should be
handled and the way I interpret the caf code, as such I think the code
warrants the tag Wikipedia describes as:

  "XXX - warn other programmers of problematic or misguiding code"

See https://en.wikipedia.org/wiki/Comment_(computer_programming)

> >+	 * have been holding on behalf of the WCNSS. Unfortunately this
> >+	 * interrupt comes way before the other side seems to be done.
> >+	 *
> >+	 * So we're currently relying on the ready interrupt firing later then
> >+	 * this and we just disable the resources at the end of wcnss_start().
> >+	 */
> >+
> >+	return IRQ_HANDLED;
> >+}
> >+
> >+static irqreturn_t wcnss_stop_ack_interrupt(int irq, void *dev)
> >+{
> >+	struct qcom_wcnss *wcnss = dev;
> >+
> >+	complete(&wcnss->stop_done);
> Adding line before return on all the functions would make code more
> readable, Or atleast consistency across driver would be nice.

Ok

> >+	return IRQ_HANDLED;
> 
> >+}
> >+
> >+static int wcnss_init_regulators(struct qcom_wcnss *wcnss,
> >+				 const struct wcnss_vreg_info *info,
> >+				 int num_vregs)
> >+{
> >+	struct regulator_bulk_data *bulk;
> >+	int ret;
> >+	int i;
> >+
> >+	bulk = devm_kcalloc(wcnss->dev,
> >+			    num_vregs, sizeof(struct regulator_bulk_data),
> >+			    GFP_KERNEL);
> >+	if (!bulk)
> >+		return -ENOMEM;
> >+
> >+	for (i = 0; i < num_vregs; i++)
> >+		bulk[i].supply = info[i].name;
> >+
> >+	ret = devm_regulator_bulk_get(wcnss->dev, num_vregs, bulk);
> >+	if (ret)
> >+		return ret;
> >+
> >+	for (i = 0; i < num_vregs; i++) {
> >+		if (info[i].max_voltage)
> >+			regulator_set_voltage(bulk[i].consumer,
> >+					      info[i].min_voltage,
> >+					      info[i].max_voltage);
> 
> Error handling seems missing here.
> 

I just assumed that if it works it works, will look into this further
and make sure we're doing the right thing here.

> >+
> >+		if (info[i].load_uA)
> >+			regulator_set_load(bulk[i].consumer, info[i].load_uA);
> same..
> 
> >+	}
> >+
> >+	wcnss->vregs = bulk;
> >+	wcnss->num_vregs = num_vregs;
> >+
> >+	return 0;
> >+}
> >+
[..]
> >+
> >+static int wcnss_probe(struct platform_device *pdev)
> >+{
> >+	const struct wcnss_data *data;
> >+	struct qcom_wcnss *wcnss;
> >+	struct resource *res;
> >+	struct rproc *rproc;
> >+	void __iomem *mmio;
> >+	int ret;
> >+
> >+	data = of_device_get_match_data(&pdev->dev);
> >+
> >+	if (!qcom_scm_is_available())
> >+		return -EPROBE_DEFER;
> 
> I cant see this call implemented in mainline yet.
> 

No, I noticed that as well when compiling this before sending it out. So
I've poked Andy about that.

> >+
> >+	if (!qcom_scm_pas_supported(WCNSS_PAS_ID)) {
> >+		dev_err(&pdev->dev, "PAS is not available for WCNSS\n");
> >+		return -ENXIO;
> >+	}
> >+
> >+	rproc = rproc_alloc(&pdev->dev, pdev->name, &wcnss_ops,
> >+			    WCNSS_FIRMWARE_NAME, sizeof(*wcnss));
> >+	if (!rproc) {
> >+		dev_err(&pdev->dev, "unable to allocate remoteproc\n");
> >+		return -ENOMEM;
> >+	}
> >+
> >+	rproc->fw_ops = &wcnss_fw_ops;
> >+
> >+	wcnss = (struct qcom_wcnss *)rproc->priv;
> >+	wcnss->dev = &pdev->dev;
> >+	wcnss->rproc = rproc;
> >+	platform_set_drvdata(pdev, wcnss);
> >+
> >+	init_completion(&wcnss->start_done);
> >+	init_completion(&wcnss->stop_done);
> >+
> >+	mutex_init(&wcnss->iris_lock);
> >+
> >+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pmu");
> >+	mmio = devm_ioremap_resource(&pdev->dev, res);
> >+	if (!mmio) {
> >+		ret = -ENOMEM;
> >+		goto free_rproc;
> >+	};
> >+
> >+	ret = wcnss_alloc_memory_region(wcnss);
> >+	if (ret)
> >+		goto free_rproc;
> >+
> >+	wcnss->pmu_cfg = mmio + data->pmu_offset;
> >+	wcnss->spare_out = mmio + data->spare_offset;
> >+
> >+	ret = wcnss_init_regulators(wcnss, data->vregs, data->num_vregs);
> >+	if (ret)
> >+		goto free_rproc;
> >+
> >+	ret = wcnss_request_irq(wcnss, pdev, "wdog", false, wcnss_wdog_interrupt);
> >+	if (ret < 0)
> >+		goto free_rproc;
> >+	wcnss->wdog_irq = ret;
> >+
> >+	ret = wcnss_request_irq(wcnss, pdev, "fatal", false, wcnss_fatal_interrupt);
> >+	if (ret < 0)
> >+		goto free_rproc;
> >+	wcnss->fatal_irq = ret;
> >+
> >+	ret = wcnss_request_irq(wcnss, pdev, "ready", true, wcnss_ready_interrupt);
> >+	if (ret < 0)
> >+		goto free_rproc;
> >+	wcnss->ready_irq = ret;
> >+
> >+	ret = wcnss_request_irq(wcnss, pdev, "handover", true, wcnss_handover_interrupt);
> >+	if (ret < 0)
> >+		goto free_rproc;
> >+	wcnss->handover_irq = ret;
> >+
> >+	ret = wcnss_request_irq(wcnss, pdev, "stop-ack", true, wcnss_stop_ack_interrupt);
> Some of these lines are over 80 chars..
> 

I prefer to shoot a little bit over here to keep the code cleaner.

> >+	if (ret < 0)
> >+		goto free_rproc;
> 
> \n
> 

Ok

> >+	wcnss->stop_ack_irq = ret;
> >+
> >+	if (wcnss->stop_ack_irq) {
> >+		wcnss->state = qcom_smem_state_get(&pdev->dev, "stop",
> >+						   &wcnss->stop_bit);
> >+		if (IS_ERR(wcnss->state)) {
> >+			ret = PTR_ERR(wcnss->state);
> >+			goto free_rproc;
> >+		}
> >+	}
> >+
> >+	ret = rproc_add(rproc);
> >+	if (ret)
> >+		goto free_rproc;
> >+
> >+	return of_platform_populate(pdev->dev.of_node, NULL, NULL, &pdev->dev);
> >+
> >+free_rproc:
> >+	rproc_put(rproc);
> >+
> >+	return ret;
> >+}
> >+
[..]
> >diff --git a/drivers/remoteproc/qcom_wcnss.h b/drivers/remoteproc/qcom_wcnss.h
[..]
> >+
> >+int qcom_iris_enable(struct qcom_iris *iris);
> >+void qcom_iris_disable(struct qcom_iris *iris);
> >+
> >+void qcom_wcnss_assign_iris(struct qcom_wcnss *wcnss, struct qcom_iris *iris,
> >+			    bool use_48mhz_xo);
> 
> Dummy functions?
> 

No these functions are the api inbetween the wcnss and iris parts of the
driver, the latter for the iris to tie the two together upon
successfully acquiring its resources and the prior for enabling and
disabling these resources.

> >+
> >+#endif
> >diff --git a/drivers/remoteproc/qcom_wcnss_iris.c b/drivers/remoteproc/qcom_wcnss_iris.c
[..]
> >+#include <linux/qcom_scm.h>
> ??
> 

scm is a leftover from splitting the driver in two files, will drop.

[..]
> >+int qcom_iris_enable(struct qcom_iris *iris)
> >+{
> >+	int ret;
> >+
> >+	ret = regulator_bulk_enable(iris->num_vregs, iris->vregs);
> >+	if (ret)
> >+		return ret;
> >+
> >+	ret = clk_prepare_enable(iris->xo_clk);
> >+	if (ret) {
> >+		dev_err(iris->dev, "failed to enable xo clk\n");
> >+		goto disable_regulators;
> >+	}
> >+
> >+	return 0;
> >+
> >+disable_regulators:
> >+	regulator_bulk_disable(iris->num_vregs, iris->vregs);
> >+
> >+	return ret;
> >+}
> >+
> EXPORT the symbol??

No, it doesn't make sense for either part of this driver to be compiled
standalone, as such this function should not be called from an outside
kernel module.

> >+void qcom_iris_disable(struct qcom_iris *iris)
> >+{
> >+	clk_disable_unprepare(iris->xo_clk);
> >+	regulator_bulk_disable(iris->num_vregs, iris->vregs);
> >+}
> EXPORT the symbol??

Dito

> >+

Again, thanks for the review.

Regards,
Bjorn
