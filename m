From: tuomas.tynkkynen@iki.fi (Tuomas Tynkkynen)
Date: Wed, 18 Oct 2017 18:07:22 +0300
Subject: Changing the ARM variant reported by 'uname -m'
Message-ID: <e681bef0-353b-cdcb-18a1-361105eb1fe9@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

For our distro (NixOS), I've experimented with building packages for 
ARMv6 on ARMv7 hardware. This has generally worked fine, except that 
some build scripts (in coreutils, for example) notice that `uname -m` 
returns 'armv7l' and thus decide to e.g. add some ARMv7-specific gcc 
flags, which makes the binaries not run on actual ARMv6 devices.

So to avoid that, it would be necessary to have a way to make `uname -m` 
return a different ARM architecture version that the hardware has. After 
all, there is precedent for doing this: calling personality(PER_LINUX32) 
turns 'x86_64' to 'i686' and so on for other architectures.

I can see two ways of implementing this:

1) Keep using the personality() call by reserving some PER_* constants 
for architectures to use and decide what to map them to. E.g. the ARM 
implementation would require 8 values for choosing one of:
        armv4 armv4t armv5t armv5te armv5tej armv6 armv7 armv7m
plus automatically appending 'b' or 'l' depending on endianness.

2) Add a new setmachine() system call that allows setting the machine 
    name to an arbitrary string inside a non-initial UTS namespace.
