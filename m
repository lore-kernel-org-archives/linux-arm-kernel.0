From: eric@anholt.net (Eric Anholt)
Date: Tue, 17 Mar 2015 12:06:02 -0700
Subject: [PATCH 1/4] ARM: BCM2835: Add a function for doing an rmb()
 between device reads.
In-Reply-To: <55079E79.6030303@wwwdotorg.org>
References: <1426213936-4139-1-git-send-email-eric@anholt.net>
 <55079E79.6030303@wwwdotorg.org>
Message-ID: <87wq2fla05.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen Warren <swarren@wwwdotorg.org> writes:

> On 03/12/2015 08:32 PM, Eric Anholt wrote:
>> Stephen Warren was concerned that the rmb() present in the new mailbox
>> driver was unnecessary, and after seeing the docs, that it was just so
>> surprising that somebody would come along and remove it later.  The
>> explanation for the need for the rmb() is long enough that we won't
>> want to place it at every callsite.  Make a wrapper with the whole
>> explanation in it, so that anyone wondering what's going on sees the
>> docs right there.
>
>> diff --git a/include/soc/bcm2835/peripheral-workaround.h b/include/soc/bcm2835/peripheral-workaround.h
>
>> +static inline void bcm2835_peripheral_read_workaround(void)
>> +{
>> +#ifdef CONFIG_ARCH_BCM2835
>
> Would this header be included if that wasn't defined? Perhaps that'll be
> answered by a later patch...

Well, we may find we need workaround rmb()s in, say, dwc2.  I don't
think we'd want to have them unconditional on other architectures when
bcm2835 isn't included in the build.

>> +	/*
>> +	 * The BCM2835 bus is unusual in that it doesn't guarantee
>> +	 * ordering between reads from different peripherals (where
>> +	 * peripherals roughly correspond to Linux devices).  From
>> +	 * BCM2835 ARM Peripherals.pdf, page 7:
>
> Many buses don't guarantee ordering; that's quite common. The issue is
> that the CPU then doesn't match up the correct read request and
> response, thus causing it to swap the results of read requests. That's
> the unusual part. It would be useful to spell that out more explicitly
> in this introduction, even though it is called out in the example below.
>
> BTW, the ARM mailing list is linux-arm-kernel at lists.infradead.org not
> linux-arm-kernel at vger.kernel.org.

Fixed in my send-email script, thanks!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150317/34fcb781/attachment-0001.sig>
