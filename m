From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 01 Oct 2014 10:27:27 +0200
Subject: [PATCH v4 2/2] iommu/arm-smmu: add support for iova_to_phys
 through ATS1PR
In-Reply-To: <1412126893-15796-3-git-send-email-mitchelh@codeaurora.org>
References: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
 <1412126893-15796-3-git-send-email-mitchelh@codeaurora.org>
Message-ID: <61772524.IxG1939KJq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 30 September 2014 18:28:13 Mitchel Humpherys wrote:
> +       if (readl_poll_timeout_atomic(cb_base + ARM_SMMU_CB_ATSR, tmp,
> +                               !(tmp & ATSR_ACTIVE), 50, 100)) {
> 

This looks really bad.

You are doing up to 50 100us delays, each of which can be much longer,
so you can do up to 10ms total delay with interrupts disabled.

Don't do that.

	Arnd
