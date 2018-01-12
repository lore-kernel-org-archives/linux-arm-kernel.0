From: olof@lixom.net (Olof Johansson)
Date: Fri, 12 Jan 2018 10:14:13 -0800
Subject: [GIT PULL] TI DaVinci SoC updates for v4.16 (part 2)
In-Reply-To: <8a0bd7f2-c3a9-1322-a567-7a9ffdaf69d8@ti.com>
References: <20180110112505.13633-1-nsekhar@ti.com>
 <20180112013602.q2sm25s6o3oebkbj@localhost>
 <db68cbec-a3e2-9c9e-e09c-f3d9a9972636@lechnology.com>
 <8a0bd7f2-c3a9-1322-a567-7a9ffdaf69d8@ti.com>
Message-ID: <CAOesGMgzeoYQZ1cDE3hJH6RAKcVv0=nA8u0vqFCvTPzbE2vLag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 11, 2018 at 9:47 PM, Sekhar Nori <nsekhar@ti.com> wrote:
> Hi Olof,
>
> On Friday 12 January 2018 08:06 AM, David Lechner wrote:
>> On 01/11/2018 07:36 PM, Olof Johansson wrote:
>>> On Wed, Jan 10, 2018 at 04:55:05PM +0530, Sekhar Nori wrote:
>>>> The following changes since commit
>>>> 23bbeaef90ab7607d03428bbb708efe44f43c761:
>>>>
>>>>    ARM: davinci: constify gpio_led (2018-01-05 19:28:41 +0530)
>>>>
>>>> are available in the git repository at:
>>>>
>>>>
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git
>>>> tags/davinci-for-v4.16/soc-p2
>>>>
>>>> for you to fetch changes up to 0808d3260456aaba061fe06ead31d578c8bdc936:
>>>>
>>>>    ARM: davinci: remove watchdog reset (2018-01-10 14:38:07 +0530)
>>>>
>>>> ----------------------------------------------------------------
>>>> A patch to shift to using watchdog timer for DaVinci restart
>>>> functionality.
>>>> The driver support is present in linux-next as 71d1f058844d "watchdog:
>>>> davinci_wdt: add restart function"
>>>
>>> Hi,
>>>
>>> So if this is merged before the driver is merged, what happens?
>>
>> Then reboot hangs.
>
> Yes. I did request[1] an immutable branch with just the driver change
> applied, but looks like the message was lost and the current driver
> change is applied over many other watchdog changes.
>
>>
>>> Might
>>> be better to hold off a release to avoid regressions?
>
> The main reason I sent it out anyway is because this cleanup is a
> dependency to move to common clock framework and I want to reduce those
> to a minimum to have a good chance of migrating to it in v4.17.
>
> If the watchdog driver change never makes it (very low chance), then I
> can resend a revert for -rc2. If ARM-SoC is merged before watchdog, yes,
> during a short while in merge window reboot will be broken. But I
> figured its a risk worth taking to have a chance of getting this into v4.16.
>
> If you have a "send these late" branch, it will be nice to put it in
> there. If this is too much uncertainty, then okay, lets hold for v4.17.

Keep in mind that while the tree might regress for a period of time,
what's really awkward is that bisection will be hard across this,
since for some states of the tree you will have the platform-side
change but not the watchdog change. That's really one of the main
reasons for having a stable branch that can be used as a base -- you
can then not hit that case.

One option is to make a base branch that contains this code that's
used for the base of the CCF work that is based on 4.16-rc1 once it is
out. What trees to do you expect to have CCF code going through? Clock
and arm-soc, any others? If it's just those two we can deal with that,
if it's more trees than that it might get complicated still.


-Olof
