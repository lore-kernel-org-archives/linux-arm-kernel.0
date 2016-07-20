From: joro@8bytes.org (Joerg Roedel)
Date: Wed, 20 Jul 2016 16:01:27 +0200
Subject: [RFC PATCH] iommu: create direct_mapping after device attached
In-Reply-To: <1469018961-16367-1-git-send-email-honghui.zhang@mediatek.com>
References: <1469018961-16367-1-git-send-email-honghui.zhang@mediatek.com>
Message-ID: <20160720140127.GA3030@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 20, 2016 at 08:49:21PM +0800, honghui.zhang at mediatek.com wrote:
> From: Honghui Zhang <honghui.zhang@mediatek.com>
> 
> For mtk iommu, the domain_finalize was called in device attatch, the mtk
> iommu iopgt ops was allocated and initialized in domain_finalize, the
> iommu_group_create_direct_mappings would call the map interface to
> implement the map. If it's earlier than device attach, there would be NULL
> dereference. Move the iommu_group_create_direct_mappings call after device
> attached.

No, this would open a race window where the device is attached, but
doesn't have its unity-mappings in place. You should re-organize the mtk
driver instead, so that it works in this order too.



	Joerg
