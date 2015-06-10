From: dan.j.williams@intel.com (Dan Williams)
Date: Wed, 10 Jun 2015 09:00:31 -0700
Subject: [PATCH 1/2] scatterlist: use sg_phys()
In-Reply-To: <20150610093252.GA20384@8bytes.org>
References: <20150609162659.21910.41681.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150609162710.21910.57295.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20150610093252.GA20384@8bytes.org>
Message-ID: <CAPcyv4gat8TG9YnHmvD_7A7RD00Urn=febCj2Uc_cVcPi+fnCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 10, 2015 at 2:32 AM, Joerg Roedel <joro@8bytes.org> wrote:
> On Tue, Jun 09, 2015 at 12:27:10PM -0400, Dan Williams wrote:
>> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
>> index 7e7583ddd607..9f6ff6671f01 100644
>> --- a/arch/arm/mm/dma-mapping.c
>> +++ b/arch/arm/mm/dma-mapping.c
>> @@ -1502,7 +1502,7 @@ static int __map_sg_chunk(struct device *dev, struct scatterlist *sg,
>>               return -ENOMEM;
>>
>>       for (count = 0, s = sg; count < (size >> PAGE_SHIFT); s = sg_next(s)) {
>> -             phys_addr_t phys = page_to_phys(sg_page(s));
>> +             phys_addr_t phys = sg_phys(s) - s->offset;
>
> So sg_phys() turns out to be 'page_to_phys(sg_page(s)) + s->offset',
> which makes the above statement to:
>
>         page_to_phys(sg_page(s)) + s->offset - s->offset;
>
> The compiler will probably optimize that away, but it still doesn't look
> like an improvement.

The goal is to eventually stop leaking struct page deep into the i/o
stack.  Anything that relies on being able to retrieve a struct page
out of an sg entry needs to be converted.  I think we need a new
helper for this case "sg_phys_aligned()?".
