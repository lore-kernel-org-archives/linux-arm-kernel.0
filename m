From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Thu, 03 Dec 2015 15:00:33 +0100
Subject: [PATCH 3/3] ARM: dts: rockchip: add veyron-minnie board
In-Reply-To: <566020EC.7060606@rock-chips.com>
References: <2767415.mEkgRbSSUB@diego> <3359424.qNn8gsFXpA@diego>
 <566020EC.7060606@rock-chips.com>
Message-ID: <2137537.DBrTyHZKX9@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Caesar, Shawn,

Am Donnerstag, 3. Dezember 2015, 19:01:00 schrieb Caesar Wang:
> ? 2015?12?03? 18:44, Heiko St?bner ??:
> > Am Donnerstag, 3. Dezember 2015, 18:27:27 schrieb Caesar Wang:
> >> .....but,
> >> reboot long long test, that's seem mmc tune has a issue.
> >> 
> >>     2.630892] mmcblk0: error -84 transferring data, sector 0, nr 8, cmd
> >> 
> >> response 0x900, card status 0x0
> >> [    2.631006] mmcblk0: error -110 sending status command, retrying
> >> [    2.631018] mmcblk0: error -84 transferring data, sector 1, nr 7, cmd
> >> response 0x900, card status 0x0
> >> [    2.631703]  mmcblk0: unable to read partition table
> >> ...
> > 
> > Could you try if what we do on Minnie fixes that error (disabling tuning
> > for now) - i.e. adding the following to the Mickey dts:
> > 
> > &emmc {
> > 
> > 	/delete-property/mmc-hs200-1_8v;
> > 
> > };
> 
> Yep, maybe we remove this node firstly but someone fix the emmc tune issues.

yep, that is definitly the plan. I've now also done more than a dozen reboot 
tests on my brain board including running hdparm-speedtests on the emmc there. 
Tuning and all reads did run without any hickups, so this really seems to be 
somehow limited.


> >> Anyway, the dts is good to support mickey machine.
> >> I think the mmc tune is not prefect in mainline.
> > 
> > yeah, it seems we still have some issues.
> > 
> > Although it seems only the disney-mice seem affected ;-) [minnie and
> > mickey]. Pinky, Brain, Speedy, Jaq all seem to work somehow - at least I
> > haven't gotten any reports about that
> 
> Cc shawn,
> Maybe,  Shawn at RK has the interesting in debuging this issue.:-)

Strangely on the ChromeOS kernel tuning on Minnie seems to work ok. I already 
checked the code somewhat and the core handling seems to be the same - like 
the phase clocks and the tuning algorithm.

The only slight difference is that mainline is using mmc_send_tuning() instead 
of building the packet by hand.

But at least on my Minnie the phases the emmc gets tuned to are always 
differing somehow: (mainline: 216-218, chromeos: 198-201) while on my jerry 
the variance is not as big (mainline 176, chromeos: 172).


Some more comparisons I did on Minnie:
sdmmc: phase 197 on both mainline and chromeos
wifi: around phase 214 on mainline and 204 on chromeos

So at least the sdmmc host seems pretty stable in its phase and the difference 
on wifi is smaller than with the emmc - not sure if that helps though :-)


I'll also try to look more into that issue, but would be glad to hear other 
bright ideas :-)


Thanks
Heiko
