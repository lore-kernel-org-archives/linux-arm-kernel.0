From: bill4carson@gmail.com (carson bill)
Date: Tue, 7 Feb 2012 20:57:22 +0800
Subject: [PATCH 1/7] Add various hugetlb arm high level hooks
In-Reply-To: <20120207121511.GH3351@arm.com>
References: <1327910238-18704-1-git-send-email-bill4carson@gmail.com>
 <1327910238-18704-2-git-send-email-bill4carson@gmail.com>
 <20120207121511.GH3351@arm.com>
Message-ID: <CAOMgcGL_NaHnmZKqm=YyKNOzcOAjoNyN3Cwv9fMddHfJWMxtZA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/7, Catalin Marinas <catalin.marinas@arm.com>:
> On Mon, Jan 30, 2012 at 07:57:12AM +0000, bill4carson at gmail.com wrote:
>> +/* 2M and 16M hugepage linux ptes are stored in an array
>> + *
>> + * 2M hugepage
>> + * ===========
>> + * one linux pte caters to two HW ptes,
>> + * so the maximum huge linux pte needed is 4096M/2M = 2048 entry
>> pointers.
>> + * Two 4K page is used to store these entry pointers(2048 * 4 = 8192
>> bytes)
>> + * in a two-dimension array, huge_2m_pte[2][1024].
>
> Actually we only need to cover TASK_SIZE so for a 2:2 split you only
> need half of the above.

I haven't polish here yet.
Yes, to be precise, this array depends on TASK_SIZE configuration.
The maximum array size is 1536 when TASK_SIZE is 0xc0000000
then kmalloc instead of __get_free_page can be used to allocate
1536 * sizeof(pte_t *). In this way VA[31:21] could be used as index
to get rid of row/column stuff.

I will keep this on V2 todo list :)


>
>> + *
>> + * How to find the hugepage linux pte corresponding to a specific address
>> ?
>> + * VA[31] is used as row index;
>> + * VA[30:21] is used as column  index;
>
> I haven't fully reviewed the code but can we not drop this row/column
> set up and just use a VA[31:21] as the index?

Please see above reply.

>
>> + *
>> + * 16M hugepage
>> + * ============
>> + * one linux pte caters for one HW pte,
>
> Actually that's a bit misleading as we need 16 consecutive pmd entries
> for a supersection. So one Linux pmd caters for 16 HW pmds.

You are right, I will correct this in V2.

>
>> + * so maxium huge linux pte needed is 4096M/16M = 256 entry pointers,
>> + * 256 * 4 = 1024 bytes spaces is allocated to store these linux pte;
>> + * this is a simple one-dimension array huge_16m_pte[256].
>> + *
>> + * VA[31:24] is used to index this array;
>
> Maybe we should call them Linux pmd rather than pte in the comments? It
> is less confusing (I know that the generic hugetlb code calls them
> ptes).

OK, I will correct this in V2.

>
> --
> Catalin
>
