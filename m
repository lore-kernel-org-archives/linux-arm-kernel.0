From: ddaney.cavm@gmail.com (David Daney)
Date: Wed, 24 Aug 2016 16:07:25 -0700
Subject: [PATCH v2 2/2] HWRNG: thunderx: Add Cavium HWRNG driver for
 ThunderX SoC.
In-Reply-To: <874d0bce-cf9b-8772-5af4-ec3844b3b255@gmail.com>
References: <1471994835-2423-1-git-send-email-okhaliq@caviumnetworks.com>
 <1471994835-2423-3-git-send-email-okhaliq@caviumnetworks.com>
 <874d0bce-cf9b-8772-5af4-ec3844b3b255@gmail.com>
Message-ID: <57BE28AD.5080607@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2016 10:46 PM, Corentin LABBE wrote:
> Hello
>
>> +/* Read data from the RNG unit */
>> +static int cavium_rng_read(struct hwrng *rng, void *dat, size_t max, bool wait)
>> +{
>> +	struct cavium_rng *p = container_of(rng, struct cavium_rng, ops);
>> +	unsigned int size = max;
>> +
>> +	while (size >= 8) {
>> +		*((u64 *)dat) = readq(p->result);
>> +		size -= 8;
>> +		dat += 8;
>> +	}
>
> I think you could use readsq()
> This will increase throughput

If you look at the implementation of readsq(), you will see that it is a 
similar loop.  Since the overhead is primarily I/O latency from the RNG 
hardware, the throughput cannot really be changed with micro 
optimizations to this simple loop.

Also, on big-endian kernels, it appears that a loop of readq() and 
readsq() will give different results as readq will byte swap the result 
and readsq does not.  Since this is a RNG, the byte swapping is not 
important, but it is a difference.

Because of this, I think it should be acceptable to stick with the loop 
we currently have.

If the hwrng maintainers want to change the loop, to a readsq(), we 
might investigate this more.

Thanks,
David Daney
