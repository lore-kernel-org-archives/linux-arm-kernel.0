From: leo.yan@linaro.org (Leo Yan)
Date: Wed, 19 Apr 2017 23:07:53 +0800
Subject: [PATCH v6 6/8] coresight: add support for CPU debug module
In-Reply-To: <f42088f6-aa53-06b1-b332-22198744ab7a@arm.com>
References: <1491485461-22800-1-git-send-email-leo.yan@linaro.org>
 <1491485461-22800-7-git-send-email-leo.yan@linaro.org>
 <5c5cb6f8-1dcb-8a9d-1605-c006656005eb@arm.com>
 <20170419142812.GA16160@leoy-linaro>
 <f42088f6-aa53-06b1-b332-22198744ab7a@arm.com>
Message-ID: <20170419150753.GA23319@leoy-linaro>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 19, 2017 at 03:32:39PM +0100, Suzuki K Poulose wrote:

[...]

> >>>+static int debug_probe(struct amba_device *adev, const struct amba_id *id)
> >>>+{
> >>>+	void __iomem *base;
> >>>+	struct device *dev = &adev->dev;
> >>>+	struct debug_drvdata *drvdata;
> >>>+	struct resource *res = &adev->res;
> >>>+	struct device_node *np = adev->dev.of_node;
> >>>+	int ret;
> >>>+
> >>>+	drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >>>+	if (!drvdata)
> >>>+		return -ENOMEM;
> >>>+
> >>>+	drvdata->cpu = np ? of_coresight_get_cpu(np) : 0;
> >>>+	if (per_cpu(debug_drvdata, drvdata->cpu)) {
> >>>+		dev_err(dev, "CPU%d drvdata has been initialized\n",
> >>>+			drvdata->cpu);
> >>
> >>May be we could warn about a possible issue in the DT ?
> >
> >So can I understand the suggestion is to add warning in function
> >of_coresight_get_cpu() when cannot find CPU number, and here directly
> >bail out?
> 
> No. One could have single CPU DT, where he doesn't need to provide the CPU number.
> Hence, it doesn't make sense to WARN  in of_coresight_get_cpu().
> 
> But when we hit the case above, we find that the some node was registered for
> the given CPU (be it 0 or any other), which is definitely an error in DT. Due to
> 
> 1) Hasn't specified the CPU number for more than one node
> 
> OR
> 
> 2) CPU number duplicated in the more than one nodes.

Thanks for explaination. It's clear for me now.

> Cheers
> Suzuki
