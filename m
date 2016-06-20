From: groeck@google.com (Guenter Roeck)
Date: Mon, 20 Jun 2016 12:38:27 -0700
Subject: [PATCH v3 05/15] phy: rockchip-emmc: Increase lock time allowance
In-Reply-To: <CAD=FV=XTk_mY3oJaJX8sUnUzvNf3z8PtjanKJ1a8oWKDi7TwSQ@mail.gmail.com>
References: <1466445414-11974-1-git-send-email-dianders@chromium.org>
 <1466445414-11974-6-git-send-email-dianders@chromium.org>
 <CABXOdTeO8--Rk2k8tk62uiPa6T=ZoDZjBQwMHyWpNBwJo2pinA@mail.gmail.com>
 <CAD=FV=XTk_mY3oJaJX8sUnUzvNf3z8PtjanKJ1a8oWKDi7TwSQ@mail.gmail.com>
Message-ID: <CABXOdTe7ryiEU48FPZ6N48gbC84b1iU5G8ihRY=-c5sWBxLEQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 12:36 PM, Doug Anderson <dianders@chromium.org> wrote:
> Hi,
>
> On Mon, Jun 20, 2016 at 12:29 PM, Guenter Roeck <groeck@google.com> wrote:
>> On Mon, Jun 20, 2016 at 10:56 AM, Douglas Anderson
>> <dianders@chromium.org> wrote:
>>> Previous PHY code waited a fixed amount of time for the DLL to lock at
>>> power on time.  Unfortunately, the time for the DLL to lock is actually
>>> a bit more dynamic and can be longer if the card clock is slower.
>>>
>>> Instead of waiting a fixed 30 us, let's now dynamically wait until the
>>> lock bit gets set.  We'll wait up to 10 ms which should be OK even if
>>> the card clock is at the super slow 100 kHz.
>>>
>>
>> 10 ms active delay (no sleep) is actually quite long. Can this code sleep ?
>
> It is expected that in nearly all cases it will be much shorter than
> 10ms.  The longest expected (at 400kHz) is 1.3 ms and we should only
> be probing down to 300, 200, 100 kHz if we are having trouble
> communicating.  When running at a normal speed (50 MHz, 100 MHz, etc)
> it should be much smaller and closer to 10 us or less.  We could still
> try to sleep in some of these cases, but IMHO the extra code
> complexity for something like this that should happen very
> infrequently (only at bootup or if we decide to re-tune) is probably
> not worth it.  Also note that at boot eMMC is (probably) on the
> critical path, so there may be some boot speed benefits to continuing
> as quickly as possible.
>

Makes sense.

Thanks,
Guenter
