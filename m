From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 2 May 2018 20:38:06 +0530
Subject: [PATCH v9 03/27] clk: davinci: psc: allow for dev == NULL
In-Reply-To: <94d4cfc5-0ea7-e642-c7e3-8d549bdef8ce@lechnology.com>
References: <20180427001745.4116-1-david@lechnology.com>
 <20180427001745.4116-4-david@lechnology.com>
 <8940259b-5811-ce9f-8262-17d39ca0a46f@ti.com>
 <94d4cfc5-0ea7-e642-c7e3-8d549bdef8ce@lechnology.com>
Message-ID: <3cec9c1f-48fd-1c16-b642-eb93e41446fc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 May 2018 07:19 AM, David Lechner wrote:
> On 05/01/2018 09:02 AM, Sekhar Nori wrote:
>> On Friday 27 April 2018 05:47 AM, David Lechner wrote:
>>> +static inline void *_devm_kzalloc(struct device *dev, size_t size,
>>> gfp_t flags)
>>> +{
>>> +??? if (dev)
>>> +??????? return devm_kzalloc(dev, size, flags);
>>> +
>>> +??? return kzalloc(size, flags);
>>> +}
>>
>> I have the same question on the utility of this. A memory allocation
>> error so early on is not going to result in a bootable system anyway.
>> So, I wonder if its better to just BUG() in such cases. That will
>> actually help faster debug than returning an error back. I know the push
>> back on using BUG(), but clock drivers are special, and I think thats
>> why its seems to be used quite a bit already.
>>
> 
> Same reply here as well. On DA850/DA830, you might not get a console,
> but you will "boot" even if one of the PSC devices fails though.

Was not thinking of failure to boot due to clocks being disabled, but
the fact that you are not able to allocate a small amount of memory so
early in boot process. The chances of successful boot after memory
allocation failures like that are close to zero.

> WARN() is probably just as good as BUG() in this case too.

Okay, but with WARN() you would continue to proceed to try to boot which
is not going to be much fruitful (and might actually muddle the first
failure). But up to you on this.

Thanks,
Sekhar
