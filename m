From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 10 Dec 2013 16:13:15 -0800
Subject: [PATCH 3/8] regmap: Add support for using regmap over ssbi
In-Reply-To: <20131210235000.GK11468@sirena.org.uk>
References: <1386718523-2587-1-git-send-email-sboyd@codeaurora.org>
 <1386718523-2587-4-git-send-email-sboyd@codeaurora.org>
 <20131210235000.GK11468@sirena.org.uk>
Message-ID: <52A7AE1B.3040201@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/10/13 15:50, Mark Brown wrote:
> On Tue, Dec 10, 2013 at 03:35:18PM -0800, Stephen Boyd wrote:
>
>> +	while (val_size) {
>> +		ret = ssbi_read(context, *(u16 *)reg, val, 1);
>> +		if (ret)
>> +			return ret;
>> +		reg += sizeof(u16);
>> +		val += sizeof(u8);
>> +		val_size -= sizeof(u8);
> I'd expect this to generate out of bounds accesses and bad interactions
> on the bus if we go through the loop more than once since it appears to
> incrementing the address of reg for every register.  I'm also having a
> hard time understanding why this is doing a read per byte, ssbi_read()
> seems to map fairly directly onto the interface of the operation so
> there doesn't seem to be any reason for this loop to exist in the first
> place.

ssbi_read() just reads the same register x number of times and doesn't
do any sort of incrementing of address. My understanding was that
regmap_bulk_read() will read incrementing addresses and then call down
into this code with the sequential addresses formatted into the reg
buffer. That was the flaw. Instead we need to take reg and then
increment reg by 1 every time through this loop. Or should we just have
use_single_rw == true?

>
> Has this been tested?  

Yes. But so far they've all been single register reads.

>
> It'd be helpful to CC the entire series, or at least the patches this
> builds on...

Sure, will do next time.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
