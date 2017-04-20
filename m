From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Thu, 20 Apr 2017 09:46:46 +0200
Subject: usb: dwc2: NMI watchdog: BUG: soft lockup - CPU#0 stuck for 146s
In-Reply-To: <CAD=FV=UShTqx3JjijEZSayA4HtFzztye6rotsJubtoiYxxMC=g@mail.gmail.com>
References: <1795308650.27171.9a53158f-312d-40ce-80ce-8bf792d8db34.open-xchange@email.1und1.de>
 <172093673.40121.1492427140661@email.1und1.de>
 <CAD=FV=WJBTUcMPw8OgQT_jhz0H8AsH=YqWMR7LtudUKrF5-XOA@mail.gmail.com>
 <79b9b35b-0600-771f-4cd2-9e03c5ba3a25@i2se.com>
 <186569458.91967.1492547106553@email.1und1.de>
 <CAD=FV=VHkJFrsJDmMytbUw=WjKQaGZ-8Ewfy5bPCA82AWS4O2Q@mail.gmail.com>
 <212870399.174480.1492633502649@email.1und1.de>
 <CAD=FV=UShTqx3JjijEZSayA4HtFzztye6rotsJubtoiYxxMC=g@mail.gmail.com>
Message-ID: <e141d7fb-7ec8-805e-d2f2-f1892b76d00e@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 19.04.2017 um 23:47 schrieb Doug Anderson:
> Hi,
>
> On Wed, Apr 19, 2017 at 1:25 PM, Stefan Wahren <stefan.wahren@i2se.com> wrote:
>> Hi,
>>
>>> Doug Anderson <dianders@chromium.org> hat am 18. April 2017 um 22:41 geschrieben:
>>>
>>>
>>> It's hard to know for sure that all of this time is really in
>>> urb_enqueue().  Possible we could have task switched out and been
>>> blocked elsewhere.  Using ftrace to get more fine-grained timings
>>> would be useful.  ktime_get(), ktime_sub(), and ktime_to_us() are your
>>> friends here if you want to use trace_printk.
>> i'm a newbie to ftrace, so i hope this would be helpful.
>>
>> # connect PL2303 to the onboard hub
>> # echo 0 > options/sleep-time
>> # echo 0 > function_profile_enabled
>> # echo 1 > function_profile_enabled
>> # ./usb_test
>> # Waiting for at least 20 seconds and then disconnect PL2303
>> # echo 0 > function_profile_enabled
>> # cat trace_stat/function0
>>
>>   Function                               Hit    Time            Avg             s^2
>>   --------                               ---    ----            ---             ---
>>   bcm2835_handle_irq                  361347    219567633 us     607.636 us      1485199 us
>>   __handle_domain_irq                1082482    212639551 us     196.437 us      3642030 us
>>   generic_handle_irq                 1082482    100592051 us     92.927 us       50511334 us
>>   irq_exit                           1082482    98197771 us     90.715 us       29649040 us
>>   handle_level_irq                   1082482    95812379 us     88.511 us       51910093 us
>>   do_sys_open                           1806    87612983 us     48512.17 us     2198507 us
>>   SyS_open                              1601    87372331 us     54573.59 us     1898996 us
>>   do_filp_open                          1862    87368058 us     46921.62 us     1634982 us
>>   path_openat                           1862    87314553 us     46892.88 us     3357817 us
>>   __do_softirq                          3035    86266050 us     28423.73 us     6449768 us
>>   vfs_open                              1515    85877012 us     56684.49 us     101673.5 us
>>   do_dentry_open                        1515    85861429 us     56674.21 us     812420.7 us
>>   usb_submit_urb                         136    85760172 us     630589.5 us     59532024 us
>>   usb_hcd_submit_urb                     134    85756518 us     639974.0 us     726298102 us
>>   _dwc2_hcd_urb_enqueue                  134    85738333 us     639838.3 us     874104371 us
> The 134 calls to this are taking a ton of time.  It would be nice to
> know where all the time actually was in here.  Are you on a
> single-core device, or multi-core?

Raspberry Pi B is a single core device which runs with 700 MHz cpu freq.

> Oh, probably this so slow because we're just getting interrupted
> constantly.  You can see that during your trace 80686112 us was in
> handle_irq_event().  Presumably all of that time could have been
> counted towards whatever code you were in when the interrupt went off.
> Of that 80 seconds, 60 seconds or so was usb_hcd_irq, and of that 57
> seconds was in _dwc2_hcd_irq().

Since the FTDI (full speed device) and the PL2303 (also full speed
device) behaves differently, i will try to compare those ftraces.

>
> Presumably the big part of your problem is that dwc2_handle_hcd_intr()
> is just too slow.  From glancing at the numbers below, it seems likely
> that nothing in particular is slow, it's just running a lot of code
> and (in total) all of that is slow.  ...but someone with more time on
> their hands would need to really debug.
>
> One thing that would be interesting would be to see if you can
> increase the bug clock for talking to the dwc2 controller.  

Unfortunately the bcm2835 datasheet [1] doesn't provide many information
about the USB IP core and the Synopsys documents aren't public
available. The Raspberry Pi Foundation decided to use a different driver
which uses FIQ in the downstream tree [2], but this won't be an option here.

Maybe i could start with comparing the register settings between dwc2
and dwc_otg.

[1] -
https://www.raspberrypi.org/app/uploads/2012/02/BCM2835-ARM-Peripherals.pdf
[2] -
https://github.com/raspberrypi/linux/commit/65165df02f2ba9feccebf45d8c732dffb34b6109

> Possibly
> some of those memory mapped IOs talking to dwc2 could be making
> everything slow?
>
> Other than that, maybe you can find some way to optimize the code in
> dwc2 so it runs faster, at least in the cases you care about...
>
