From: dron0gus@gmail.com (Dron Gus)
Date: Tue, 9 Nov 2010 18:57:02 +0300
Subject: S3C2416 clock tree
Message-ID: <AANLkTi=H7n5tfPQkPvOhD4sUvHWYLuQBnhe64o=tkz+t@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I work with custom board based on s3c2416 SoC. I'm trying to make
cpufreq work. I wrote the driver based on cpu-freq.c from
mach-s3c2410.
On kernel start i get error message:
cpufreq: failed to get clock 'armclk'
s3c2416_cpufreq_add: failed to get clocks
So i have to add dummy 'armclk' and some dummy clk_ops functions.
Now cpufreq starts, and tries to change freqs, calling to my
s3c2416_cpufreq_calcdivs. But the problem is that it passes wrong fclk
value. Pll rums on 800 MHz, armclk = 400 MHz, hclk = 133, pclk = 66. I
get fclk = 400 MHz. It is two time smaller than mpll.
I can not understood is value of fclk the same as armclk or as mpll?
To count correct armclk divider i must know mpll freq. But as i see in
s3c2443_common_setup_clocks and in s3c24xx_setup_clocks, mpll rate is
set the same as fclk, but fclk = pll / get_fdiv(clkdiv0);
So there is three ways to solve this problem, as i see:
1) pass one more argument to s3c24xx_setup_clocks with value of mpll.
This will break to many mach-s3c****
2) write get_rate for mpll clock and set mpll as a parent for fclk.
Problem is that PLLs are diferent on diferent s3c SoCs.
3) the same as 2, but use function get_mpll, wich is passed to
s3c2443_common_setup_clocks.

Witch way is preferred?

Thanks.

Andrey.
