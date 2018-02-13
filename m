From: embed3d@gmail.com (Philipp Rossak)
Date: Tue, 13 Feb 2018 02:25:58 +0100
Subject: BUG: A31s Not booting anymore
In-Reply-To: <e155f7fc-9c22-d8ac-d142-805812aa9988@gmail.com>
References: <e155f7fc-9c22-d8ac-d142-805812aa9988@gmail.com>
Message-ID: <b421fae7-b807-5ed8-669d-6ba773ac3eca@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12.02.2018 19:21, Philipp Rossak wrote:
> Hey,
> 
> When I try to boot my A31s (Bananapi M2) u-boot is showing only Starting 
> kernel ... . After enabling the earlyprintk I could capture this log: [1].
> 
> After reverting those 5 commits from Chen-Yu I was able to boot again:
> 
> 
> clk: sunxi-ng: Support fixed post-dividers on NM style clocks
> 7d333ef1cc1b8c8951f3a2c41f6406e2295d8be9
> 
> clk: sunxi-ng: sun8i: a83t: Add /2 fixed post divider to audio PLL
> 10e6eb4f2c5b35ae71c9bc0db83d74238719b453
> 
> clk: sunxi-ng: sun8i: a83t: Use sigma-delta modulation for audio PLL
> e952ca3c6b2ffdfbf9618e4bd3e9aad1ff3f5eb4
> 
> clk: sunxi-ng: Support fixed post-dividers on MP style clocks
> 946797aa3f08e2f6f5992f3ec2be44791e9b9260
> 
> clk: sunxi-ng: sun50i: a64: Add 2x fixed post-divider to MMC module clocks
> 83fe3be4d1974f5f50c5e2039a1609f4960e8579
> 
> 
> I allready tried to fix it with making them save against zero:
> 
> if (cmp->common.features & CCU_FEATURE_FIXED_POSTDIV && \
>  ??????? cmp->fixed_post_div with)
>  ?????????????? rate *= cmp->fixed_post_div;
> 
> But that didn't help.
> 
> Any ideas?
> 
> Regards,
> Philipp
> 
> [1]: https://pastebin.com/64Fzzqvg

It took me some time, but I have now a few more infos:

Right now the code breaks at this point here [1], with this clock [2].
If we have a look now at the clock config [3], we see here a table which 
is an u8 array and also a fixed_predivs struct.

If we have a look at the function call where it breaks [4], shouldn't 
the table be a clk_div_table struct instead of an u8?

The a31s is the only board where we have this combination of a 
fixed_predivs and a table.

Philipp


Related Clock source register A31s:

0000: OSC24MHz/750=32KHz
0001: LOSC
0010: OSC24MHz
0011: /
0100: /
0101: /
0110: /
0111: /
1000: /
1001: /
1010: /
1011: AXICLK/4
1100: /
1101: AHB1CLK/4
1110: /
1111: /


[1]: 
http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/clk-divider.c#L89

[2]: 
http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/sunxi-ng/ccu-sun6i-a31.c#L1137

[3]: 
http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/sunxi-ng/ccu-sun6i-a31.c#L749

[4]: 
http://lxr.bootlin.com/linux/v4.16-rc1/source/drivers/clk/clk-divider.c#L93
