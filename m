From: emilio@elopez.com.ar (=?ISO-8859-1?Q?Emilio_L=F3pez?=)
Date: Thu, 9 Jan 2014 13:47:00 -0200
Subject: [PATCH v2 4/8] arm: dts: sun4i: rename clock node names to clk@N
In-Reply-To: <20140109085339.GN2941@lukather>
References: <1388987892-23733-1-git-send-email-wens@csie.org>
 <1388987892-23733-5-git-send-email-wens@csie.org>
 <20140107223823.GH3103@lukather>
 <CAGb2v657=0Z+5e9zUYq5Tq9CB7XAGEwR1=2iw3L86s3SXnrU-Q@mail.gmail.com>
 <20140109085339.GN2941@lukather>
Message-ID: <CAAoKrfoVaXuJPWsKCpWY6AFUrbEwQscgfGO90h0WSq57u-e-_w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2014/1/9 Maxime Ripard <maxime.ripard@free-electrons.com>:
>> You are right. pll5 only has 2 outputs. I was matching the format of
>> pll6, which I'd like to include in this discussion.
>>
>> Does pll6 actually have 3 outputs? or are we just using the third
>> output as a shortcut for mbus input of pll6*2 ?
>
> Hmmm, indeed. I don't really get why pll6 has a third output
> either. Emilio?

Citing the A20 user manual (my comments on the right)

-----8<------
For SATA, the output =(24MHz*N*K)/M/6 <-- we call this pll6_sata
If the SATA is on, the clock output should be equal to 100MHz;
For other module, the clock output = (24MHz*N*K)/2 <-- we call this pll6_other
PLL6*2 = 24MHz*N*K <-- this would be the third output, which we call pll6
-----8<------

This last output is used by things like mbus and LCD

Now, pll5 says

-----8<------
The PLL5 output for DDR = (24MHz*N*K)/M. <-- we call this pll5_ddr
The PLL5 output for other module =(24MHz*N*K)/P. <-- we call this pll5_other
-----8<------

There does not seem to be anything connected to "pll5" with a rate of
24MHz*N*K, but personally I would not be opposed to adding it to the
DT for consistency with pll6. After all, it actually is the common
ancestor of pll5_ddr and pll5_other.

There's also some ASCII art on the code to visualize these clocks better

http://git.linaro.org/people/mike.turquette/linux.git/blob/refs/heads/clk-next:/drivers/clk/sunxi/clk-sunxi.c#l842

I hope this clarifies things.

Cheers,

Emilio
