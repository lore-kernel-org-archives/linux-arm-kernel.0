From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Tue, 28 Jan 2014 10:45:46 +0200
Subject: [PATCH] clk: divider: fix rate calculation for fractional rates
In-Reply-To: <20131106161911.GA16735@n2100.arm.linux.org.uk>
References: <1383736008-22764-1-git-send-email-tomi.valkeinen@ti.com>
 <20131106111534.GW16735@n2100.arm.linux.org.uk> <527A2C9C.4080409@ti.com>
 <20131106161911.GA16735@n2100.arm.linux.org.uk>
Message-ID: <52E76E3A.8030807@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Russell,

On 2013-11-06 18:19, Russell King - ARM Linux wrote:
> On Wed, Nov 06, 2013 at 01:48:44PM +0200, Tomi Valkeinen wrote:
>> On 2013-11-06 13:15, Russell King - ARM Linux wrote:
>>> On Wed, Nov 06, 2013 at 01:06:48PM +0200, Tomi Valkeinen wrote:
>>>> This means that the following code works a bit oddly:
>>>>
>>>> rate = clk_round_rate(clk, 123428572);
>>>> clk_set_rate(clk, rate);
>>>
>>> You're right, but the above sequence is quite a crass thing to do.  Why?
>>
>> Do you mean that you think the fix is right, but the above example
>> sequence is silly, or that the fix is not needed either?
> 
> I think a fix _is) required, because:
> 
> 	rate = clk_get_rate(clk);
> 	clk_set_rate(clk, rate);
> 	assert(clk_get_rate(clk) == rate);
> 
> If not, there's something quite wrong.  However, I am saying that the
> sequence you provided was nevertheless silly - I've seen it in real code
> in the kernel, which is why I've commented about it.

I just ran into this issue again with omap3, and so I'm resurrecting the
thread.

Mike, can you review the patch?

Russell, I'd like to understand why you think the original example is bad:

	rate = clk_round_rate(clk, rate);
	clk_set_rate(clk, rate);

If the definition of clk_round_rate is basically "clk_set_rate without
actually setting the rate", I agree that the above code is not good as
it might not work correctly.

However, if  the following code you gave should work:

	rate = clk_get_rate(clk);
	clk_set_rate(clk, rate);
	assert(clk_get_rate(clk) == rate);

then the original example should also always work, as it's almost the
same as:

	/* this is the "round" part */
	clk_set_rate(clk, rate);
	rate = clk_get_rate(clk);

	clk_set_rate(clk, rate);
	assert(clk_get_rate(clk) == rate);

Why I'm asking this is that for me (and probably for others also if
you've seen it used in the kernel code) it feels natural to have code like:

	rate = clk_round_rate(clk, rate);
	
	/* Verify the rounded rate here to see it's ok for the IP etc */

	/* The rate is ok, so set it */
	clk_set_rate(clk, rate);

This could be rewritten as:

	rounded_rate = clk_round_rate(clk, rate);
	
	/* Verify the rounded rate here to see it's ok for the IP etc */

	/* The rounded rate is ok, so set the original rate */
	clk_set_rate(clk, rate);

But it just feels unnecessary complication to keep both the original
rate and the rounded rate around.

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 901 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140128/56c20d63/attachment-0001.sig>
