From: eric@anholt.net (Eric Anholt)
Date: Mon, 03 Oct 2016 12:50:27 -0700
Subject: [PATCH] i2c: bcm2835: Set up the clock stretching timeout at boot.
In-Reply-To: <20160722072740.GG1605@katana>
References: <1464818845-5348-1-git-send-email-eric@anholt.net>
 <20160704003118.GA1381@tetsubishi> <87lh1ip653.fsf@eliezer.anholt.net>
 <20160722072740.GG1605@katana>
Message-ID: <87int9nrek.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wolfram Sang <wsa@the-dreams.de> writes:

> On Sun, Jul 03, 2016 at 06:02:32PM -0700, Eric Anholt wrote:
>> Wolfram Sang <wsa@the-dreams.de> writes:
>> 
>> >> +	/*
>> >> +	 * SMBUS says "Devices participating in a transfer will
>> >> +	 * timeout when any clock low exceeds the value of
>> >> +	 * T_TIMEOUT,MIN of 25 ms."
>> >> +	 */
>> >
>> > SMBus has that timeout, but I2C doesn't. How about disabling the timeout
>> > simply? Or using the max value if you want to keep the timeout
>> > detection?
>> 
>> Disabling the timeout seems fine to me.  We still have a 1-second
>> timeout around the entire transfer.  I'll be back on my DSI branch this
>> week and test it out then.
>
> Did it work?

Sorry for the long-delayed feedback: It turned out that the reason I was
getting timeouts and looking into i2c in the first place was that the
firmware was driving that controller behind my back, so I couldn't do
useful testing anyway.

I put together a patch
(https://github.com/anholt/linux/commit/894200276239d2e4c60b378bdc52164fcb13af8d)
but I'm a bit concerned by it: I don't see a way to get the controller
back to its idle state without continuing through the I2C state machine,
and if the clock is still being stretched it doesn't continue unless CLK
is triggered.

What is supposed to happen when adap->timeout times out while the clock
is being stretched?  Should we be able to try starting a fresh new I2C
transaction cleanly?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 800 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161003/880af017/attachment.sig>
