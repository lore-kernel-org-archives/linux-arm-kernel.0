From: dianders@chromium.org (Doug Anderson)
Date: Mon, 23 Jun 2014 15:27:50 -0700
Subject: [PATCH] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
In-Reply-To: <7ha993p8v4.fsf@paris.lan>
References: <1403155273-1057-1-git-send-email-dianders@chromium.org>
 <7h8uosyc3k.fsf@paris.lan>
 <CAD=FV=XxNVmF+N5HF4SnZoJRJvkSUkpEx6ct4v2gtmAQ9n28-Q@mail.gmail.com>
 <7hwqcbs166.fsf@paris.lan>
 <CAD=FV=Uz9O0i2gmuk2+BHa-Tksvyxv0+MTi2UEjVREAMNCK7Ug@mail.gmail.com>
 <7h7g4brx6w.fsf@paris.lan>
 <CAD=FV=VmPMf6tCNmKJ1o5J7PyAXoU8fb6+s+Fkv18FH2WaQp7A@mail.gmail.com>
 <53A4CADA.4030002@gmail.com>
 <CAD=FV=VkxA01eEFiXSp+c+GDuVJi7TctAdnyrMggk1gRw6BStQ@mail.gmail.com>
 <7ha993p8v4.fsf@paris.lan>
Message-ID: <CAD=FV=U0P2kyfnxdU2E1Gm8TdD_cFd6brmtQ7-gpajNJuKmWSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin,

On Mon, Jun 23, 2014 at 3:19 PM, Kevin Hilman <khilman@linaro.org> wrote:
> Doug Anderson <dianders@chromium.org> writes:
>
> [...]
>
>> On Fri, Jun 20, 2014 at 4:59 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
>>>
>>> I'm not sure noirq is going to work correctly, at least not with current
>>> callbacks. I can see a call to clk_prepare_enable() there which needs to
>>> acquire a mutex.
>>
>> Nice catch, thanks!  :)
>>
>> OK, looking at that now.  Interestingly this doesn't seem to cause us
>> problems in our ChromeOS 3.8 tree.  I just tried enabling:
>>   CONFIG_DEBUG_ATOMIC_SLEEP=y
>>
>> ...and confirmed that I got it on right:
>>
>> # zgrep -i atomic /proc/config.gz
>> CONFIG_DEBUG_ATOMIC_SLEEP=y
>>
>> I can suspend/resume with no problems.  My bet is that it works fine because:
>>
>> * resume_noirq is not considered "atomic" in the sense enforced by
>> CONFIG_DEBUG_ATOMIC_SLEEP (at least not in 3.8--I haven't tried on
>> ToT)
>
> The reason is because "noirq" in the suspend/resume path actually means
> no *device* IRQs for that specific device.
>
> It's often assumed that the "noirq" callbacks are called with *all*
> interrupts disabled, but that's not the case.  Only the IRQs for that
> specific device are disabled when its noirq callbacks run.

Ah, so even with my fix of moving to noirq we could still be broken if
the system decided to enable interrupts for the device before the i2c
controller get resumed then we'd still be SOL.

...oh, but if it matches probe order then maybe we're guaranteed for
that not to happen?  We know that we will probe the i2c bus before the
devices on it, right?

-Doug
