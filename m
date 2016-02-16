From: james.morse@arm.com (James Morse)
Date: Tue, 16 Feb 2016 11:13:05 +0000
Subject: [PATCH] arm64: mark kernel text segment as MEMBLOCK_NOMAP
In-Reply-To: <CAKv+Gu_yTz-ohFPS0wMX42iCkDNaSwZoZ8Yi-zsZNNu1LNDkZQ@mail.gmail.com>
References: <1455528512-32491-1-git-send-email-ard.biesheuvel@linaro.org>	<56C2FF07.30205@arm.com>
 <CAKv+Gu_yTz-ohFPS0wMX42iCkDNaSwZoZ8Yi-zsZNNu1LNDkZQ@mail.gmail.com>
Message-ID: <56C30441.1080003@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16/02/16 10:57, Ard Biesheuvel wrote:
> On 16 February 2016 at 11:50, James Morse <james.morse@arm.com> wrote:
>> On 15/02/16 09:28, Ard Biesheuvel wrote:
>>> This should hopefully address the issue reported by James, but I suppose
>>> more work is required on the hibernate side to ensure the unmapped text
>>> region is preserved, since it is no longer covered by the linear mapping.
>>
>> It does, now I have to work out how best to fix hibernate!
>>
> 
> Indeed. The alternative would be to map the [_stext, _etext] interval
> into the linear region as a ro/nx alias of the actual mapping in the
> vmalloc region. That would probably make your life easier, but I am
> not convinced the overall result is better.

I assumed you would NACK any approach that looked like that:
It could be done temporarily while the memory snapshot is being taken, only
swsusp_save() would see this mapping, it can be removed again afterwards. But
pfn_valid() will still say those pages aren't there, and there is no
memblock_clear_nomap() to change this.


The current approach involves copying the kernel text into pages that are saved,
and having two lists of pages that need restoring. (wheels within wheels!)
Pretty unpleasant, and requires another patch in the core code, so likely won't
be possible for v4.6. I should have the patches out for review later today.



James
