From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sat, 19 May 2018 12:54:41 +0100
Subject: [PATCH v8 10/15] cpufreq: Add Kryo CPU scaling driver
In-Reply-To: <018701d3ef61$dfd5e700$9f81b500$@codeaurora.org>
References: <1526555955-29960-1-git-send-email-ilialin@codeaurora.org>
 <1526555955-29960-11-git-send-email-ilialin@codeaurora.org>
 <20180518014538.duphof6enscpm5vp@vireshk-i7>
 <018701d3ef61$dfd5e700$9f81b500$@codeaurora.org>
Message-ID: <20180519115441.GK17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 19, 2018 at 02:09:24PM +0300, ilialin at codeaurora.org wrote:
> +static int __init qcom_cpufreq_kryo_driver_init(void)
> +{
> +       struct device *cpu_dev_silver, *cpu_dev_gold;
> +       struct opp_table *opp_silver, *opp_gold;
> +       enum _msm8996_version msm8996_version;
> +       struct nvmem_cell *speedbin_nvmem;
> +       struct platform_device *pdev;
> +       struct device_node *np;
> +       u8 *speedbin;
> +       u32 versions;
> +       size_t len;
> +       int ret;
> +
> +       cpu_dev_silver = get_cpu_device(SILVER_LEAD);
> +       if (IS_ERR_OR_NULL(cpu_dev_silver))
> +               return PTR_ERR(cpu_dev_silver);
> +
> +       cpu_dev_gold = get_cpu_device(SILVER_LEAD);
> +       if (IS_ERR_OR_NULL(cpu_dev_gold))
> +               return PTR_ERR(cpu_dev_gold);
> +
> +       msm8996_version = qcom_cpufreq_kryo_get_msm_id();
> +       if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> +               dev_err(cpu_dev_silver, "Not Snapdragon 820/821!");
> +               return -ENODEV;
> +       }
> +
> +       np = dev_pm_opp_of_get_opp_desc_node(cpu_dev_silver);
> +       if (IS_ERR_OR_NULL(np))
> +               return PTR_ERR(np);

This function (qcom_cpufreq_kryo_driver_init) returns zero on success.
You are checking "np" here for being an error pointer, or NULL.
What value do you think PTR_ERR() returns in the case of PTR_ERR(NULL)?

IS_ERR_OR_NULL() is considered by some (me included) as being _very_
harmful because programmers generally fail to look at linux/err.h and
consider what it means when used as above.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
