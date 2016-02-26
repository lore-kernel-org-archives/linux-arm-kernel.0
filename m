From: jeremy.linton@arm.com (Jeremy Linton)
Date: Fri, 26 Feb 2016 08:59:47 -0600
Subject: [PATCH v3] arm64: mm: Mark .rodata as RO
In-Reply-To: <20160226145516.GE8728@leverpostej>
References: <1455904232-24053-1-git-send-email-jeremy.linton@arm.com>
 <20160226145516.GE8728@leverpostej>
Message-ID: <56D06863.3080901@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/26/2016 08:55 AM, Mark Rutland wrote:
> On Fri, Feb 19, 2016 at 11:50:32AM -0600, Jeremy Linton wrote:
>> Currently the .rodata section is actually still executable when DEBUG_RODATA
>> is enabled. This changes that so the .rodata is actually read only, no execute.
>> It also adds the .rodata section to the mem_init banner.
>>
>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>> ---
>>   arch/arm64/kernel/vmlinux.lds.S |  5 +++--
>>   arch/arm64/mm/init.c            |  4 +++-
>>   arch/arm64/mm/mmu.c             | 17 +++++++++++++----
>>   3 files changed, 19 insertions(+), 7 deletions(-)
>>
>> diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
>> index 8f4fc2c..9208f53 100644
>> --- a/arch/arm64/kernel/vmlinux.lds.S
>> +++ b/arch/arm64/kernel/vmlinux.lds.S
>> @@ -114,8 +114,9 @@ SECTIONS
>>   		*(.got)			/* Global offset table		*/
>>   	}
>>
>> -	RO_DATA(PAGE_SIZE)
>> -	EXCEPTION_TABLE(8)
>> +	ALIGN_DEBUG_RO_MIN(0)
>> +	RO_DATA(PAGE_SIZE)		/* everything from this point to */
>> +	EXCEPTION_TABLE(8)		/* _etext will be marked RO NX   */
>>   	NOTES
>
> That should be ALIGN_DEBUG_RO_MIN(PAGE_SIZE), given we map .text and
> .rodata separately regardless of DEBUG_RODATA (and hence they need to
> never share a page).
>

The RO_DATA macro has an explicit alignment (PAGE_SIZE in this case) in 
it too. That is why I left it at 0 to make it clear that it wasn't 
changing the alignment unless DEBUG_RO was enabled (and in that case 
only really applies if the section_size/cont_size is enabled).
