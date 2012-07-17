From: joerg.roedel@amd.com (joerg.roedel at amd.com)
Date: Tue, 17 Jul 2012 15:23:00 +0200
Subject: [v3.6 3/3] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
In-Reply-To: <20120717.152524.175499431618552821.hdoyu@nvidia.com>
References: <1341228398-6878-1-git-send-email-hdoyu@nvidia.com>
 <1341228398-6878-3-git-send-email-hdoyu@nvidia.com>
 <20120717100901.GH4213@amd.com>
 <20120717.152524.175499431618552821.hdoyu@nvidia.com>
Message-ID: <20120717132300.GK4213@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 17, 2012 at 02:25:24PM +0200, Hiroshi Doyu wrote:
> The above spin_lock is always necessary. "as->lock" should be held to
> protect "as->pdir_page". Only when "as->pdir_page" is NULL,
> "as->pdir_page" would be allocated in "alloc_pdir()". Without this
> lock, the following race could happen:
> 
> 
> Without as->lock:
> A:			B:
> i == 3
> pdir_page == NULL
> 			i == 3
> 	     		pdir_page == NULL
> pdir_page = a;
> 			pdir_page = b;	!!!!!! OVERWRITTEN !!!!!!
>

Unless I am missing something, this is not the correct situation with my
patch. It would look more like this:


 A:					B:
 i == 3
 pdir_page == NULL
 					i == 3
 	     				pdir_page == NULL

 take as->lock

 /* race check */
 pdir_page == NULL -> proceed		/* spinning on as->lock */

 pdir_page = a;

 release as->lock

					 take as->lock

					 /* race check */
					 pdir_page != NULL -> return

This should be fine, no? Do I miss something?


	Joerg
