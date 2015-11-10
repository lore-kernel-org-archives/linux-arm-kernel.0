From: laura@labbott.name (Laura Abbott)
Date: Mon, 9 Nov 2015 17:34:11 -0800
Subject: [PATCHv4] mm: Don't offset memmap for flatmem
In-Reply-To: <CA+8MBbLGdYfQRPnVmT=te1y3C7PhCcXqbDGXb7LtqvCWTA+vDQ@mail.gmail.com>
References: <1444253335-5811-1-git-send-email-labbott@fedoraproject.org>
 <CA+8MBbLGdYfQRPnVmT=te1y3C7PhCcXqbDGXb7LtqvCWTA+vDQ@mail.gmail.com>
Message-ID: <56414993.8070709@labbott.name>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/9/15 3:20 PM, Tony Luck wrote:
>> @@ -4984,9 +4987,9 @@ static void __init_refok alloc_node_mem_map(struct pglist_data *pgdat)
>>           */
>>          if (pgdat == NODE_DATA(0)) {
>>                  mem_map = NODE_DATA(0)->node_mem_map;
>> -#ifdef CONFIG_HAVE_MEMBLOCK_NODE_MAP
>> +#if defined(CONFIG_HAVE_MEMBLOCK_NODE_MAP) || defined(CONFIG_FLATMEM)
>>                  if (page_to_pfn(mem_map) != pgdat->node_start_pfn)
>> -                       mem_map -= (pgdat->node_start_pfn - ARCH_PFN_OFFSET);
>> +                       mem_map -= offset;
>>   #endif /* CONFIG_HAVE_MEMBLOCK_NODE_MAP */
>>          }
>>   #endif
>
> This piece breaks ia64.  See the comment earlier in the function
> that "ia64 gets its own node_mem_map" ... so we skip the initialization
> of offset ... and arrive down here and just subtract "0" from mem_map.
>
> Attached patch fixes ia64 ... does ARM still work if this is applied?
>
> -Tony
>

Yes, this still fixes the problem for me. I see the pfn <-> page
translation working as expected.

Tested-by: Laura Abbott <laura@labbott.name>

Thanks,
Laura
