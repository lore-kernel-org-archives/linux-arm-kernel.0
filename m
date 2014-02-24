From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Mon, 24 Feb 2014 20:38:44 -0300
Subject: [PATCH 1/5] clk: sun6i: Protect CPU clock
In-Reply-To: <20140224163034.GN21483@n2100.arm.linux.org.uk>
References: <1393258967-4843-1-git-send-email-maxime.ripard@free-electrons.com>
 <1393258967-4843-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140224163034.GN21483@n2100.arm.linux.org.uk>
Message-ID: <530BD804.5090806@elopez.com.ar>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

El 24/02/14 13:30, Russell King - ARM Linux escribi?:
> On Mon, Feb 24, 2014 at 05:22:43PM +0100, Maxime Ripard wrote:
>> Right now, AHB is an indirect child clock of the CPU clock. If that happens to
>> change, since the CPU clock has no other consumers declared in Linux, it would
>> be shut down, which is not really a good idea.
>>
>> Prevent this by forcing it enabled.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>   drivers/clk/sunxi/clk-sunxi.c | 8 ++++++++
>>   1 file changed, 8 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi/clk-sunxi.c b/drivers/clk/sunxi/clk-sunxi.c
>> index 23baad9..cedaf4b 100644
>> --- a/drivers/clk/sunxi/clk-sunxi.c
>> +++ b/drivers/clk/sunxi/clk-sunxi.c
>> @@ -1301,6 +1301,14 @@ static void __init sunxi_clock_protect(void)
>>   		clk_prepare_enable(clk);
>>   		clk_put(clk);
>>   	}
>> +
>> +	/* CPU clocks - sun6i */
>> +	clk = clk_get(NULL, "cpu");
>> +	if (!IS_ERR(clk)) {
>> +		clk_prepare_enable(clk);
>> +		clk_put(clk);
>> +	}
>
> This is broken.  I'm not sure what's difficult to grasp about the concept
> of "while a clock is in use, you should keep a reference to that clock".
>
> That implies that if you get a clock, and then enable it, you don't
> put the clock until you've disabled it.

Why is this so? Can't a clock be left enabled while nobody has a 
reference to it? I have looked around in Documentation/ (rather quickly 
I must say) and have not found any explicit mention that it is required 
to keep a reference to the clock while it's enabled. I'd appreciate it 
if you could explain this a bit more verbosely or point me to the 
relevant documents.

For what it's worth, I've seen this same pattern on 
enable/disable_clock() on drivers/base/power/clock_ops.c as well.

Cheers,

Emilio
