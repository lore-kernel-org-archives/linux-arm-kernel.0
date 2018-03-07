From: eric@anholt.net (Eric Anholt)
Date: Wed, 07 Mar 2018 09:51:09 -0800
Subject: [PATCH 2/5] staging: vc04_services: Remove cache-line-size
 property.
In-Reply-To: <51dc71d7-e8f5-2785-ad13-a941bc9278ab@raspberrypi.org>
References: <20180305202806.21219-1-eric@anholt.net>
 <20180305202806.21219-3-eric@anholt.net>
 <a8f369f5-691c-c05f-4c7c-2eadcf4c48c8@i2se.com> <87muzl9ger.fsf@anholt.net>
 <638bd870-bb17-a0e1-d2aa-30a364b53279@raspberrypi.org>
 <1332781939.275857.1520424630939@email.1und1.de>
 <51dc71d7-e8f5-2785-ad13-a941bc9278ab@raspberrypi.org>
Message-ID: <87371bydte.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phil Elwell <phil@raspberrypi.org> writes:

> On 07/03/2018 12:10, Stefan Wahren wrote:
>> Hi Phil,
>
> <snip>
>
>>> It is the L2 cache line size that matters, but as long as you end up with
>>> the numbers Stefan mentioned - 32 on BCM2835, 64 on BCM2836 and BCM2837 -
>>> I'm not too bothered how you get there.
>> 
>> i think a kernel with bcm2835_defconfig on RPi 2 could be such a corncase.
>> 
>> Am i right that the firmware doesn't rely on the existence of "cache-line-size"?
>
> Because of the way partial cache lines are handled it is more important that the
> two sides agree than that the value is correct. As a result, the firmware treats
> the absence of a "cache_line_size" DT parameter (that sets the "cache-line-size"
> property) in the DTB as an indication that the kernel driver pre-dates the ability
> to switch, and uses the old fixed value of 32 as a fallback. Otherwise it sets the
> parameter and the internal value used by the VPU-side VCHIQ to the correct value.
>
> There are a number of ways to fix this, the easiest of which is to assume that the kernel
> driver will either read the property or be able to work out the correct value, so
> the VPU should always use the correct value regardless of the success of applying
> the parameter/changing the property.

Oh, interesting.  So with my patch, we end up with a mismatch where VPU
is treating things as 32, and the kernel is using 64.  I wasn't seeing
errors in vchiq_test in this state, which is a bit concerning.

I'll go ahead and drop this patch and replace it with a comment in the
code about this discussion.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180307/eb12c671/attachment.sig>
