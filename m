From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 22 Jan 2018 07:55:39 -0600
Subject: [PATCH 3/3] pinctrl: qcom: Don't allow protected pins to be
 requested
In-Reply-To: <20180110015848.11480-4-sboyd@codeaurora.org>
References: <20180110015848.11480-1-sboyd@codeaurora.org>
 <20180110015848.11480-4-sboyd@codeaurora.org>
Message-ID: <f384a6c4-57a5-df18-862c-bf7dad9ea3f4@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/9/18 7:58 PM, Stephen Boyd wrote:
> +		ret = device_property_read_u16_array(pctrl->dev, "gpios", tmp,
> +						     len);
> +		if (ret < 0) {
> +			dev_err(pctrl->dev, "could not read list of GPIOs\n");
> +			kfree(tmp);
> +			return ret;
> +		}

Just FYI, I'm still going to have to parse "gpios" in my 
pinctrl-qdf2xxx.c driver, even though you're also parsing it here. 
That's because I need to make sure that the msm_pingroup array only 
contains "approve" addresses in its ctl_reg fields.

+	for (i = 0; i < avail_gpios; i++) {
+		unsigned int gpio = gpios[i];
+
+		groups[gpio].npins = 1;
+		snprintf(names[i], NAME_SIZE, "gpio%u", gpio);
+		pins[gpio].name = names[i];
+		groups[gpio].name = names[i];
+
+		groups[gpio].ctl_reg = 0x10000 * gpio;
  		       ^^^^

I do this because I need to make sure that "unapproved" physical 
addresses are never store anywhere in groups[].  That way, it's 
impossible for the driver to cause an XPU violation -- the worst that 
can happen is a null pointer dereference.

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
