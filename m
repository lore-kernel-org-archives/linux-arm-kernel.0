From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Tue, 30 Jul 2013 08:18:03 +0300
Subject: [PATCH v2 14/22] iommu/tegra: smmu: Register platform_device to
 IOMMU dynamically
In-Reply-To: <51F6AC41.30007@wwwdotorg.org>
References: <1373021097-32420-1-git-send-email-hdoyu@nvidia.com>
 <1373021097-32420-15-git-send-email-hdoyu@nvidia.com>
 <51E84D51.2030404@wwwdotorg.org>
 <20130729.142752.1020949402019811407.hdoyu@nvidia.com>
 <51F6AC41.30007@wwwdotorg.org>
Message-ID: <20130730081803.5bb0ed4665f1f6ecf5dab908@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 29 Jul 2013 19:54:09 +0200
Stephen Warren <swarren@wwwdotorg.org> wrote:
...
> >> Why hard-code this mapping? Can't devices be assigned to ASIDs based on
> >> a DT property? I assume there's nothing in the SMMU HW that requires
> >> specific ASIDs to be used?
> > 
> > Right. Where should those policy be passed, board DT files?
> 
> Is the HW module (== SW group?) to ASID mapping policy or is a
> particular mapping required by HW?

only policy.
But swgroup can have multiple HWs, they need to be set in the same swgroup.

> Can the ASID mapping just happen dynamically in SW rather than DT
> dictating a particular mapping?

No info about ASID in DT, at least, right now.
If a board DT file is the place to put policy, then it can be an option.
 
> I assume the mapping must be set up before any HW is used, and can't be
> modified later, so there's no much chance of deferring any policy
> decisions to user-space etc.?

I think that both cases are needed.

Some traditional devices(MMC) can be changed later as it may have rootfs on it.
For some smarter devices like host1x, it want to change ASID dynamically per request/context.
