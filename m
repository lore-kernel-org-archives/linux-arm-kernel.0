From: mbrugger@suse.com (Matthias Brugger)
Date: Fri, 28 Oct 2016 13:06:08 +0200
Subject: [PATCH] fpga zynq: Check the bitstream for validity
In-Reply-To: <20161027143937.GC6818@obsidianresearch.com>
References: <20161026225413.GA6220@obsidianresearch.com>
 <c0e99b6e-ae72-5c64-34c1-91865d0e00b5@suse.com>
 <20161027143937.GC6818@obsidianresearch.com>
Message-ID: <8bed213a-96e3-1891-a46a-234253a2561e@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/27/2016 04:39 PM, Jason Gunthorpe wrote:
> On Thu, Oct 27, 2016 at 10:50:48AM +0200, Matthias Brugger wrote:
>>> +		/* Sanity check the proposed bitstream. It must start with the
>>> +		 * sync word in the correct byte order and be a multiple of 4
>>> +		 * bytes.
>>> +		 */
>>> +		if (count <= 4 || buf[0] != 0x66 || buf[1] != 0x55 ||
>>> +		    buf[2] != 0x99 || buf[3] != 0xaa) {
>>
>> This checks if the bit stream is bigger then 4 bytes. We error out before,
>> if it is smaller.
>
> We do? Where?
>

Just a few lines before:

+	/* All valid bitstreams are multiples of 32 bits */
+	if ((count % 4) != 0)
+		return -EINVAL;
+

The only case we don't check is, if count == 0. If we check that here, 
we can get rid of the count <= 4 check.

>> So you should fix the wording in the comment and check for count ==
>> 4.
>
> Ah right, the comment reflected an earlier revision that had the
> length check here.
>
> The count <= 4 should stay here since it is primarily guarding against
> read past the buffer in the if.

If you insist in doing this check, it should be count < 4, because we 
check the first four elements of buf, or do I miss something?

Cheers,
Matthias

>
> Jason
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
