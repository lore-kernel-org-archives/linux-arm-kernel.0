From: zhichang.yuan@linaro.org (zhichang.yuan)
Date: Tue, 13 May 2014 21:33:41 +0800
Subject: [PATCHv2 1/6] arm64: lib: Implement optimized memcpy routine
In-Reply-To: <20140509141308.GE7950@arm.com>
References: <1398661895-5559-1-git-send-email-zhichang.yuan@linaro.org>
 <1398661895-5559-2-git-send-email-zhichang.yuan@linaro.org>
 <20140509141308.GE7950@arm.com>
Message-ID: <53721F35.4080403@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2014?05?09? 22:13, Catalin Marinas wrote:
> On Mon, Apr 28, 2014 at 06:11:29AM +0100, zhichang.yuan at linaro.org wrote:
>> This patch, based on Linaro's Cortex Strings library, improves
>> the performance of the assembly optimized memcpy() function.
> [...]
>> --- a/arch/arm64/lib/memcpy.S
>> +++ b/arch/arm64/lib/memcpy.S
> [...]
>>  ENTRY(memcpy)
> [...]
>> +	mov	dst, dstin
>> +	cmp	count, #16
>> +	/*When memory length is less than 16, the accessed are not aligned.*/
>> +	b.lo	.Ltiny15
>> +
>> +	neg	tmp2, src
>> +	ands	tmp2, tmp2, #15/* Bytes to reach alignment. */
>> +	b.eq	.LSrcAligned
>> +	sub	count, count, tmp2
> I started looking at this and comparing it to the original cortex
> strings library. Is there any reason why at least the first part has
> been rewritten? For example, the cortex strings starts with probably the
> most likely case, comparing the count with 64.

Yes. The original cortex-string starts with comparing the count of 64. But actually when the process for count 64 begins in label .Lcpy_not_short, it will firstly make the source address aligned with 16. It means that for count over 79, the data moving starts on the boundary aligned with 16 for better efficiency. Otherwise, data moving will starts at random source address, rather than the aligned source address. Since the aligned source address is needed for count over 63, i think it is not costly to move the alignment processing at the beginning.
After this process, the data moving will start from aligned source address for most of count except when count is less than 16.
This is why current cortex-string begins with the alignment process.

In this patch, there is another change compared with original cortex-string. The original memcpy load/store memory in a decreasing address order from .Ltail63 to .Ltail15tiny. Of-course, this process will save several load/store operations when count is among [16,64). But it lead to memmove can not call memcpy directly when destination is less than source. We can found there are several branches in original memmove to grantee the call of memcpy is safe only when the destination is less than source at lease by 16. 
According to the program manual, memcpy can be used when the dest area is not overlapped with source area. But in the original cortex memcpy, it demands that the source address must be bigger than ( dst + 16 ). This limit breaks the condition when memcpy can be used. 
So I change the process of memcpy, make all load/store operate only in a increasing address order. After that, i remove the .Ldownwards code segment from memmove and call memcpy directly for this case.

The change in memcpy has a little time penalty when count is short, since several load/store are added. The current memmove is a little better than original one in performance.
