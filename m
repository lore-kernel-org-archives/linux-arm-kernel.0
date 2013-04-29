From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 29 Apr 2013 14:14:55 +0200
Subject: [PATCH V2 03/12] PM / Domains: Add on-off notifiers
In-Reply-To: <51767DE2.7050203@stericsson.com>
References: <1364487098-10319-1-git-send-email-rickard.andersson@stericsson.com>
 <1364487098-10319-4-git-send-email-rickard.andersson@stericsson.com>
 <3261022.s2M99fPNjC@vostro.rjw.lan>
 <51767DE2.7050203@stericsson.com>
Message-ID: <CACRpkdb+JrnrQgzZ5xdtFDubexNRm2WsrLXv+5zfjN1wdowaNg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 23, 2013 at 2:26 PM, Rickard Andersson
<rickard.andersson@stericsson.com> wrote:
> On 03/31/2013 12:17 AM, Rafael J. Wysocki wrote:
>> On Thursday, March 28, 2013 05:11:29 PM Rickard Andersson wrote:

>>> I believe notifiers are the best solution to the problem of
>>> restoring context early when waking up after sleep.
>>
>> I don't.
>
> Some motivation would be good.
(...)
>> Well, quite frankly, it is hard to say what problem this is supposed to
>> address from your description.  Care to give some more details?
>
> The problem is that some hardware blocks needs to be restored as early as
> possible after leaving the U8500 CPU coupled sleep state ApSleep (APE power
> domain being off).

(APE = Application Processor Environment, on embedded)

I just have this vague feeling that this is one of those embedded SoC
vs desktop things where worlds collide.

Isn't it so that on common x86 (desktop, server, laptop) the context of
the system is saved by some BIOS/ACPI call, and then the ROM
takes you back up with all devices put back into context?

On embedded SoC's we don't have this, all states in the hardware
has to be saved and restored with kernel code.

Then there is a question about whether this shall be done centrally
(there is one piece of code that knows all volatile registers of all
hardware blocks in the system) which is close to what the desktop
BIOS may do, or whether you want to do this in a distributed manner,
so that each driver saves and restores the context of it's particular
hardware.

The suggested mechanism is useful for the latter design pattern,
where drivers know for themselves how to save and restore their
contexts.

Yours,
Linus Walleij
