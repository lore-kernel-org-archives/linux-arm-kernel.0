From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Jan 2015 21:02:18 +0100
Subject: [RFC PATCH v3 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <CAFpQJXXnM==4AmmNHf8yp2x0aK4Lnp2cy-4JpzuxsgXX3A=J4A@mail.gmail.com>
References: <1420011208-7051-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <1741288.B6kbjm5Uq5@wuerfel>
 <CAFpQJXXnM==4AmmNHf8yp2x0aK4Lnp2cy-4JpzuxsgXX3A=J4A@mail.gmail.com>
Message-ID: <3372289.4AUgcSNZN5@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 January 2015 15:04:26 Ganapatrao Kulkarni wrote:
> On Sat, Jan 3, 2015 at 2:47 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 31 December 2014 13:03:27 Ganapatrao Kulkarni wrote:
> >> +             cpu at 00f {
> >> +                     device_type = "cpu";
> >> +                     compatible = "cavium,thunder", "arm,armv8";
> >> +                     reg = <0x0 0x00f>;
> >> +                     enable-method = "psci";
> >> +                     arm,associativity = <0 0 0x00f>;
> >> +             };
> >> +             cpu at 100 {
> >> +                     device_type = "cpu";
> >> +                     compatible = "cavium,thunder", "arm,armv8";
> >> +                     reg = <0x0 0x100>;
> >> +                     enable-method = "psci";
> >> +                     arm,associativity = <0 0 0x100>;
> >> +             };
> >
> > What is the 0x100 offset in the last-level topology field? Does this have
> > no significance to topology at all? I would expect that to be something
> > like cluster number that is relevant to caching and should be represented
> > as a separate level.
>
> i did not understand, can you please explain little more about "
> should be represented as a separate level."
> at present, i have put the hwid of a cpu.

>From what I undertand, the hwid of the CPU contains the "cluster" number in
this bit position, so you typically have a shared L2 or L3 cache between
all cores within a cluster, but separate caches in other clusters.

If this is the case, there will be a measurable difference in performance
between two processes sharing memory when running on the same cluster,
or when running on different clusters on the same socket. If the
performance difference is relevant, it should be described as a separate
level in the associativity property.

	Arnd
