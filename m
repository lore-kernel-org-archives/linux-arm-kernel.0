From: Jon.Povey@racelogic.co.uk (Jon Povey)
Date: Mon, 16 Jan 2012 09:20:03 +0000
Subject: DaVinci unbanked GPIO IRQs broken
In-Reply-To: <DF0F476B391FA8409C78302C7BA518B63178FB3F@DBDE01.ent.ti.com>
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0BF403D9FD@Cloud.RL.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Nori, Sekhar wrote:
> On Wed, Jan 11, 2012 at 17:17:34, Jon Povey wrote:
>> Unbanked GPIO IRQs (I am on DM365) seem to have been broken
>> by commit aac4dd1dab8acfc244d697473d2a5f4424a5746c, conversion
>> to generic irq chip, leading to an oops from request_irq().

> The root cause indeed seems to be chip_data getting
> overwritten.
>
> I made a patch for it and was able to test that requesting IRQ
> number 44 doesn't oops. Yet to figure out if there is an easy way
> to trigger an unbanked GPIO IRQ on the EVM, so a large part of
> the patch is actually untested. Anyway, can you give this patch
> a shot (hopefully not mailer mangled)? I don't like the fact that
> it increases davinci_soc_info usage, but first lets see if it fixes
> the issue.

gpio_export(n, 1) and using sysfs to set the gpio to output can be
used to test.

Tried quickly rebasing my stuff to 3.2, your patch fixes the oops, but
the interrupt does not trigger. I don't have time to investigate why not
right now, sorry. But I did try reverting the genirq change too, and
the interrupt handler still wasn't called, so maybe something else
broke somewhere, or it could be something needs updating in my board
support.

I tried applying this patch (modulo gpio path change) to my 3.0-rc7
base with the genirq stuff left in.
I still get an oops and backtrace when requesting the irq!

If this is clearer:

3.2 vanilla: oops requesting irq
3.2 + your patch: no oops, isr is not run
3.2 + reverted genirq: no oops, isr is not run

3.0-rc7: oops requesting irq
3.0-rc7 + your patch: oops requesting irq
3.0-rc7 + reverted genirq: no oops, isr works

--
Jon Povey
jon.povey at racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
