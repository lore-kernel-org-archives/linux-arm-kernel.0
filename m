From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 6 Nov 2013 13:48:44 +0200
Subject: [PATCH] clk: divider: fix rate calculation for fractional rates
In-Reply-To: <20131106111534.GW16735@n2100.arm.linux.org.uk>
References: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
 <20131106111534.GW16735@n2100.arm.linux.org.uk>
Message-ID: <527A2C9C.4080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2013-11-06 13:15, Russell King - ARM Linux wrote:
> On Wed, Nov 06, 2013 at 01:06:48PM +0200, Tomi Valkeinen wrote:
>> This means that the following code works a bit oddly:
>>
>> rate = clk_round_rate(clk, 123428572);
>> clk_set_rate(clk, rate);
> 
> You're right, but the above sequence is quite a crass thing to do.  Why?

Do you mean that you think the fix is right, but the above example
sequence is silly, or that the fix is not needed either?

> clk_round_rate() returns the clock rate that clk_set_rate() would give
> you if you were to use this sequence:
> 
> 	clk_rate_rate(clk, 123428572);
> 	rate = clk_get_rate(clk);
> 
> The difference is that it doesn't change the actual clock rate itself;
> clk_round_rate() is meant to answer the question:
> 
> 	"If I were to set _this_ rate, what clock rate would
> 	 the clock give me?"
> 
> thereby providing a method for drivers to inquire what the effect would
> be when changing such a clock without actually affecting it.
> 
> So please, don't use clk_round_rate() followed by clk_set_rate().

Ok, if defined like that, then the current behavior is logical.

The comment in clk.h says "adjust a rate to the exact rate a clock can
provide", which does not contradict with what you said, but doesn't
really confirm it either. If I get "the exact rate a clock can provide"
I don't see why I can't use that exact clock rate for clk_set_rate.
Maybe the comment should be improved to state explicitly what it does.

However, how about the following sequence:

	clk_set_rate(clk, 123428572);
	rate = clk_get_rate(clk);
	clk_set_rate(clk, rate);

I didn't test that but it should result in the clock first set to
123428571, and then to 108000000. Obviously pointless if done exactly
like that, but I don't see why the above code sequence is wrong, yet it
gives a bit surprising result.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131106/8ae3124c/attachment.sig>
