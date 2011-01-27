From: robherring2@gmail.com (Rob Herring)
Date: Thu, 27 Jan 2011 11:41:30 -0600
Subject: [PATCH] ARM: map ATAGs when not in first 1MB of RAM
In-Reply-To: <20110127163149.GF25968@n2100.arm.linux.org.uk>
References: <1296143443-9442-1-git-send-email-robherring2@gmail.com>
	<20110127163149.GF25968@n2100.arm.linux.org.uk>
Message-ID: <4D41AE4A.1000105@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On 01/27/2011 10:31 AM, Russell King - ARM Linux wrote:
> On Thu, Jan 27, 2011 at 09:50:43AM -0600, Rob Herring wrote:
>> +	/*
>> +	 * Otherwise map the 1MB region r2 points to (atags or dtb)
>> +	 */
>> +1:	mov	r0, r2, lsr #20
>> +	mov	r0, r0, lsl #20
>> +	sub	r3, r0, #(PHYS_OFFSET&  0xff000000)
>> +	.if	(PHYS_OFFSET&  0x00f00000)
>> +	sub	r3, r3, #(PHYS_OFFSET&  0x00f00000)
>
> This introduces new PHYS_OFFSET uses which we're trying hard to get
> rid of.  This will need to be reworked.

Yeah, I didn't really like that either. How about this? It's untested. 
It replaces the whole section mapping the 1st 1MB and should make 
replacing this instance of PHYS_OFFSET with a variable easier.

	/*
	 * Then map boot params address in r2 or
	 * the first 1MB of ram if boot params address is not specified.
	 */
	ldr	r3, =PHYS_OFFSET
	mov	r0, r2, lsr #20
	movs	r0, r0, lsl #20
	moveq	r0, r3
	sub	r3, r0, r3
	add	r3, r3, #PAGE_OFFSET
	add	r3, r4, r3, lsr #18
	orr	r6, r7, r0
	str	r6, [r3]

Rob
