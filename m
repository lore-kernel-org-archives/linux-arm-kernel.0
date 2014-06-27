From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Fri, 27 Jun 2014 11:24:59 +0300
Subject: [RFC 04/10] memory: Add Tegra124 memory controller support
In-Reply-To: <20140627081659.GA10794@ulmo>
References: <1403815790-8548-1-git-send-email-thierry.reding@gmail.com>
 <1403815790-8548-5-git-send-email-thierry.reding@gmail.com>
 <53AD2020.1050802@nvidia.com> <20140627081659.GA10794@ulmo>
Message-ID: <87mwcy4v50.fsf@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Thierry Reding <thierry.reding@gmail.com> writes:

> * PGP Signed by an unknown key
>
> On Fri, Jun 27, 2014 at 03:41:20PM +0800, Joseph Lo wrote:
>> Hi Thierry,
>> 
>> On 06/27/2014 04:49 AM, Thierry Reding wrote:
>> [snip]
>> >+
>> >+#define MC_INTSTATUS 0x000
>> >+#define  MC_INT_DECERR_MTS (1 << 16)
>> >+#define  MC_INT_SECERR_SEC (1 << 13)
>> >+#define  MC_INT_DECERR_VPR (1 << 12)
>> >+#define  MC_INT_INVALID_APB_ASID_UPDATE (1 << 11)
>> >+#define  MC_INT_INVALID_SMMU_PAGE (1 << 10)
>> >+#define  MC_INT_ARBITRATION_EMEM (1 << 9)
>> >+#define  MC_INT_SECURITY_VIOLATION (1 << 8)
>> >+#define  MC_INT_DECERR_EMEM (1 << 6)
>> >+#define MC_INTMASK 0x004
>> >+#define MC_ERR_STATUS 0x08
>> >+#define MC_ERR_ADR 0x0c
>> >+
>> [snip]
>> >+
>> >+#define SMMU_PDE_ATTR          (SMMU_PDE_READABLE | SMMU_PDE_WRITABLE | \
>> >+                                SMMU_PDE_NONSECURE)
>> >+#define SMMU_PTE_ATTR          (SMMU_PTE_READABLE | SMMU_PTE_WRITABLE | \
>> >+                                SMMU_PTE_NONSECURE)
>> >+
>> >+#define SMMU_PDE_VACANT(n)     (((n) << 10) | SMMU_PDE_ATTR)
>> >+#define SMMU_PTE_VACANT(n)     (((n) << 12) | SMMU_PTE_ATTR)

They should be set 0.

The above VACANT macros are legacy support for some special case that a
device wanted linear SMMU mapping where iova == phy. No need any more.

>> There is an ISR to catch the invalid SMMU translation. Do you want to modify
>> the identity mapping with read/write attribute of the unused SMMU pages?
>
> I'm not sure I understand what you mean by "identity mapping". None of
> the public documentation seems to describe the exact layout of PDEs or
> PTEs, so it's somewhat hard to tell what to set them to when pages are
> unmapped.
>
>> This can make sure we capture the invalid SMMU translation. And helps for
>> driver to capture issues when using SMMU.
>
> That certainly sounds like a useful thing to have. Like I said this is
> an RFC and I'm not even sure if it's acceptable in the current form, so
> I wanted to get feedback early on to avoid wasting effort on something
> that turn out to be a wild-goose chase.
>
> Thierry
>
> * Unknown Key
> * 0x7F3EB3A1
