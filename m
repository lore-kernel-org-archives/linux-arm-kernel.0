From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Mon, 17 Jan 2011 15:01:28 +0100
Subject: [PATCH] OMAP: use fncpy to copy the PM code functions to SRAM
In-Reply-To: <20110114173400.GB22505@n2100.arm.linux.org.uk>
References: <1295018470-18099-1-git-send-email-j-pihet@ti.com>
	<20110114155806.GA22505@n2100.arm.linux.org.uk>
	<AANLkTikz_gSQE5QfO6ZXwbp9w+HTNMtb6RLBY+3Z0XF6@mail.gmail.com>
	<20110114173400.GB22505@n2100.arm.linux.org.uk>
Message-ID: <AANLkTim9At1MZmid1jqqCJAk28BPo0aJEf7QkZM=y4h2@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 14, 2011 at 6:34 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Jan 14, 2011 at 05:13:01PM +0100, Jean Pihet wrote:
>> Is the name 'omap_sram_push' wrong then?
>> What about the following?
>> @@ -251,9 +251,8 @@ void * omap_sram_push(void * start, unsigned long size)
>>
>> ? ? ? ?omap_sram_ceil -= size;
>> ? ? ? ?omap_sram_ceil = ROUND_DOWN(omap_sram_ceil, sizeof(void *));
>> ?- ? ? memcpy((void *)omap_sram_ceil, start, size);
>> ?- ? ? flush_icache_range((unsigned long)omap_sram_ceil,
>> ?- ? ? ? ? ? ? (unsigned long)(omap_sram_ceil + size));
>>
>> ?- ? ? return (void *)omap_sram_ceil;
>> ?+ ? ?return fncpy((void *)omap_sram_ceil, start, size);
>
> It's more correct, but still missing out on the type safety which we've
> tried to provide with fncpy.
IIUC the type of the function is propagated from the 2nd argument
(funcp) to the return value, which is fine here. The (void)* is here
only to avoid a warning thrown by memcpy.

>?Note also the other issue with Dave Martin
> has raised though - this isn't ready for merging yet.
Ok I am using the latest version now and will re-spin the patch.

Regards,
Jean
