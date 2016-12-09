From: robert.richter@cavium.com (Robert Richter)
Date: Fri, 9 Dec 2016 15:52:34 +0100
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the
 entire section
In-Reply-To: <ffaa77c7-8982-524f-f624-e4463a463daf@huawei.com>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
 <CAKv+Gu_XsKU6godiQC7wVDmCUC9bZL=kv0RarTOTATuQ5EZp2Q@mail.gmail.com>
 <584AA257.3080608@linaro.org>
 <ffaa77c7-8982-524f-f624-e4463a463daf@huawei.com>
Message-ID: <20161209145234.GB14257@rric.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09.12.16 21:15:12, Yisheng Xie wrote:
> For invalid pages, their zone and node information is not initialized, and it
> do have risk to trigger the BUG_ON, so I have a silly question,
> why not just change the BUG_ON:

We need to get the page handling correct. Modifying the BUG_ON() just
hides that something is wrong.

-Robert

> -----------
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 6de9440..af199b8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1860,12 +1860,13 @@ int move_freepages(struct zone *zone,
>          * Remove at a later date when no bug reports exist related to
>          * grouping pages by mobility
>          */
> -       VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
> +       VM_BUG_ON(early_pfn_valid(start_page) && early_pfn_valid(end_page) &&
> +                       page_zone(start_page) != page_zone(end_page));
>  #endif
> 
>         for (page = start_page; page <= end_page;) {
>                 /* Make sure we are not inadvertently changing nodes */
> -               VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
> +               VM_BUG_ON_PAGE(early_pfn_valid(page) && (page_to_nid(page) != zone_to_nid(zone)), page);
> 
>                 if (!pfn_valid_within(page_to_pfn(page))) {
>                         page++;
