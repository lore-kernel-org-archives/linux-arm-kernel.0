From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 00:46:53 +0000
Subject: [PATCH 2/6] iommu/arm-smmu: Introduce bus notifier block
In-Reply-To: <1382127195-15261-3-git-send-email-andreas.herrmann@calxeda.com>
References: <1382127195-15261-1-git-send-email-andreas.herrmann@calxeda.com>
 <1382127195-15261-3-git-send-email-andreas.herrmann@calxeda.com>
Message-ID: <20131031004653.GB28613@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 09:13:11PM +0100, Andreas Herrmann wrote:
> At the moment just handle BUS_NOTIFY_BIND_DRIVER to conditionally
> isolate all master devices for an SMMU.
> 
> Depending on DT information each device is put into its own protection
> domain (if possible).  For configuration with one or just a few
> masters per SMMU that is easy to achieve.
> 
> In case of many devices per SMMU (e.g. MMU-500 with it's distributed
> translation support) isolation of each device might not be possible --
> depending on number of available SMR groups and/or context banks.
> 
> Default is that device isolation is contolled per SMMU with SMMU node
> property "arm,smmu-isolate-devices" in a DT. If this property is set
> for an SMMU node, device isolation is performed.
> 
> W/o device isolation the driver detects SMMUs but no translation is
> configured (transactions just bypass translation process).
> 
> Note that for device isolation dma_base and size are fixed as 0 and
> SZ_128M at the moment.

I still think we need to solve the base/size issue before these can be
merged (the option parsing code in patch 1 looks fine).

Maybe we could it all on demand by registering a fault handler with an
empty IOMMU domain?

Will
