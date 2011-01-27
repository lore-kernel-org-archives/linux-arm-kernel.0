From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 27 Jan 2011 17:46:03 +0000
Subject: [PATCH] ARM: map ATAGs when not in first 1MB of RAM
In-Reply-To: <4D41AE4A.1000105@gmail.com>
References: <1296143443-9442-1-git-send-email-robherring2@gmail.com>
	<20110127163149.GF25968@n2100.arm.linux.org.uk>
	<4D41AE4A.1000105@gmail.com>
Message-ID: <20110127174603.GB605@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 27, 2011 at 11:41:30AM -0600, Rob Herring wrote:
> Russell,
>
> On 01/27/2011 10:31 AM, Russell King - ARM Linux wrote:
>> On Thu, Jan 27, 2011 at 09:50:43AM -0600, Rob Herring wrote:
>>> +	/*
>>> +	 * Otherwise map the 1MB region r2 points to (atags or dtb)
>>> +	 */
>>> +1:	mov	r0, r2, lsr #20
>>> +	mov	r0, r0, lsl #20
>>> +	sub	r3, r0, #(PHYS_OFFSET&  0xff000000)
>>> +	.if	(PHYS_OFFSET&  0x00f00000)
>>> +	sub	r3, r3, #(PHYS_OFFSET&  0x00f00000)
>>
>> This introduces new PHYS_OFFSET uses which we're trying hard to get
>> rid of.  This will need to be reworked.
>
> Yeah, I didn't really like that either. How about this? It's untested.  
> It replaces the whole section mapping the 1st 1MB and should make  
> replacing this instance of PHYS_OFFSET with a variable easier.

With the p2v patches, queued for the next merge window, PHYS_OFFSET
becomes:

extern unsigned long __pv_phys_offset;
#define PHYS_OFFSET __pv_phys_offset

so using PHYS_OFFSET in any way in assembly isn't going to work too
well.  Luckily, the p2v patches supply __create_page_tables with a
value of PHYS_OFFSET in r8.

What this means is that there's an fundamental interdependence between
your patches and mine.  Your patches can work without the p2v patches.
Or they can be made to work with the p2v patches applied.

So I think this needs to wait until after the next merge window, or it
needs to be prepared against the p2v patches (see my p2v branch) and
applied there once everyone's happy with it.
