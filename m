From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 27 Jan 2013 18:38:18 +0000
Subject: [PATCH V3 8/8] ARM: kirkwood: mv643xx_eth dt conversion
In-Reply-To: <5105275B.1020909@gmail.com>
References: <cover.1359146831.git.jason@lakedaemon.net>
 <a4805edf01c39a374d71fbf4a6b6207dedf6b2bf.1359146831.git.jason@lakedaemon.net>
 <20130126123827.GA5786@lunn.ch> <5103D103.5040409@gmail.com>
 <20130126134012.GE29973@lunn.ch>
 <20130127122119.GF23505@n2100.arm.linux.org.uk> <5105275B.1020909@gmail.com>
Message-ID: <20130127183818.GI23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 27, 2013 at 02:10:51PM +0100, Sebastian Hesselbarth wrote:
> On 01/27/2013 01:21 PM, Russell King - ARM Linux wrote:
>> On Sat, Jan 26, 2013 at 02:40:12PM +0100, Andrew Lunn wrote:
>>> On Sat, Jan 26, 2013 at 01:50:11PM +0100, Sebastian Hesselbarth wrote:
>>> The code here is based on dove_legacy_clk_init(). However the change
>>> made by Jason is in order to make a DT device work, not an non-DT
>>> device.
>>>
>>> The problem is the way the driver is getting the clock.
>>>
>>> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
>>>
> > ...
>> So, the whole:
>>
>> 	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));
>>
>> is absolutely ludicrous.  You already know which device it is by means of
>> the first argument.  You don't need to pass a "0" or a "1".  So that should
>> be NULL, so:
>>
>> 	mp->clk = clk_get(&pdev->dev, NULL);
>>
>> That will get a clock from clkdev which is setup in the _matching_ tables
>> to correlate with the device (and a NULL connection ID _there_ too).  With
>> OF, I believe it will get the first clock.
>
> The conid was set for mv643xx but shouldn't be set anymore - check
> mach-kirkwood/common.c.

If you're referring to:

	mp->clk = clk_get(&pdev->dev, (pdev->id ? "1" : "0"));

That should _never_ have ever been allowed.  It's total bollocks as I've
pointed out above.

> I guess we can just remove the conid check and rely on DT passed
> clock only.

Yes, and it _will_ work fine for non-DT too, because you have a device
with a single clock connection.  If it doesn't, then you've revealed a
latent bug - probably down to a non-conforming clk API implementation
by someone else.
