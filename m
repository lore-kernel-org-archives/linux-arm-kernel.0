From: bones@secretlab.ca (John Bonesio)
Date: Mon, 21 Mar 2011 16:42:24 -0700
Subject: [PATCH v2] ARM:boot:device tree: Allow the device tree binary
	to be appended to zImage
In-Reply-To: <alpine.LFD.2.00.1103211844500.11889@xanadu.home>
References: <20110321221930.19756.36549.stgit@riker>
	<alpine.LFD.2.00.1103211844500.11889@xanadu.home>
Message-ID: <4D87E260.6050902@secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Is this addhi instruction the only one, or do I need to go through and
find other instructions to update as well?

Thanks for being patient as I learn.

- John

On 03/21/2011 03:49 PM, Nicolas Pitre wrote:
> On Mon, 21 Mar 2011, John Bonesio wrote:
> 
>> This patch provides the ability to boot using a device tree that is appended
>> to the raw binary zImage (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
>>
>> Signed-off-by: John Bonesio <bones@secretlab.ca>
> 
> One minor glitch still...  ;-)
> 
>> @@ -288,12 +344,28 @@ wont_overwrite:
>>  
>>  		/*
>>  		 * Relocate all entries in the GOT table.
>> +		 * Bump bss entries to _edata + dtb size
>>  		 */
>>  1:		ldr	r1, [r11, #0]		@ relocate entries in the GOT
>> -		add	r1, r1, r0		@ table.  This fixes up the
>> -		str	r1, [r11], #4		@ C references.
>> +		add	r1, r1, r0		@ This fixes up C references
>> +		cmp	r1, r2			@ if entry >= bss_start &&
>> +		cmphs	r3, r1			@       bss_end > entry
>> +		addhi	r1, lr			@    entry += dtb size
> 
> Some toolchains won't accept this shortened version unless you compile 
> for Thumb.  You should instead use:
> 
> 		addhi	r1, r1, lr
> 
> Otherwise...
> 
> Reviewed-by: Nicolas Pitre <nicolas.pitre@linaro.org>
> 
> 
> Nicolas
