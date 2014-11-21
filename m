From: dianders@chromium.org (Doug Anderson)
Date: Fri, 21 Nov 2014 13:04:03 -0800
Subject: [PATCH] mmc: dw_mmc: try pick the exact same voltage as vmmc for
 vqmmc
In-Reply-To: <CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>
References: <1415109789-7046-1-git-send-email-addy.ke@rock-chips.com>
 <1415678573-6093-1-git-send-email-addy.ke@rock-chips.com>
 <CAPDyKFqUoBjhsbz8rkLa9PY_dpgMxnimz3k7OoA5WVhi7MacPQ@mail.gmail.com>
 <CAD=FV=VQHZ6YmcoeAb1OEVLYRrYBnc_dM5Kjt1TZX_CQJC=EfA@mail.gmail.com>
 <5464152E.7040209@rock-chips.com>
 <CAPDyKFrzGfDew0eLLEcA+_iS_mo-O2bFU58fjirfXXA8AJ9UYQ@mail.gmail.com>
 <CAD=FV=Ve1TY4+8quq1=18A1YOFvOWuFGrBmHLwMCwdWBSqzxOw@mail.gmail.com>
Message-ID: <CAD=FV=UJT5zBkcj2a03Y_RWxad9+Pu83G_z79Xzzn74V=eRqww@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Nov 21, 2014 at 9:42 AM, Doug Anderson <dianders@chromium.org> wrote:
> Ulf,
>
> On Fri, Nov 21, 2014 at 4:06 AM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
>> [...]
>>
>>> Sure
>>> If the first card is sd2.0 since startup, dw_mci_switch_voltage will not be called,
>>
>> That can't be right. mmc_power_up() should trigger
>> dw_mci_switch_voltage() to be invoked.
>
> Hmmm, I think you're right.  Addy: can you double check if it's only
> the 2nd card for you?  I was thinking that if a regulator is currently
> 3.3V and you request 2.7 - 3.3V the regulator framework will treat
> that as a noop.  ...but that definitely doesn't appear to be the case.
> When I boot up the first time even with no SD card plugged in, I see
> this at bootup:
>
> [    3.042234] vccio_sd: 1800 <--> 3300 mV at 3300 mV
>
> ...showing that it started at 3.3V.  Then I see:
>
> $ grep "" /sys/class/regulator/regulator.16/{name,microvolts}
> /sys/class/regulator/regulator.16/name:vccio_sd
> /sys/class/regulator/regulator.16/microvolts:2700000
>
> ...so it is certainly getting changed even with no card plugged in.
>
>
> BTW: I don't actually have one of these failing cards--all of mine
> work.  Addy, do you know the make and model of the card you have that
> fails?

Just as a bit of a followup, I did some more digging...

1. It looks as if we now have a bit of "opposite" logic for vmmc vs.
vqmmc.  In mmc_power_up() I see that it sets the initial voltage as:

  host->ios.vdd = fls(ocr) - 1;

That actually means that we're going to pick the maximum voltage for
vmmc (of the supported voltages).  For vqmmc dw_mmc is using the
regulator framework which (as described in my previous message) will
pick the minimum.

2. Several people I've talked to have expressed concerns that our
minimum value is 2.7V.  Apparently that's really on the edge and makes
EEs a little nervous.  The quick sample of cards sitting on my desk
shows that they seem to claim 0x00ff8000, which doesn't include 2.7V.


Both of the above make me feel like dw_mmc should try its best to pick
a value for vqmmc that is closest to the value of vmmc (and >= 2.7V).
That also happens to make us work exactly like hosts where vmmc and
vqmmc are supplied by the same supply.


-Doug
