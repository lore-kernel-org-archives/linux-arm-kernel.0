From: khilman@kernel.org (Kevin Hilman)
Date: Mon, 03 Nov 2014 10:23:05 -0800
Subject: [PATCH 03/12] PM / Domains: Add notifier support for power domain
 transitions
In-Reply-To: <1651173.5xzCFxz3LI@vostro.rjw.lan> (Rafael J. Wysocki's message
 of "Mon, 03 Nov 2014 15:54:05 +0100")
References: <1414986790-11940-1-git-send-email-amit.daniel@samsung.com>
 <1414986790-11940-4-git-send-email-amit.daniel@samsung.com>
 <1651173.5xzCFxz3LI@vostro.rjw.lan>
Message-ID: <7hmw88gn3q.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

+Mike Turquette

Hi Amit,

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> CC: Kevin, Ulf, Geert.
>
> On Monday, November 03, 2014 09:23:01 AM Amit Daniel Kachhap wrote:
>> These power domain transition notifiers will assist in carrying
>> out some activity associated with domain power on/off such as
>> some registers which may lose its contents and need save/restore
>> across domain power off/on.

The runtime PM framework already provides callbacks that are useful for
context save/restore for devices.  Could you please describe in more
detail which registers in which kind of devices need to be
saved/restored, and why they cannot be saved/restored using existing
mechanisms.

Personally, I'm uncomfortable with notifiers like this because it
suggests that underlying frameworks are not doing the right thing, or
are not being used.  (I also don't like the implementation here where a
single global notifier list is maintained by the core, but the notifiers
are actually triggered by SoC specific code.)

IIUC, the usage in this series seems to be that certain clock related
registers need to be saved/restored across a power domain transition.

Wouldn't an alternative solution be to add a feature to the clock driver
such that the state of each clock is saved when the clock is disabled,
and restored when the clock is enabled?   That would allow any clock
context to survive any power domain transtion also, correct?

I have some issues with the implementaion as well, but I think we need
to first sort out the real need for this before going into those
details.

Kevin
