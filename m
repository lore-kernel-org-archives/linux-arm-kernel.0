From: myungjoo.ham@samsung.com (MyungJoo Ham)
Date: Tue, 17 Jan 2012 11:00:54 +0900
Subject: [PATCH] watchdog: fix error in probe() of s3c2410_wdt (reset at
 booting)
In-Reply-To: <20120113214555.GA19495@infomag.iguana.be>
References: <1326431663-4638-1-git-send-email-myungjoo.ham@samsung.com>
 <20120113111117.GT1068@n2100.arm.linux.org.uk>
 <20120113214555.GA19495@infomag.iguana.be>
Message-ID: <CAJ0PZbSpL0-LNHfU7TTM06tPi1B4VgCp=oyPA06qAjp8PoPT2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 14, 2012 at 6:45 AM, Wim Van Sebroeck <wim@iguana.be> wrote:
> Hi,
>
> On Fri, Jan 13, 2012 at 11:11:17AM +0000, Russell King - ARM Linux wrote:
>
>> On Fri, Jan 13, 2012 at 02:14:23PM +0900, MyungJoo Ham wrote:
>> > Probe function of s3c2410 watchdog calls request_irq before initializing
>> > required value (wdt_count). This incurs resetting watchdog counter value
>> > and watchdog-reboot during booting up.
>> >
>> > This patch addresses such an issue by calling request_irq later.
>> >
>> > Error handling in probe function and calling oder in remove function are
>> > also revised accordingly.
>>
>> On the other hand, this patch violates the general principle that you set
>> the device up _before_ you publish it to userspace.
>>
>> In the case where you add the watchdog device, but then the subsequent
>> request_irq() fails, there is a window where the watchdog device could
>> be opened and started. ?You then fall out through the error paths, and
>> the module could be removed.
>>
>> Don't do this. ?Always setup the device first. ?Then publish it. ?Never
>> the other way around.
>
> Russell was faster in replying, but I would have given the same NAK:
> the registering of the watchdog means that userspace get access/control over
> the watchdog device. So the request_irq should be done before that.
>
> In your trouble description you wrote: "Probe function of s3c2410 watchdog
> calls request_irq before initializing required value (wdt_count)."
> Should we not fix the initialization of the wdt_count value instead of the
> request_irq? i will have a look at the code somewhere this weekend.
>
> Mvg,
> Wim.
>

Yes, if we set wdt_count value properly before request_irq, it's fine.

Anyway, as registering the device (watchdog_register_device()) may be
done after request_irq without any problem, moving request_irq right
before it, not after it should be fine.

Thank you.



Cheers!
MyungJoo.

-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab, DMC Business, Samsung Electronics
