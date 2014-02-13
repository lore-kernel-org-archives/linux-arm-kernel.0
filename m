From: Anson.Huang@freescale.com (Anson.Huang at freescale.com)
Date: Thu, 13 Feb 2014 23:39:05 +0000
Subject: [PATCH] thermal: imx: update formula for thermal sensor
In-Reply-To: <CA+gwMccQPxxi2N8wTb4ggK2LaaZk1vOS6RtnP_XfpgLgJyYrtw@mail.gmail.com>
References: <1392199595-1054-1-git-send-email-b20788@freescale.com>
 <20140213130252.GB20842@S2101-09.ap.freescale.net>,
 <CA+gwMccQPxxi2N8wTb4ggK2LaaZk1vOS6RtnP_XfpgLgJyYrtw@mail.gmail.com>
Message-ID: <74FD66EE-8055-40FA-8692-E2DA0F1E643B@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, philipp
        I know your concern, but from hardware team, they said due to the calibration tool's limitation, the high point calibration data is not reliable even the fuse data is there.  If so, then comparing to old formula is not making sense, we should read the temperature in an oven and compare the oven environment's temperature to the result read from thermal sensor using new formula.

We have done the test, and this new formula is included in our BSP release already.

Sent from Anson's iPhone

> ? 2014?2?14??3:09?"Philipp Zabel" <philipp.zabel@gmail.com> ???
> 
> Hi,
> 
>> On Thu, Feb 13, 2014 at 2:02 PM, Shawn Guo <shawn.guo@linaro.org> wrote:
>> 
>> Copy LAKML and pengutronix folks in case they have comments.
>> 
>>> On Wed, Feb 12, 2014 at 06:06:35PM +0800, Anson Huang wrote:
>>> Thermal sensor used to need two calibration points which are
>>> in fuse map to get a slope for converting thermal sensor's raw
>>> data to real temperature in degree C. Due to the chip calibration
>>> limitation, hardware team provides an universal formula to get
>>> real temperature from internal thermal sensor raw data:
>>> 
>>> Slope = 0.4297157 - (0.0015976 * 25C fuse);
> 
> I have an i.MX6Q 1.2 with 1417 counts at 25?C and 1296 counts at 105?C fused.
> Assuming that those values are fused correctly, with the old formula I get:
> 
> t1=25, n1=1417, t2=105, n2=1296
> c1=1000*(t1-t2)/(n1-n2)=-662, c2=1000*t2-c1*n2=962952
> T_meas=c2+c1*N_meas=962952-662*N_meas
> 
> N_meas=1417 --> T_meas = 24898
> N_meas=1296 --> T_meas = 105000
> 
> With the new formula, on the other hand, I would get:
> 
> t1=25, n1=1417
> F0=10000000, F1=15976, 4297157
> c1=F0*1000/(F1*n1-F2)=545, c2=n1*c1+1000*25=797265
> T_meas=c2-N_meas*c1=797265-N_meas*545
> 
> N_meas=1417 --> T_meas = 25000
> N_meas=1296 --> T_meas = 90945
> 
> That's off by over 14?C!
> 
> The default passive cooling trip point is at 85?C,
> which translated to 1326 counts before:
> alarm_value=(alarm_temp-c2)/c1=(85000-962952)/(-662)=1326
> 
> With the new formula the trip count is only
> alarm_value=(c2-alarm_temp)/c1=(797265-85000)/545=1306
> That translates to 98.4?C according to the old formula. I think
> that is awfully close to the critical trip point at 100?C, which,
> according to the old formula, corresponded to 1303 counts.
> 
> The new critical trip point for 100?C is at 1279 counts. According
> to the old formula this corresponds to 116.2?C, well over the
> rated maximum of 105?C.
> 
> Do I need to be afraid for my old silicon?
> 
>>> Update the formula, as there will be no hot point calibration
>>> data in fuse map from now on.
> 
> I wonder if it would be better to keep using the high temperature
> calibration point if it is fused at all.
> 
> regards
> Philipp
> 
> 
