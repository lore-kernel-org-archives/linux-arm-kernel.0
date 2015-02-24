From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Tue, 24 Feb 2015 09:12:43 +0000
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <20150224085524.GC6236@finisterre.sirena.org.uk>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219102750.GC3198@finisterre.sirena.org.uk>
 <54E5C347.9070105@linaro.org>
 <20150219122133.GB1581@finisterre.sirena.org.uk>
 <54E5DECB.5020600@linaro.org>
 <20150224085524.GC6236@finisterre.sirena.org.uk>
Message-ID: <54EC408B.60209@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 24/02/15 08:55, Mark Brown wrote:
> On Thu, Feb 19, 2015 at 01:02:03PM +0000, Srinivas Kandagatla wrote:
>
>> The culprit was in my test code, which I eventually fixed. However I would
>> have expected regmap to do some out of bound check before it tries to access
>> the register space.
>
>> If I try to do an out of bound access via regmap_read()/write() it throws up
>> an error, which is not the same with regmap_bulk_read/write() apis.
>
>> I was lucky that I got a page fault as the register range was just at page
>> boundary, but in cases where the range is not at page boundary, Its highly
>> likely that it could silently corrupt other memory location( specially in
>> write cases).
>
> The risk of page faults mostly only applies to memory mapped register
> maps - most register maps are on other buses where things are a bit less
> clear, we do often have writes to undocumented registers which aren't

Yes, my test was on memory mapped registers.

> included in the readability checks (indeed it's rare for anything to
> actually give us writability information for the write side).  As
> covered in earlier messages a part of this is a performance tradeoff,
> it's potentially expensive for us to do the checks on bulk I/O but for
> single register access it's much cheaper relative to the operation as a
> whole.

I totally agree with you on the performance overhead of checking every 
read/write, But on the other hand adding a single range check is better 
than no check with less/nil performance overhead.

>
> It's particularly interesting for MMIO actually as these devices are by
> far the most performance intensive, we don't have all the costs of the
> bus to mask what regmap is doing.
>
