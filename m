From: w@1wt.eu (Willy Tarreau)
Date: Wed, 18 Oct 2017 17:40:52 +0200
Subject: Changing the ARM variant reported by 'uname -m'
In-Reply-To: <e681bef0-353b-cdcb-18a1-361105eb1fe9@iki.fi>
References: <e681bef0-353b-cdcb-18a1-361105eb1fe9@iki.fi>
Message-ID: <20171018154052.GA6420@1wt.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tuomas,

On Wed, Oct 18, 2017 at 06:07:22PM +0300, Tuomas Tynkkynen wrote:
> Hi,
> 
> For our distro (NixOS), I've experimented with building packages for ARMv6
> on ARMv7 hardware. This has generally worked fine, except that some build
> scripts (in coreutils, for example) notice that `uname -m` returns 'armv7l'
> and thus decide to e.g. add some ARMv7-specific gcc flags, which makes the
> binaries not run on actual ARMv6 devices.
> 
> So to avoid that, it would be necessary to have a way to make `uname -m`
> return a different ARM architecture version that the hardware has.

In fact, while cheating on the "uname" output can have its use cases, what
you describe is a different use case, your problem is related to the fact
that you are trying to cross-compile but are not doing it. This is always
extremely risky as you only catch the most visible part of the iceberg.
Some build programs may even detect certain syscalls on your systems, the
kernel version or the support for certain instructions or CPU extensions.
I used to suffer from this 15 years ago when dealing with i386 vs i486,
regularly facing the common "Illegal instruction" everytime a program
accidently used BSWAP for htonl() despite me being very careful... 

The proper way to definitely get rid of this situation is to pass
--host= and --build= to "configure" and to cross-compile everything. It's
much less complicated than what it sounds like and comes with a lot of
benefits, including the fact that you can build from about any arch for
any other arch, and that you don't accidently depend on anything detected
in the build environment.

Hoping this helps,
Willy
