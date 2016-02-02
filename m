From: andre.przywara@arm.com (Andre Przywara)
Date: Tue, 2 Feb 2016 17:04:02 +0000
Subject: [PATCH 3/5] clk: sunxi: convert current clocks registration to
 CLK_OF_DECLARE
In-Reply-To: <20160202170037.GZ4652@lukather>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-4-git-send-email-maxime.ripard@free-electrons.com>
 <56B0BA56.10500@arm.com> <20160202170037.GZ4652@lukather>
Message-ID: <56B0E182.9000207@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 02/02/16 17:00, Maxime Ripard wrote:
> Hi,
> 
> On Tue, Feb 02, 2016 at 02:16:54PM +0000, Andre Przywara wrote:
>> Hi Maxime,
>>
>> On 02/02/16 08:47, Maxime Ripard wrote:
>>> The current clock registration and protection code has a few drawbacks, the
>>> two main ones being that we create a lot of orphans clock in the
>>> registration phase, which will be troublesome when we will start being less
>>> relaxed about them.
>>>
>>> The protection code also relies on clkdev, which we don't really use but
>>> for this particular case.
>>>
>>> Fix both at the same time by moving everyone to the CLK_OF_DECLARE that
>>> will probe our clock tree in the right and thus avoid orphans, and by
>>> protecting directly the clock returned by our registration function.
>>
>> I very much appreciate this cleanup and like the idea. Any chance we can
>> have this rather quickly, so that I can rebase the A64 support series on it?
> 
> I actually count on that :)

Great!

> I wasn't really happy about your allwinner,sunxi compatible,

Me neither, honestly, but I didn't dare to touch clk-sunxi.c even more ;-)

> so I just
> gave you an easier way out ;)

Appreciated!

> 
>>> +static void __init sun8i_ahb2_clk_setup(struct device_node *node)
>>> +{
>>> +	sunxi_mux_clk_setup(node, &sun8i_h3_ahb2_mux_data);
>>> +}
>>> +CLK_OF_DECLARE(sun8i_ahb2, "allwinner,sun8i-a31-ahb2-clk",
>>> +	       sun8i_ahb2_clk_setup);
>>
>> I don't find this clock in my tree (which is mripard/sunxi/for-next).
>> Instead I only have "allwinner,sun8i-h3-ahb2-clk", as mentioned below.
>> But as you remove this clock below from the old code and instead
>> instantiate this new clock here, this looks somehow wrong to me. Can you
>> confirm this or am I utterly confused?
> 
> Damn, you're right, it's just a silly copy-paste issue, I'll fix it.

I am sure you left it in to see if somebody actually checks it ;-)

Merci!
Andre

>> Apart from that I checked each and every clock mentioned in this patch
>> and can confirm that the transformation is correct. So if you fix this,
>> I can send a Reviewed-by.
> 
> Thanks,
> Maxime
> 
