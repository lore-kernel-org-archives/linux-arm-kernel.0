From: ijc@debian.org (Ian Campbell)
Date: Tue, 13 Oct 2015 08:51:37 +0100
Subject: I/O issues with writing to mtdblock devices on kirkwood
In-Reply-To: <20151012162107.GB3242@lunn.ch>
References: <1440159857.19360.50.camel@debian.org>
 <20150905210846.GF6040@lunn.ch>
 <CAKzmTe0Bq8itvKoOTwZ+ZjY5pTqFYWt0-ihO4jn0qew_NYGhFg@mail.gmail.com>
 <20151011153548.GA9808@lunn.ch>
 <CAKzmTe2f1FdjM5VZ-ju+ZQ4z0Dxk4x1ywJCfi1OX5eSaCr=51w@mail.gmail.com>
 <461C493B-AD82-4044-A87F-EC22BBFB7011@gmail.com>
 <20151012162107.GB3242@lunn.ch>
Message-ID: <1444722697.16876.55.camel@debian.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2015-10-12 at 18:21 +0200, Andrew Lunn wrote:
> > I've been on backports for some time. AFAIR the problems started
> > with the change to dtb/dts.
> 
> Which kernel version? Can you give me a kernel version when it was
> good and a version when it was bad?
> 
> For a few kernel versions it was possible to boot both DT and the old
> setup file. It would be great to confirm it was the swap to DT, and
> not some other kernel change at about the same time.
> 
> My gut feeling is that the change to DT is not the issue. But this is
> all speculation at the moment, we need some hard evidence.

IIRC someone mentioned that the SATA driver which got used changed with
boardfile vs DT? Not sure if that is true though.

If anyone would like to perform the suggested experiments then flash
-kernel in Debian currently appends a DTB for Linux >= v3.17-rc1.
However this can be adjusted by editing /etc/flash-kernel/db and
adding:

Machine: <...>
DTB-Append-From: v3.16

Where the Machine stanza is the one for your platform, check
/usr/share/flash-kernel/db/all.db. You may need to repeat the Machine
stanza to cope with board vs. dtb mode names, e.g.

    Machine: QNAP TS-41x
    Machine: QNAP TS419 family
    DTB-Append-From: 3.17-rc1

One name is from /proc/device-tree/model under DTB the other is
/proc/cpuinfo:Hardware under board file. Under DTB the
/proc/cpuinfo:Hardware field is generic and not useful here.

You can also do just DTB-Append: Yes.

In any case having fiddled with the db you need to rerun flash-kernel
to make it take affect.

I think the most profitable first test would be to boot the v3.16
Jessie kernel in both board (default in Jessie) and DTB mode (by
modifying /etc/flash-kernel/db as above) and see if the issue
reproduces in both modes.

Older kernel binaries can be found at 
http://snapshot.debian.org/package/linux/, I'm not sure how far back it
is safe to go with Debian's binaries while appending a DTB, I'd
recommend having a serial console available if you are going to try.

Ian.
