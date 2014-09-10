From: mikpelinux@gmail.com (Mikael Pettersson)
Date: Wed, 10 Sep 2014 14:32:20 +0200
Subject: gcc 4.8.3 miscompiles drivers/net/ethernet/freescale/fec_main.c ?!
In-Reply-To: <20140910110943.3673dbb4@archvile>
References: <20140910110943.3673dbb4@archvile>
Message-ID: <21520.17620.519242.597681@gargle.gargle.HOWL>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

David Jander writes:
 > 
 > Hi,
 > 
 > I am seeing a strange problem when building a recent kernel with gcc-4.8.3 for
 > armv7-a that contains the following patch:
 > 
 > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit?id=bfd4ecdd87d350e19457fe0d02fa1e046774c44e
 > 
 > Unfortunately I am not good enough at reading ARM assembly output from GCC to
 > understand whats going wrong, so I am asking for help.
 > 
 > I started noticing ethernet packet loss on a i.MX6 board after upgrading the
 > kernel from 3.16-rc-something to latest mainline. The problem is very easy to
 > reproduce so I started git-bisecting. Git bisect gave me the above patch as
 > the culprit, and indeed: Without the patch a flood-ping goes fine (just one
 > dot on screen, no lost packets). I apply the patch and the dots start filling
 > the screen instantly.
 > 
 > I am compiling the kernel using Pengutronix's OSELAS toolchain version
 > 2013.12.1, which is based on linaro gcc-4.8.3 without any relevant patches
 > AFAIK.

Linaro's toolchain is itself heavily modified compared to FSF gcc-4.8.3,
so first please try a pure vanilla FSF gcc-4.8.3, and then a likewise
vanilla gcc-4.9.1.  If those also cause the malfunction, then you have
proof for a bug in upstream gcc (or possibly undefined code in the kernel),
otherwise the bug is likely Linaro's.

 > Compiling with -O2 breaks the code, while -Os seems to produce a correctly
 > working kernel.
 > 
 > I decided to make changes to the code and see if I could find other ways to
 > "fix" the problem, and I got the following result:
 > 
 > The above mentioned patch introduces the static function fec_enet_hwtstamp()
 > near line 1068 of fec_main.c. If I make an exact copy of this function, where
 > I only change the name (e.g. fec_enet_hwtstamp2), and change one of the two
 > places this function is called to instead use the other name, GCC inlines both
 > copies and the problem disappears!
 > 
 > Since I am not very good at GCC internals nor do I know this piece of code in
 > fec_main.c very well, I am asking here for help in hunting down the real bug,
 > which I suspect is in GCC... but I want to know for sure.
 > 
 > Best regards,
 > 
 > -- 
 > David Jander
 > Protonic Holland.
 > 
 > _______________________________________________
 > linux-arm-kernel mailing list
 > linux-arm-kernel at lists.infradead.org
 > http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
