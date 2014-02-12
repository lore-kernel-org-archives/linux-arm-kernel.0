From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 12 Feb 2014 13:32:09 -0500
Subject: [RFC/PATCH 0/3] Add devicetree scanning for randomness
In-Reply-To: <CAOesGMgNkdxW4znmns10-DPc4+OTWJLyx2fcJGTgdND6pp0zUQ@mail.gmail.com>
References: <1392168805-14200-1-git-send-email-lauraa@codeaurora.org>
 <201402121251.06280.arnd@arndb.de>
 <20140212174554.GM27395@titan.lakedaemon.net>
 <CAOesGMgNkdxW4znmns10-DPc4+OTWJLyx2fcJGTgdND6pp0zUQ@mail.gmail.com>
Message-ID: <20140212183209.GN27395@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 12, 2014 at 10:13:59AM -0800, Olof Johansson wrote:
> On Wed, Feb 12, 2014 at 9:45 AM, Jason Cooper <jason@lakedaemon.net> wrote:
> 
> > I brought this up at last weeks devicetree irc meeting.  My goal is to
> > provide early randomness for kaslr on ARM.  Currently, my idea is modify
> > the init script to save an additional random seed from /dev/urandom to
> > /boot/random-seed.
> >
> > The bootloader would then load this file into ram, and pass the
> > address/size to the kernel either via dt, or commandline.  kaslr (run in
> > the decompressor) would consume some of this randomness, and then
> > random.c would consume the rest in a non-crediting initialization.
> >
> > While not ideal, it works in absence of an HRNG, and is no worse than
> > the current situation of storing the seed in /var/lib/misc/random-seed.
> > It also doesn't require modification of the bootloaders.  Just an
> > updated kernel, and update the bootloader environment to load the
> > seed.
> 
> Hmm. There are some drawbacks with this -- it assumes you can "just
> update the bootloader environment" which in general isn't easy to do.

true, the scope of my experience is consumer grade NASs, routers and
APs.  At the very least, it's much easier than upgrading the bootloader.

Also, my pov is as a hobbyist modifying devices post-sale.  The idea is
something I could add to my existing boxes without having to upgrade the
bootloaders.

> Also, you can't assume that /boot is writable or exists on all
> embedded systems.

In systems missing this capability, they often have the ability to
update the kernel.  All that's needed is one block of flash.  Current
random-seed size is 512 bytes.  I'm not saying it's easy or desirable.
But for folks who feel it's necessary to have kaslr on embedded devices,
it would facilitate better random numbers.  "Better" meaning much harder
for an attacker to guess.

> In general, taking both runtime and system-dependend data and using
> that to see entropy is a good idea.

Of course, I wasn't arguing for one or the other.  As you said later, in
situations where you can't feed in a seed file, MAC addresses and serial
numbers are better than nothing.

thx,

Jason.
