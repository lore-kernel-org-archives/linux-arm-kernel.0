From: holler@ahsoftware.de (Alexander Holler)
Date: Wed, 26 Aug 2015 14:28:12 +0200
Subject: [PATCH 00/16] deps: deterministic driver initialization order
Message-ID: <1440592108-3740-1-git-send-email-holler@ahsoftware.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I've already written a lot on that topic, therefor this introductory
mail doesn't explain everything.

Please have a look at the threads

"dt: dependencies (for deterministic driver initialization order based on
the DT)"

and

"On-demand device registration"

on LKML for previous discussions.

In short, the current init system is quiet old and doesn't really match
todays HW which needs much more drivers than 20 years ago.

As I've mentioned in those threads, initcalls should be identifiable
in order to sort them. My previous attempt intercepted the driver
registrations in order to do that, which unfortunately ended up with
having to deal how drivers are creating devices.

I've now spend some more time and this partly new approach now annotates
the initcalls directly, by storing a pointer to a struct device_driver in
addition to the pointer to the initcall.

This makes my previous patches smaller, cleaner and better to understand,
the result which you can see in this little patch series.

The whole patch series is made up of several parts.

The first 4 patches are modifying dtc to include dependencies (type
information for phandles).

The next 3 patches are the ones which are implementing those annotated
initcalls and the driver sort algorithm.

Then there are 3 patches with small changes on some dts.

The following 4 patches with the WIP (Work In Progress) are changing
some initcalls to annotated initcalls. I would split them up in
a bunch of patches (one for each driver), if I get the promise that
the other patches will be merged into mainline (but not without that
promise).

The final 2 patches are fixes which should end up in mainline, regardless
if this feature is merged or not.

Some numbers (5 boots on each board, without and with ordering drivers),
all times are seconds.

Kirkwood (dockstar, armv5):

Boot to "Freeing unused kernel memory" (includes mounting the rootfs),
unordered:
4.456016 3.937801 4.114788 4.114526 3.949480 (average 4.1145222)
ordered:
3.173054 3.164045 3.141418 3.480679 3.459298 (3.2836988)
Time needed to sort (of_init_build_order()):
0.003024
Time needed to match drivers to the order (without calling them):
0.002884

Beagleboard (rev C4, armv7):

unordered:
6.706024 6.821746 6.696014 6.673675 6.769866 (6.733465)
ordered:
5.544860 5.514160 5.505859 5.527374 5.496795 (5.5178096)
sorting: 0.021209
matching: 0.006165

Beaglebone Black (rev A5, armv7):

unordered:
3.826531 3.825662 3.826648 3.825434 3.825263 (3.8259076)
ordered:
2.838554 2.838322 2.839459 2.838467 2.838421 (2.8386446)
sorting: 0.004769
matching: 0.004860

imx6q (armv7):

unordered:
3.451998 3.418864 3.446952 3.429974 3.440996 (3.4377568)
ordered:
3.538312 3.549019 3.538105 3.515916 3.555715 (3.5394134)
sorting: 0.004622
matching: 0.003868


Because I'm using different configuration options on these boards,
the absolute times aren't comparable.

But in conclusion, most boards are booting faster when the initcalls
have been ordered.

In addition, ordering the initcalls makes the initialization sequence
more deterministic (it can even be seen without booting a machine).

But I still think the most benefit of these little series is by not having
to use in-driver hacks or that ugly brute force trial-and-error deferred
probing in order to fix a wrong default call order of initcalls.

Further improvements could be to initialize drivers in parallel (using
multiple cores) and/or to use this stuff on x86 (ACPI) too (e.g. by using a
minimal DT which just includes dependencies).


To test this series with any other DT enabled board, look at which
drivers are referenced in the DT (see patch 2 or 3), annotate these
drivers (trivial, see patch 5 or the examples with WIP in the subject),
turn on CONFIG_OF_DEPENDENCIES, compile and boot.


Just to mention it, unless CONFIG_OF_DEPENDENCIES is turned on (which is
marked as experimental), nothing will change, even if you've annotated
some drivers (the new macros will just map to the old ones).


Regards,

Alexander Holler

PS: Please keep in mind that these patches are an offer. I'm already
100+ patches above mainline and don't really care to maintain some more
for myself.
