From: olof@lixom.net (Olof Johansson)
Date: Thu, 3 Oct 2013 10:54:07 -0700
Subject: Use of drivers/platform and matching include?
In-Reply-To: <20131003170914.GA11992@kroah.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
 <20131003170914.GA11992@kroah.com>
Message-ID: <CAOesGMhBaj14++kJ9tVko68MjC7D+JZrBRgoxa4zmZ9z186MQw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 10:09 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Oct 03, 2013 at 09:46:30AM -0700, Olof Johansson wrote:
>> I don't have a good answer though. If it wasn't for the arm64 fork,
>> locating these under arch/arm somewhere would really be the reasonable
>> answer, like we used to do on powerpc. :(
>
> Sounds like yet-another-good reason why there shouldn't be an arm64
> "fork" at all :(

Doing a fork gives a chance at a clean slate refresh of platform
support, which is in itself quite useful. But indeed it causes some
things to be more complicated.

It's a common complaint that "everybody who ever forked for 64-bit
have later merged", and that's true, but that doesn't mean there's no
value in forking (and perhaps later merging), instead of adding on top
to start with.

> The arm community created this mess, you all can fix it up, it's not too
> late.

It wouldn't be a huge deal to add something like arch/arm/syslib and
give some of the system library-type code a home there -- stuff like
resource allocation libraries, etc. I don't think we want to collect
all the back-end drivers in there though, just libraries.

I think many of us are hesitant to introduce something that runs the
risk of becoming a dumping ground for all these "I don't know where to
put them, so here you go" drivers, since we've spent so much time
cleaning them all up and de-forking per-vendor implementations of
similar things.

Still, there's little point in trying to artificially remove drivers
that are 100% vendor unique from a vendor-specific location just for
the sake of it. And we do have a single merge path today through
arm-soc to catch a lot of these things as they get introduced --
almost more so than if everyone adds their own driver/ directory and
declare themselves maintainer of that subtree.

Kumar, it would be useful to get a bit of an inventory of what you
know you need a home for. I know the APM guys have a queue manager
(arm64-only) that handles things such as resource allocation for
ethernet, etc, that they need a home for. It's not a pure library
though, since there's also error interrupts, etc, to deal with.


-Olof
