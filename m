From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 7 Apr 2017 13:28:26 -0400
Subject: [PATCH] scsi: mpt3sas: remove redundant wmb on arm/arm64
In-Reply-To: <1491585930.2325.11.camel@linux.vnet.ibm.com>
References: <1491583306-20551-1-git-send-email-okaya@codeaurora.org>
 <1491585930.2325.11.camel@linux.vnet.ibm.com>
Message-ID: <dc087ddb-020e-fe4a-832b-533bc2559e71@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/7/2017 1:25 PM, James Bottomley wrote:
>> The right thing was to either call __raw_writel/__raw_readl or
>> write_relaxed/read_relaxed for multi-arch compatibility.
> writeX_relaxed and thus your patch is definitely wrong.  The reason is
> that we have two ordering domains: the CPU and the Bus.  wmb forces
> ordering in the CPU domain but not the bus domain.  writeX originally
> forced ordering in the bus domain but not the CPU domain, but since the
> raw primitives I think it now orders in both and writeX_relaxed orders
> in neither domain, so your patch would currently eliminate the bus
> ordering.

Yeah, that's why I recommended to remove the wmb() with a follow up
instead of using the relaxed with a follow up.

writel already guarantees ordering for both cpu and bus. we don't need
additional wmb()

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
