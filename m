From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 05 Jun 2014 12:06:23 -0600
Subject: [PATCH v7 1/5] ARM: tegra: export apb dma readl/writel
In-Reply-To: <5390AF88.9050007@wwwdotorg.org>
References: <1401973754-19701-1-git-send-email-pdeschrijver@nvidia.com>
 <1401973754-19701-2-git-send-email-pdeschrijver@nvidia.com>
 <5390AF88.9050007@wwwdotorg.org>
Message-ID: <5390B19F.7090008@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/05/2014 11:57 AM, Stephen Warren wrote:
> On 06/05/2014 07:09 AM, Peter De Schrijver wrote:
>> Export APB DMA readl and writel. These are needed because we can't access
>> the fuses directly on Tegra20 without potentially causing a system hang.
>> Also have the APB DMA readl and writel return an error in case of a read
>> failure instead of just returning zero or ignore write failures.
> 
>> diff --git a/include/linux/tegra-soc.h b/include/linux/tegra-soc.h
> 
>> +int tegra_apb_readl_using_dma(unsigned long offset, u32 *value);
>> +int tegra_apb_writel_using_dma(u32 value, unsigned long offset);
> 
> Hmm. I wonder why we're exporting those low-level internal functions
> rather than the higher-level tegra_apb_readl()/writel() wrappers that
> "clients" are supposed to be using.

Oh, I suppose this is just for rivers/misc/fuse/tegra/fuse-tegra20.c to
use it, not for arbitrary clients, so this is probably OK.

Any reason not to move all the DMA-related fuse-reading code into
fuse-tegra20.c instead? After this series, is there code left in
arch/arm/mach-tegra which will still need to call into the fuse-reading
code and hence requires tegra_apb_readl_using_dma() to exist?
