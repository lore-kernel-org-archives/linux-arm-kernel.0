From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Thu, 19 Feb 2015 13:02:03 +0000
Subject: [PATCH 1/2] regmap: Add range check in _regmap_raw_read()
In-Reply-To: <20150219122133.GB1581@finisterre.sirena.org.uk>
References: <1424335193-7431-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1424335239-7475-1-git-send-email-srinivas.kandagatla@linaro.org>
 <20150219102750.GC3198@finisterre.sirena.org.uk>
 <54E5C347.9070105@linaro.org>
 <20150219122133.GB1581@finisterre.sirena.org.uk>
Message-ID: <54E5DECB.5020600@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 19/02/15 12:21, Mark Brown wrote:
> On Thu, Feb 19, 2015 at 11:04:39AM +0000, Srinivas Kandagatla wrote:
>> On 19/02/15 10:27, Mark Brown wrote:
>
>>> readability.  A cheaper check for just max_register would be less
>>> concerning but it feels like we're trying to paper over a symptom with
>>> this rather than fix a problem.
>
>> Yes, just checking max_register would solve the issue for me, I think I over
>> done the patch.. I will resend with just max_register check.
>
> I'm still not happy with that, it still seems like we're just papering
> over some other problem here which we should understand before we do
> anything else.  Why are we generating out of bounds accesses in the
> first place?

The culprit was in my test code, which I eventually fixed. However I 
would have expected regmap to do some out of bound check before it tries 
to access the register space.

If I try to do an out of bound access via regmap_read()/write() it 
throws up an error, which is not the same with regmap_bulk_read/write() 
apis.

I was lucky that I got a page fault as the register range was just at 
page boundary, but in cases where the range is not at page boundary, Its 
highly likely that it could silently corrupt other memory location( 
specially in write cases).



>
