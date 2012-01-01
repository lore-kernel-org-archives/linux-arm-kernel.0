From: shijie8@gmail.com (Huang Shijie)
Date: Sun, 1 Jan 2012 10:23:54 -0500
Subject: [PATCH v2] MTD/GPMI bugfix : reset the BCH module when it is not
 MX23
In-Reply-To: <20111231154338.GA27544@pengutronix.de>
References: <1325233646-3343-1-git-send-email-b32955@freescale.com>
 <20111230143658.GA9141@pengutronix.de>
 <4EFE7236.10609@freescale.com>
 <20111231154338.GA27544@pengutronix.de>
Message-ID: <CAMiH66HsFn4+6-whEC6G-qSPda3+3pBzd50i7iHh9Pg9TXHTXw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Dec 31, 2011 at 10:43 AM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> Hi,
>
> On Sat, Dec 31, 2011 at 10:23:50AM +0800, Huang Shijie wrote:
>
>> > On Fri, Dec 30, 2011 at 04:27:26PM +0800, Huang Shijie wrote:
>> >> In MX28, if we do not reset the BCH module. The BCH module may
>> >> becomes unstable when the board reboots for several thousands times.
>> > Do you have more details when and why this happens? What happens on MX23 then?
>> In one customer's 3G router which uses the MX28:
>> [0] NAND boot mode, mount the UBIFS in the NAND partition.
>> [1] We used the gpmi_reset_block(r->bch_regs, true) to init the BCH module.
>> [2] The board will automatically reboot again after it booted by NAND
>> boot mode.
>> [3] After reboot more then thousands times(cost nearly one day), the BCH
>> mode became UNSTABLE,
>> the data read out was not right, so the system could not mount the UBIFS.
>>
>> After we use gpmi_reset_block(r->bch_regs, false) to init the BCH
>> module, the bug never happens.
>
> Yes, I undestood that. I was curious _why_ this happens, for example, because
> of a bug in the rom-code or such. This would then lead to the question if this

This happens because we do NOT follow the right init procedure. The IC
guy told me.
If the BCH was not initialized correctly, it can not guarantees the
data is right.
This is why the mx28 failed.


> can be fixed by some other means. Because currently it looks like this to me:
> If you would do the above scenario of booting 10000 times on a MX23, then BCH
> could enter the same unstable state (can it?). Since we cannot reset BCH due to

For mx23, it should not reset the BCH, this is the right init
procedure for mx23.
But I did not ever boot 10000 times on mx23. I am not sure if it can
fail or not.



> bug 2847, we have a serious problem, because NAND won't work until the next
> power-cycle? I am curious if my assumptions are true and we have a serious
> problem on the MX23.
You can test it if you have time. :)

Happy new year.

Huang Shijie
