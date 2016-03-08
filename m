From: jeremy.linton@arm.com (Jeremy Linton)
Date: Mon, 7 Mar 2016 18:38:13 -0600
Subject: [PATCH 0/3] arm64: simplify and optimize kernel mapping
In-Reply-To: <20160307014031.GA2158@svinekod>
References: <1457010581-4924-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160307014031.GA2158@svinekod>
Message-ID: <56DE1EF5.9070503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/06/2016 07:40 PM, Mark Rutland wrote:
> Hi,
>
> I like this series, though I have a few minor comments below.
>
> On Thu, Mar 03, 2016 at 02:09:38PM +0100, Ard Biesheuvel wrote:
>> This series makes a couple of minor changes that should result in the
>> kernel being mapped in a more efficient manner.
>>
>> First of all, it merges the .head.text with the .text section (patch #2)
>> after moving everything except the kernel and EFI header into the __init
>> section (patch #1)
>
> Face-to-face, you suggested it might be possible to move .init before .text, so
> we could place the EFI header in there too (and keep .text aligned while making
> it smaller). Is there some reason we missed that means we cannot do this?
>
>> Then, it standardizes the segment alignment to 64 KB for all page sizes.
>> (patch #3). In the example below (4 KB granule, with Jeremy's PTE_CONT
>> patch applied), we lose 80 KB in total to padding, but the resulting
>> mappings do look somewhat better.
>
> I suspect some people might want a minimal alignment option for tinification
> purposes, but this sounds fine to me as a default. I also think we can wait
> until someone asks.
>
> As a general think, currently we use "chunk" instead of "segment" in the mm
> code. We only used "chunk" so as to not overload "section". For consistency it
> would be nice to either keep with "chunk" or convert existing uses to
> "segment". I much prefer the latter!
>
>> Before:
>>
>> 0xffff000008082000-0xffff000008090000    56K  ro x  SHD AF         UXN MEM
>> 0xffff000008090000-0xffff000008200000  1472K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
>> 0xffff000008600000-0xffff000008660000   384K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008660000-0xffff00000866c000    48K  ro x  SHD AF         UXN MEM
>> 0xffff00000866c000-0xffff000008670000    16K  ro NX SHD AF         UXN MEM
>> 0xffff000008670000-0xffff000008900000  2624K  ro NX SHD AF CON     UXN MEM
>> 0xffff000008900000-0xffff000008909000    36K  ro NX SHD AF         UXN MEM
>> 0xffff000008c39000-0xffff000008c40000    28K  RW NX SHD AF         UXN MEM
>> 0xffff000008c40000-0xffff000008d50000  1088K  RW NX SHD AF CON     UXN MEM
>> 0xffff000008d50000-0xffff000008d57000    28K  RW NX SHD AF         UXN MEM
>>
>> After:
>>
>> 0xffff000008080000-0xffff000008200000  1536K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008200000-0xffff000008600000     4M  ro x  SHD AF     BLK UXN MEM
>> 0xffff000008600000-0xffff000008670000   448K  ro x  SHD AF CON     UXN MEM
>> 0xffff000008670000-0xffff000008910000  2688K  ro NX SHD AF CON     UXN MEM
>> 0xffff000008c50000-0xffff000008d60000  1088K  RW NX SHD AF CON     UXN MEM
>> 0xffff000008d60000-0xffff000008d6b000    44K  RW NX SHD AF         UXN MEM
>>
>> I am aware that this clashes with Jeremy's patch to allow CONT_SIZE alignment
>> when CONFIG_DEBUG_ALIGN_RODATA=y, but the net effect of patch #3 is the same
>> (only the Kconfig change is not included here)
>
> Jeremy, do you have any thoughts on this series?

	I was waiting to see if anyone questioned padding the minimum kernel 
alignment. But other than that, It looks good.

	I've been meaning to test it at 64k pages to see how much rearranging 
everything helps. I guess I will be rolling another CONT set to address 
Will's reluctance to have the extra TLB flushes (and probably rework the 
block break case as well) unless someone decides they want this now. I 
will make sure that these two patch sets merge cleanly when I do that.

	Thanks,
