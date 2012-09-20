From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 20 Sep 2012 09:26:12 +0200
Subject: [PATCH V3 3/6] arm: cache-l2x0: add support for Aurora L2 cache
 ctrl
In-Reply-To: <20120915204257.GL12245@n2100.arm.linux.org.uk>
References: <1346852677-5381-1-git-send-email-gregory.clement@free-electrons.com>
 <1346852677-5381-4-git-send-email-gregory.clement@free-electrons.com>
 <20120915204257.GL12245@n2100.arm.linux.org.uk>
Message-ID: <505AC514.2050805@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/15/2012 10:42 PM, Russell King - ARM Linux wrote:> On Wed, Sep 05, 2012 at 03:44:34PM +0200, Gregory CLEMENT wrote:
>> @@ -275,6 +281,112 @@ static void l2x0_flush_range(unsigned long start, unsigned long end)
>>  	cache_sync();
>>  	raw_spin_unlock_irqrestore(&l2x0_lock, flags);
>>  }
>> +/*
>
> Where's the blank line?

I will fix it

>
>> + * Note that the end addresses passed to Linux primitives are
>> + * noninclusive, while the hardware cache range operations use
>> + * inclusive start and end addresses.
>> + */
>> +static unsigned long calc_range_end(unsigned long start, unsigned long end)
>> +{
>> +	if (!IS_ALIGNED(start, CACHE_LINE_SIZE)) {
>> +		pr_warn("%s: start address not align on a cache line size\n",
>> +			__func__);
>> +		start &= ~(CACHE_LINE_SIZE-1);
>> +	};
>
> No semicolon here.  But why is this check even here?
>
I will remove it, see below.

>> +
>> +	if (!IS_ALIGNED(end, CACHE_LINE_SIZE)) {
>> +		pr_warn("%s: end address not align on a cache line size\n",
>> +			__func__);
>> +		end = (PAGE_ALIGN(end));
>> +	}
>
> And this one - and why when it fails do you align to a page not a cache
> line?
I guess it was a bad copy/paste. it should be
end = ALIGN(end, CACHE_LINE_SIZE);

But I will remove it too.

>
>> +static void aurora_inv_range(unsigned long start, unsigned long end)
>> +{
>> +	/*
>> +	 * round start and end adresses up to cache line size
>> +	 */
>> +	start &= ~(CACHE_LINE_SIZE - 1);
>> +	end = ALIGN(end, CACHE_LINE_SIZE);
>> +
>> +	/*
>> +	 * Invalidate all full cache lines between 'start' and 'end'.
>> +	 */
>> +	while (start < end) {
>> +		unsigned long range_end = calc_range_end(start, end);
>
> And note that you (above) guarantee that the start/end addresses are
> cache line aligned.  It only goes wrong if your calc_range_end()
> fails - but isn't that a matter of internal proving that your code is
> correct, rather than lumbering all kernels with such checking?
>

This part of the code was almost the same than the one in
cache-feroceon-l2.c. In first the versions there was BUG_ON() to test
if start and end were aligned on a cache line. Will Deacon proposed to
fix the addresses instead of rising an oops. But in the end, we can
just remove it, right.

I am going to submit an updated series which I hope will meet your
expectation.

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
