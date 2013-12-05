From: grygorii.strashko@ti.com (Strashko, Grygorii)
Date: Thu, 5 Dec 2013 18:48:21 +0000
Subject: [PATCH v2 08/23] mm/memblock: Add memblock memory allocation apis
In-Reply-To: <20131205165325.GA24062@mtj.dyndns.org>
References: <1386037658-3161-1-git-send-email-santosh.shilimkar@ti.com>
 <1386037658-3161-9-git-send-email-santosh.shilimkar@ti.com>
 <20131203232445.GX8277@htj.dyndns.org>
 <52A0AB34.2030703@ti.com>,<20131205165325.GA24062@mtj.dyndns.org>
Message-ID: <902E09E6452B0E43903E4F2D568737AB097B26B2@DNCE04.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tejun,

>On Thu, Dec 05, 2013 at 06:35:00PM +0200, Grygorii Strashko wrote:
>> >> +#define memblock_virt_alloc_align(x, align) \
>> >> +  memblock_virt_alloc_try_nid(x, align, BOOTMEM_LOW_LIMIT, \
>> >> +                               BOOTMEM_ALLOC_ACCESSIBLE, MAX_NUMNODES)
>> >
>> > Also, do we really need this align variant separate when the caller
>> > can simply specify 0 for the default?
>>
>> Unfortunately Yes.
>> We need it to keep compatibility with bootmem/nobootmem
>> which don't handle 0 as default align value.
>
>Hmm... why wouldn't just interpreting 0 to SMP_CACHE_BYTES in the
>memblock_virt*() function work?
>

Problem is not with memblock_virt*(). The issue will happen in case if
memblock or nobootmem are disabled in below code (memblock_virt*() is disabled).

+/* Fall back to all the existing bootmem APIs */
+#define memblock_virt_alloc(x) \
+       __alloc_bootmem(x, SMP_CACHE_BYTES, BOOTMEM_LOW_LIMIT)

which will be transformed to 
+/* Fall back to all the existing bootmem APIs */
+#define memblock_virt_alloc(x, align) \
+       __alloc_bootmem(x, align, BOOTMEM_LOW_LIMIT)

and used as

memblock_virt_alloc(size, 0);

so, by default bootmem code will use 0 as default alignment and not SMP_CACHE_BYTES
and that is wrong.

Regards,
-grygorii
