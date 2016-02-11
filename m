From: gerald.schaefer@de.ibm.com (Gerald Schaefer)
Date: Thu, 11 Feb 2016 19:22:23 +0100
Subject: [BUG] random kernel crashes after THP rework on s390 (maybe also on
 PowerPC and ARM)
Message-ID: <20160211192223.4b517057@thinkpad>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Sebastian Ott reported random kernel crashes beginning with v4.5-rc1 and
he also bisected this to commit 61f5d698 "mm: re-enable THP". Further
review of the THP rework patches, which cannot be bisected, revealed
commit fecffad "s390, thp: remove infrastructure for handling splitting PMDs"
(and also similar commits for other archs).

This commit removes the THP splitting bit and also the architecture
implementation of pmdp_splitting_flush(), which took care of the IPI for
fast_gup serialization. The commit message says

    pmdp_splitting_flush() is not needed too: on splitting PMD we will do
    pmdp_clear_flush() + set_pte_at().  pmdp_clear_flush() will do IPI as
    needed for fast_gup

The assumption that a TLB flush will also produce an IPI is wrong on s390,
and maybe also on other architectures, and I thought that this was actually
the main reason for having an arch-specific pmdp_splitting_flush().

At least PowerPC and ARM also had an individual implementation of
pmdp_splitting_flush() that used kick_all_cpus_sync() instead of a TLB
flush to send the IPI, and those were also removed. Putting the arch
maintainers and mailing lists on cc to verify.

On s390 this will break the IPI serialization against fast_gup, which
would certainly explain the random kernel crashes, please revert or fix
the pmdp_splitting_flush() removal.

Regards,
Gerald
