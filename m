From: xieyisheng1@huawei.com (Yisheng Xie)
Date: Fri, 9 Dec 2016 21:15:12 +0800
Subject: [PATCH v2] arm64: mm: Fix memmap to be initialized for the entire
 section
In-Reply-To: <584AA257.3080608@linaro.org>
References: <1480530091-1092-1-git-send-email-rrichter@cavium.com>
 <bc099ca6-d927-3eb6-438c-291a66ecf5f9@huawei.com>
 <CAKv+Gu_XsKU6godiQC7wVDmCUC9bZL=kv0RarTOTATuQ5EZp2Q@mail.gmail.com>
 <584AA257.3080608@linaro.org>
Message-ID: <ffaa77c7-8982-524f-f624-e4463a463daf@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2016/12/9 20:23, Hanjun Guo wrote:
> On 12/09/2016 08:19 PM, Ard Biesheuvel wrote:
>> On 9 December 2016 at 12:14, Yisheng Xie <xieyisheng1@huawei.com> wrote:
>>> Hi Robert,
>>> We have merged your patch to 4.9.0-rc8, however we still meet the similar problem
>>> on our D05 board:
>>>
>>
>> To be clear: does this issue also occur on D05 *without* the patch?
> 
> It boots ok on D05 without this patch.
> 
> But I think the problem Robert described in the commit message is
> still there, just not triggered in the boot. we met this problem
> when having LTP stress memory test and hit the same BUG_ON.
> 
That's right. for D05's case, when trigger the BUG_ON on:
1863         VM_BUG_ON(page_zone(start_page) != page_zone(end_page));

the end_page is not nomap, but BIOS reserved. here is the log I got:

[    0.000000] efi:   0x00003fc00000-0x00003fffffff [Reserved           |   |  |  |  |  |  |  |   |  |  |  |  ]
[...]
[    5.081443] move_freepages: phys(start_page: 0x20000000,end_page:0x3fff0000)

For invalid pages, their zone and node information is not initialized, and it
do have risk to trigger the BUG_ON, so I have a silly question,
why not just change the BUG_ON:
-----------
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6de9440..af199b8 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1860,12 +1860,13 @@ int move_freepages(struct zone *zone,
         * Remove at a later date when no bug reports exist related to
         * grouping pages by mobility
         */
-       VM_BUG_ON(page_zone(start_page) != page_zone(end_page));
+       VM_BUG_ON(early_pfn_valid(start_page) && early_pfn_valid(end_page) &&
+                       page_zone(start_page) != page_zone(end_page));
 #endif

        for (page = start_page; page <= end_page;) {
                /* Make sure we are not inadvertently changing nodes */
-               VM_BUG_ON_PAGE(page_to_nid(page) != zone_to_nid(zone), page);
+               VM_BUG_ON_PAGE(early_pfn_valid(page) && (page_to_nid(page) != zone_to_nid(zone)), page);

                if (!pfn_valid_within(page_to_pfn(page))) {
                        page++;

Thanks,
Yisheng Xie

> Thanks
> Hanjun
> 
> .
> 
