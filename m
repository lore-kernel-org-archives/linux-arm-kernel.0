From: jays.lee@samsung.com (Jungseok Lee)
Date: Fri, 02 May 2014 10:03:02 +0900
Subject: [PATCH] arm64: mm: Create gigabyte kernel logical mappings where
 possible
In-Reply-To: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
References: <1398857782-1525-1-git-send-email-steve.capper@linaro.org>
Message-ID: <000801cf65a2$44551e10$ccff5a30$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, April 30, 2014 8:36 PM, Steve Capper wrote:
> We have the capability to map 1GB level 1 blocks when using a 4K granule.
> 
> This patch adjusts the create_mapping logic s.t. when mapping physical memory on boot, we attempt to
> use a 1GB block if both the VA and PA start and end are 1GB aligned. This both reduces the levels of
> lookup required to resolve a kernel logical address, as well as reduces TLB pressure on cores that
> support 1GB TLB entries.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>
> ---
> Hello,
> This patch has been tested on the FastModel for 4K and 64K pages.
> Also, this has been tested with Jungseok's 4 level patch.
> 
> I put in the explicit check for PAGE_SHIFT, as I am anticipating a three level 64KB configuration at
> some point.
> 
> With two level 64K, a PUD is equivalent to a PMD which is equivalent to a PGD, and these are all level
> 2 descriptors.
> 
> Under three level 64K, a PUD would be equivalent to a PGD which would be a level 1 descriptor thus may
> not be a block.
> 
> Comments/critique/testers welcome.

Hi, Steve

I've tested on my platform, and it works well.

If SoC design follows "Principles of ARM Memory Maps",
PA should be supposed to be 1GB aligned. Thus, I think
this patch is effective against them.

Best Regards
Jungseok Lee
