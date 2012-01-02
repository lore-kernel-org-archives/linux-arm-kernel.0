From: thomas.abraham@linaro.org (Thomas Abraham)
Date: Mon, 2 Jan 2012 07:44:09 +0530
Subject: [PATCH 2/2] ARM: Exynos: Hook up power domains to generic power
 domain infrastructure
In-Reply-To: <4EFB66C3.4040504@gmail.com>
References: <1323704789-23923-1-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-2-git-send-email-thomas.abraham@linaro.org>
 <1323704789-23923-3-git-send-email-thomas.abraham@linaro.org>
 <4EFB66C3.4040504@gmail.com>
Message-ID: <CAJuYYwQbTJTRdsa9WpQuCtSTYacbrcP3CVBFaAYHP1jLPky10A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sylwester,

On 29 December 2011 00:28, Sylwester Nawrocki <snjw23@gmail.com> wrote:
> Hi Thomas,
>
> On 12/12/2011 04:46 PM, Thomas Abraham wrote:
>> The generic power domain infrastructure is used to control the power domains
>> available on Exynos4. For non-dt platforms, the power domains are statically
>> instantiated. For dt platforms, the power domain nodes found in the device
>> tree are instantiated.
>>
>> Cc: Kukjin Kim <kgene.kim@samsung.com>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Signed-off-by: Thomas Abraham <thomas.abraham@linaro.org>
>> ---
>> This patch is mainly derived from Mark Brown's work on generic power domain
>> support for s3c64xx platforms. The existing exynos4 power domain implementation
>> is not removed in this patch. The devices are not yet registered with the power
>> domains for non-dt platforms.
>>
>> ?arch/arm/mach-exynos/Kconfig | ? ?1 +
>> ?arch/arm/mach-exynos/pm.c ? ?| ?179 ++++++++++++++++++++++++++++++++++++++++++
>> ?2 files changed, 180 insertions(+), 0 deletions(-)

[...]

> Sorry, I haven't reviewed your patch carefully enough. So for dt platforms
> pd->base is initialized from "reg" property, directly from each power domain's
> DT node. Only the static power domain instantiation for non-dt platforms would
> possibly need some code modifications when new SoCs are added.
>
> Would be nice to have a relevant patch for *.dts files in this series too. :)

The following is a snippet from the dts file used for testing.

   [...]

   lcd0:power-domain-lcd0 {
            compatible = "samsung,exynos4210-pd";
            reg = <0x10023C00 0x10>;
   };

   [...]

   fimd0:display-controller {
            compatible = "samsung,exynos4-fimd";
            [...]
            pd = <&lcd0>;
   };

The fimd (display controller) driver would then do the following.

parp = of_get_property(pdev->dev.of_node, "pd", NULL);
pd_np = of_find_node_by_phandle(be32_to_cpup(parp));
pm_genpd_of_add_device(pd_np, &pdev->dev);

The lookup is based on the node pointer of the power domain.

Thanks,
Thomas.
