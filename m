From: wdc@rock-chips.com (David.Wu)
Date: Fri, 15 Jan 2016 17:39:13 +0800
Subject: [PATCH v3 3/4] i2c: rk3x: new method to calculate i2c clocks
In-Reply-To: <CAD=FV=UXMzEQiKcMa7VjDx+arcbRo1e-0HPHBnG8GP7k6uFt1g@mail.gmail.com>
References: <1452774699-57455-1-git-send-email-david.wu@rock-chips.com>
 <1452774699-57455-4-git-send-email-david.wu@rock-chips.com>
 <CAD=FV=UXMzEQiKcMa7VjDx+arcbRo1e-0HPHBnG8GP7k6uFt1g@mail.gmail.com>
Message-ID: <5698BE41.30005@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug?

? 2016/1/15 0:12, Doug Anderson ??:
> Hi,
>
> On Thu, Jan 14, 2016 at 4:31 AM, David Wu <david.wu@rock-chips.com> wrote:
>> There was an timing issue about "repeated start" time at the I2C
>> controller of version0, controller appears to drop SDA at .875x (7/8)
>> programmed clk high. The rule(.875x) isn't enough to meet tSU;STA
>> requirements on 100k's Standard-mode. To resolve this issue,
>> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
>> timing information are added, new rules are designed to calculate
>> the timing information at new v1.
> I'm curious: does new hardware behave differently and that's why you
> need v1?
Yes , i didn't describe clearly about difference between old and new.
Old and new hardware behave the same except some timing rules.

v0 is the same with the v1 for tHigh and tLow :
  tHigh = 8 * divh * pclk_cycle;
  tLow = 8 * divl * pclk_cycle;

v0 rules' difference:
     start setup? 7/8 * tHigh + 1 pclk cycle
     start hold :    2 * ?7/8 * tHigh? - 1 pclk cycle
     stop setup :   7/8 * tHigh + 1 pclk cycle

     data setup:    1/2 tLow - 1 pclk cycle
     data hold :    1/2  tLow + 1  pclk cycle

For 100k's example:
     spec_min_low_ns = 4700;
     spec_min_high_ns = 4000;
     spec_min_setup_start_ns = 4700;

We could calculate the timing info by the rules of v0, and ignore effect 
of the pclk cycle here.
     tSU;sta >=4700;
     tHigh_min = tSU;sta * 8/7 >= 5372ns;
     tHigh_min  = max(tHigh_min, spec_min_high_ns) = 5372ns;

We get the final scl clk rate is 99k(1000000000 / (5372ns + 4700ns)),  
it looks ok for the 100k
Standard mode. But the timing point of repeat start and low time is very 
critical, it is dangerous
to some slave devices which are perhaps not so specified.
So need to give some time margin for them, that would increase the cycle 
time and reduce
the clk rate, the final rate we get may be 97k or 96k.

In fact, we must think about scl rise time and scl fall time, and get 
final clk may be 93k or less.
After that, we get about 7 percent lost at clk rate, it would reduce the 
efficiency of i2c transfer.

In other words, we could say there is a timing issue about "repeat 
start" time when we want
accurate 100k's rate, it is short to meet I2C spec requirements.
3.4M clk rate also has the same issue.

The start_setup count is added to fix this issue, tHigh is not need to 
considered of "repeat start" time.
After divs calculated, the count would be calculated to meet i2c spec.
v1 rule:
start setup? tHigh + 1 pclk cycle
start hold:  [8h * (u + 1) - 1] * T;
  tSU;sto = (8h * p + 1) * T;
---------------------------------------------------------------------------------------------------------------

The data_upd_st is added for the Data set-up time and Data hold time on 
Highspeed mode.
For 1.7M's example on v0:
     tHD;DAT = 1/2 tLow?
     tHD;DAT <= spec_max_data_hold_ns = 150ns
     tLow <= 2 * tHD;DAT <= 300ns;
     tLow >= spec_min_low_ns = 320ns;
According to these, we could not get a value for tLow, need changes for 
the rule: tHD;DAT = 1/2 tLow.

Cut the tLow into eight euqal parts?the range of data_upd_st is 1 ~ 7.
It seems that v1 rule could resolve the issue.
v1 rule:
     tHD;sda = n/8 * tLow;
     tSU;sda = [(8 - n)/8 * tLow;

3.4M clk rate also has the same issue.

>   ...or does old and new hardware behave the same and you're
> just introducing v1 so you don't mess with how old boards are working?
The registers of counts added would not effect old boards.
No matter what values of count was written in regs, that old i2c 
controller didn't care,
it worked by original timing rule.

After picking this patch, pmic-rk818 and touchscreen-gt911 worked well 
on the rk3368 sdk
board which use old method.

>
> >From the description it sounds as if the old code had problems as 100k too...
>
> If the new controller is different, I'd probably reword like the
> following (you'd have to re-wordwrap):
>
> There was an timing issue about "repeated start" time at the I2C
> controller of version0, controller appears to drop SDA at .875x (7/8)
> programmed clk high. On version 1 of the controller, the rule(.875x)
> isn't enough to meet tSU;STA
> requirements on 100k's Standard-mode. To resolve this issue,
> data_upd_st, start_setup_cnt and stop_setup_cnt configs for I2C
> timing information are added, new rules are designed to calculate
> the timing information at new v1.

There was an timing issue about "repeated start" time at the I2C
controller of version0, controller appears to drop SDA at .875x (7/8)
programmed clk high. On version 1 of the controller, the rule(.875x)
isn't enough to meet tSU;STA requirements on 100k's Standard-mode.

To resolve this issue,data_upd_st, start_setup_cnt and stop_setup_cnt
configs for I2C timing information are added, new rules are designed
to calculate the timing information at new v1.

> -Doug
>
>
>
