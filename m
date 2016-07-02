From: jcm@jonmasters.org (Jon Masters)
Date: Sat, 2 Jul 2016 19:58:00 -0400
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <20160607221809.GP1041@n2100.armlinux.org.uk>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <20160607221809.GP1041@n2100.armlinux.org.uk>
Message-ID: <32b30c50-4712-568e-4044-9f533ca497b2@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell, Jon,

On 06/07/2016 06:18 PM, Russell King - ARM Linux wrote:
> On Tue, Jun 07, 2016 at 05:08:32PM -0400, Jon Mason wrote:
>> Many users (and some applications) are expecting the CPU clock speed to
>> be output in /proc/cpuinfo (as is done in x86, avr32, c6x, tile, parisc,
>> ia64, and xtensa).
> 
> Such as what applications?  This is just another meaningless number,
> which is just as meaningless as the bogomips number.  It tells you
> nothing really about the CPU which should remotely be used for
> anything other than user display.  It certainly can't be used for
> algorithmic selection.

Agreed. HOWEVER...

We'll be coming back to add this for servers soon enough. It's on the
todo, we just need a nice way to extract this information (as has been
discussed). That's likely to be through DMI data or an ACPI addition
that will be required and mandatory at some future point.


> We have resisted publishing this information for years because not
> every ARM CPU is capable of providing this information - for many, we
> don't know what the CPU clock rate even is.  I believe it is a mistake
> to publish this information.

There are two specific problems on ARM servers:

1). Idiots. I've seen many situations in which benchmarks were run on
pre-production machines (often explicitly against legal agreements, but
those never happened within my organization so that's their problem -
this is carefully prohibited activity within our own walls and I make
sure our guys never run any numbers on pre-production stuff just so it
could never get into the "wrong" hands by accident...). What these
idiots do is then spread rumors that ARM server X "sucks" because they
ran a prohibited benchmark against a downclocked core and forgot how to
multiply numbers together. It gets worse. But usually it's because they
ran "cat /proc/cpuinfo" and it didn't tell them anything useful, so they
used whatever they thought the frequency was supposed to be.

These idiots include journalists. If you read the press, you'll see the
Gandhi sequence is playing out already between one of the established
vendors and an ARM vendor in which said established vendor is at the
laughing/fighting stage of things. And in a couple of cases recently,
the press included "we didn't know how fast it ran because /proc/cpuinfo
didn't tell us anything, so we guessed".

2). Users. Those who use and admin servers get the "speed" from
/proc/cpuinfo. It's a marketing number. It's useless. It absolutely must
be provided to the user or administrator exactly like on x86.

> If userspace wants to select an algorithm,
> that needs to be done according to much more information than just the
> CPU speed - it needs knowledge of the instruction timings as well, cache
> behaviour, etc, and you might as well benchmark an implementation and
> select at run time, caching the result.
> 
> Since we've never exported this information, it's not a regression
> and it's not part of the kernels standard API.

Agreed. But we'll still be coming back to ensure this information is
presented to users. I pointed out to ARM about 3-4 years ago that this
was going to bite us. It is now biting us, and we will ensure that
useless data is provided where it is on x86 for identical experience by
users. That is unless or until x86 users do something else always. Our
(separate) case will use DMI or ACPI for the same kind of data.

Jon.
