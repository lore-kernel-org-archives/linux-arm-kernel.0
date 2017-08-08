From: Suzuki.Poulose@arm.com (Suzuki K Poulose)
Date: Tue, 8 Aug 2017 10:41:35 +0100
Subject: [PATCH v4 3/6] coresight: of: Use of_cpu_node_to_id helper
In-Reply-To: <201708081748.bujrMOmJ%fengguang.wu@intel.com>
References: <201708081748.bujrMOmJ%fengguang.wu@intel.com>
Message-ID: <5460b978-e624-6b38-fe3d-6427eed3ebd7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/08/17 10:18, kbuild test robot wrote:
> Hi Suzuki,
>
> [auto build test ERROR on linus/master]
> [also build test ERROR on v4.13-rc4 next-20170807]
> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
>
> url:    https://github.com/0day-ci/linux/commits/Suzuki-K-Poulose/perf-Support-for-ARM-DynamIQ-Shared-Unit-PMU/20170808-124822
> config: arm-allmodconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (Debian 6.1.1-9) 6.1.1 20160705
> reproduce:
>         wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         make.cross ARCH=arm
>
> Note: the linux-review/Suzuki-K-Poulose/perf-Support-for-ARM-DynamIQ-Shared-Unit-PMU/20170808-124822 HEAD 5757d34d451ed5a1452526b27b0f36664a8f2007 builds fine.
>       It only hurts bisectibility.
>
> All errors (new ones prefixed by >>):
>
>    drivers//hwtracing/coresight/of_coresight.c: In function 'of_coresight_get_cpu':
>>> drivers//hwtracing/coresight/of_coresight.c:117:19: error: expected ';' before numeric constant
>      return (cpu < 0) 0 : cpu;
>                       ^
>
> vim +117 drivers//hwtracing/coresight/of_coresight.c
>
>    103	
>    104	int of_coresight_get_cpu(const struct device_node *node)
>    105	{
>    106		int cpu;
>    107		struct device_node *dn;
>    108	
>    109		dn = of_parse_phandle(node, "cpu", 0);
>    110		/* Affinity defaults to CPU0 */
>    111		if (!dn)
>    112			return 0;
>    113		cpu = of_cpu_node_to_id(dn);
>    114		of_node_put(dn);
>    115	
>    116		/* Affinity to CPU0 if no cpu nodes are found */
>  > 117		return (cpu < 0) 0 : cpu;
>    118	}
>    119	EXPORT_SYMBOL_GPL(of_coresight_get_cpu);
>    120	
>

Thanks for the bug report, I will respin the series with a fix for this.

Suzuki
