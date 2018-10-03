From: mhocko@kernel.org (Michal Hocko)
Date: Wed, 3 Oct 2018 15:36:09 +0200
Subject: [PATCH 1/4] mm/hugetlb: Enable PUD level huge page migration
In-Reply-To: <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
References: <1538482531-26883-1-git-send-email-anshuman.khandual@arm.com>
 <1538482531-26883-2-git-send-email-anshuman.khandual@arm.com>
 <20181002123909.GS18290@dhcp22.suse.cz>
 <fae68a4e-b14b-8342-940c-ea5ef3c978af@arm.com>
 <20181003065833.GD18290@dhcp22.suse.cz>
 <7f0488b5-053f-0954-9b95-8c0890ef5597@arm.com>
 <20181003105926.GA4714@dhcp22.suse.cz>
 <34b25855-fcef-61ed-312d-2011f80bdec4@arm.com>
 <20181003114842.GD4714@dhcp22.suse.cz>
 <d42cc88b-6bab-797c-f263-2dce650ea3ab@arm.com>
Message-ID: <20181003133609.GG4714@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 03-10-18 18:36:39, Anshuman Khandual wrote:
[...]
> So we have two checks here
> 
> 1) platform specific arch_hugetlb_migration -> In principle go ahead
> 
> 2) huge_movable() during allocation
> 
> 	- If huge page does not have to be placed on movable zone
> 
> 		- Allocate any where successfully and done !
>  
> 	- If huge page *should* be placed on a movable zone
> 
> 		- Try allocating on movable zone
> 
> 			- Successfull and done !
> 
> 		- If the new page could not be allocated on movable zone
> 		
> 			- Abort the migration completely
> 
> 					OR
> 
> 			- Warn and fall back to non-movable

I guess you are still making it more complicated than necessary. The
later is really only about __GFP_MOVABLE at this stage. I would just
make it simple for now. We do not have to implement any dynamic
heuristic right now. All that I am asking for is to split the migrate
possible part from movable part.

I should have been more clear about that I guess from my very first
reply. I do like how you moved the current coarse grained
hugepage_migration_supported to be more arch specific but I merely
wanted to point out that we need to do some other changes before we can
go that route and that thing is to distinguish movable from migration
supported.

See my point?
-- 
Michal Hocko
SUSE Labs
