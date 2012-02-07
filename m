From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 7 Feb 2012 12:15:11 +0000
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
Message-ID: <20120207121511.GH3351@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 30, 2012 at 07:57:12AM +0000, bill4carson at gmail.com wrote:
> +/* 2M and 16M hugepage linux ptes are stored in an array
> + *
> + * 2M hugepage
> + * ===========
> + * one linux pte caters to two HW ptes,
> + * so the maximum huge linux pte needed is 4096M/2M = 2048 entry pointers.
> + * Two 4K page is used to store these entry pointers(2048 * 4 = 8192 bytes)
> + * in a two-dimension array, huge_2m_pte[2][1024].

Actually we only need to cover TASK_SIZE so for a 2:2 split you only
need half of the above.

> + *
> + * How to find the hugepage linux pte corresponding to a specific address ?
> + * VA[31] is used as row index;
> + * VA[30:21] is used as column  index;

I haven't fully reviewed the code but can we not drop this row/column
set up and just use a VA[31:21] as the index?

> + *
> + * 16M hugepage
> + * ============
> + * one linux pte caters for one HW pte,

Actually that's a bit misleading as we need 16 consecutive pmd entries
for a supersection. So one Linux pmd caters for 16 HW pmds.

> + * so maxium huge linux pte needed is 4096M/16M = 256 entry pointers,
> + * 256 * 4 = 1024 bytes spaces is allocated to store these linux pte;
> + * this is a simple one-dimension array huge_16m_pte[256].
> + *
> + * VA[31:24] is used to index this array;

Maybe we should call them Linux pmd rather than pte in the comments? It
is less confusing (I know that the generic hugetlb code calls them
ptes).

-- 
Catalin
