From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 6 Mar 2018 14:12:29 +0100
Subject: [PATCH 2/2] arm64: defconfig: Raise NR_CPUS to 256
In-Reply-To: <20180302143737.10788-2-jglauber@cavium.com>
References: <20180302143737.10788-1-jglauber@cavium.com>
 <20180302143737.10788-2-jglauber@cavium.com>
Message-ID: <CAK8P3a2ORBU-_7=JeCHSuM8YtC7zeO1VPxQzny_8BrpyVGCKKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 2, 2018 at 3:37 PM, Jan Glauber <jglauber@cavium.com> wrote:
> ThunderX1 dual socket has 96 CPUs and ThunderX2 has 224 CPUs.

Are you sure about those numbers? From my counting, I would have expected
twice that number in both cases: 48 cores, 2 chips and 2x SMT for ThunderX
vs 52 Cores, 2 chips and 4x SMT for ThunderX2.

> Therefore raise the default number of CPUs from 64 to 256
> by adding an arm64 specific option to override the generic default.

Regardless of what the correct numbers for your chips are, I'd like
to hear some other opinions on how high we should raise that default
limit, both in arch/arm64/Kconfig and in the defconfig file.

As I remember it, there is a noticeable cost for taking the limit beyond
BITS_PER_LONG, both in terms of memory consumption and also
runtime performance (copying and comparing CPU masks).

I'm sure someone will keep coming up with even larger configurations
in the future, so we should try to decide how far we can take the
defaults for the moment without impacting users of the smallest
systems. Alternatively, you could add some measurements that
show how much memory and CPU time is used up on a typical
configuration for a small system (4 cores, no SMT, 512 MB RAM).
If that's low enough, we could just do it anyway.

        Arnd
