From: stefan@agner.ch (Stefan Agner)
Date: Mon, 13 Jul 2015 21:48:40 +0200
Subject: [PATCH v3] ARM: early fixmap support for earlycon
In-Reply-To: <20150710112522.GR7557@n2100.arm.linux.org.uk>
References: <1433593888-7142-1-git-send-email-stefan@agner.ch>
 <20150606124800.GR7557@n2100.arm.linux.org.uk>
 <20150710112522.GR7557@n2100.arm.linux.org.uk>
Message-ID: <2f1c4850e9e67e4f9fb8617e7352e796@agner.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2015-07-10 13:25, Russell King - ARM Linux wrote:
> On Sat, Jun 06, 2015 at 01:48:00PM +0100, Russell King - ARM Linux wrote:
>> On Sat, Jun 06, 2015 at 02:31:28PM +0200, Stefan Agner wrote:
>> > @@ -1231,7 +1272,7 @@ static void __init devicemaps_init(const struct machine_desc *mdesc)
>> >
>> >  	early_trap_init(vectors);
>> >
>> > -	for (addr = VMALLOC_START; addr; addr += PMD_SIZE)
>> > +	for (addr = VMALLOC_START; addr < FIXADDR_START; addr += PMD_SIZE)
>> >  		pmd_clear(pmd_off_k(addr));
>>
>> You introduce a bug here - we no logner clear the very top entry of the
>> page tables, which means it could contain anything - and means that the
>> subsequent creation of the L2 table in early_pte_alloc() can fail.
> 
> You trimmed my reply hard, and seemingly ignored this; the v4 patch
> contains exactly the same code here, and therefore continues to leave
> the top of the page table uninitialised.

Maybe I get something wrong here, but the very top PMD is left out on
purpose, since early_fixmap_shutdown takes care of that.

However v3 also did not clear the second to top PMD. I thought I did
take care of that by using this slightly different for loop in v4:
for (addr = VMALLOC_START; addr < (FIXADDR_TOP & PMD_MASK); addr +=
PMD_SIZE)

However, looking now@the code I'm not sure if this is right either. 

I think what is needed is addr < (FIXADDR_TOP & ~PMD_MASK). This will
make sure that only the top PMD is not cleared, which is taken care of
by early fixmap...

--
Stefan
