From: will.deacon@arm.com (Will Deacon)
Date: Thu, 3 Jul 2014 17:02:45 +0100
Subject: [PATCH V7] arm: mm: Modify pte_write and pmd_write logic for LPAE
In-Reply-To: <1404402296-11173-1-git-send-email-steve.capper@linaro.org>
References: <1404389173-4246-1-git-send-email-steve.capper@linaro.org>
 <1404402296-11173-1-git-send-email-steve.capper@linaro.org>
Message-ID: <20140703160245.GE14305@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 03, 2014 at 04:44:56PM +0100, Steve Capper wrote:
> For LPAE, we have the following means for encoding writable or dirty
> ptes:
>                               L_PTE_DIRTY       L_PTE_RDONLY
>     !pte_dirty && !pte_write        0               1
>     !pte_dirty && pte_write         0               1
>     pte_dirty && !pte_write         1               1
>     pte_dirty && pte_write          1               0
> 
> So we can't distinguish between writeable clean ptes and read only
> ptes. This can cause problems with ptes being incorrectly flagged as
> read only when they are writeable but not dirty.
> 
> This patch renumbers L_PTE_RDONLY from AP[2] to a software bit #58,
> and adds additional logic to set AP[2] whenever the pte is read only
> or not dirty. That way we can distinguish between clean writeable ptes
> and read only ptes.
> 
> HugeTLB pages will use this new logic automatically.
> 
> We need to add some logic to Transparent HugePages to ensure that they
> correctly interpret the revised pgprot permissions (L_PTE_RDONLY has
> moved and no longer matches PMD_SECT_AP2). In the process of revising
> THP, the names of the PMD software bits have been prefixed with L_ to
> make them easier to distinguish from their hardware bit counterparts.
> 
> Signed-off-by: Steve Capper <steve.capper@linaro.org>

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Will
