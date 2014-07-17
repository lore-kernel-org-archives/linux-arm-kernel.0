From: mperttunen@nvidia.com (Mikko Perttunen)
Date: Thu, 17 Jul 2014 14:35:15 +0300
Subject: [PATCH v4 1/8] of: Add NVIDIA Tegra SATA controller binding
In-Reply-To: <53C7A433.4070404@redhat.com>
References: <1405500863-19696-2-git-send-email-mperttunen@nvidia.com>
 <1405510814-31928-1-git-send-email-mperttunen@nvidia.com>
 <53C666E5.6030009@redhat.com> <20140716131306.GB23384@ulmo>
 <53C6908A.2050200@redhat.com> <20140716195136.GB5212@mithrandir>
 <53C77263.7050903@redhat.com> <20140717073956.GA18640@ulmo>
 <53C7A433.4070404@redhat.com>
Message-ID: <53C7B4F3.4060307@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/07/14 13:23, Hans de Goede wrote:
> On 07/17/2014 09:56 AM, Mikko Perttunen wrote:
>> Also: is there a reason to not use the devm_* variants? I note that the helper code has not been able to prevent any of the ahci_platform drivers from messing up by not calling ahci_platform_put_resources.
>
> The libahci_platform.c code / ahci_platform.c code is also used for
> devices going way back who may not yet be using the new clk framework,
> so where we need to use clk_get(dev, NULL); quoting from libahci_platform.c :
>
>          for (i = 0; i < AHCI_MAX_CLKS; i++) {
>                  /*
>                   * For now we must use clk_get(dev, NULL) for the first clock,
>                   * because some platforms (da850, spear13xx) are not yet
>                   * converted to use devicetree for clocks.  For new platforms
>                   * this is equivalent to of_clk_get(dev->of_node, 0).
>                   */
>                  if (i == 0)
>                          clk = clk_get(dev, NULL);
>                  else
>                          clk = of_clk_get(dev->of_node, i);
>
>                  if (IS_ERR(clk)) {
>                          rc = PTR_ERR(clk);
>                          if (rc == -EPROBE_DEFER)
>                                  goto err_out;
>                          break;
>                  }
>                  hpriv->clks[i] = clk;
>          }
>
> And there is no devm variant of that, nor is there one to get clocks by index.
> Note that we also need ahci_platform_put_resources for runtime pm support, so
> that one is going to stay around anyways and thus there is not that much value
> in fixing this.
>

Ah, and looks like devres is used to call put_resources anyway. My mistake.
