From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Sun, 3 Jul 2016 20:10:51 +0100
Subject: [RFC 0/1] ARM: print MHz in /proc/cpuinfo
In-Reply-To: <20160703184945.GB9421@lunn.ch>
References: <1465333713-14339-1-git-send-email-jon.mason@broadcom.com>
 <20160607221809.GP1041@n2100.armlinux.org.uk>
 <32b30c50-4712-568e-4044-9f533ca497b2@jonmasters.org>
 <20160703165431.GL1041@n2100.armlinux.org.uk>
 <20160703184945.GB9421@lunn.ch>
Message-ID: <20160703191051.GM1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 03, 2016 at 08:49:45PM +0200, Andrew Lunn wrote:
> On Sun, Jul 03, 2016 at 05:54:31PM +0100, Russell King - ARM Linux wrote:
> > Right, so having read all your email, there's no reason why we couldn't
> > just print:
> > 
> > cpu MHz  : 99999999.999
> 
> Since it is a float, how about using the value NaN? I think that
> nicely summaries it is a useless value.

;)

> However, i agree, we first need a technical justification for needing
> a value at all.

The only case where we've had a userspace "failure" is with the Jack
audio server, which wanted to parse the cpu MHz value to use it in
this calculation:

     static jack_time_t jack_get_microseconds_from_cycles (void) {
      return get_cycles() / __jack_cpu_mhz;
     }

Now, let's say that we did provide the CPU MHz, so __jack_cpu_mhz
reflects this value.  Great, Jack can initialise this value, but
there's two fundamental problems:

1. Jack is not aware of cpufreq, so the CPU MHz value it read at
   one point in time may not be the current CPU MHz - the CPU
   frequency can change at any moment depending on the governor's
   decisions.

2. get_cycles()... we have no userspace accessible CPU cycle counters
   on 32-bit ARM, which means knowing the CPU MHz for use like this
   gets you nowhere as get_cycles() can't return the number of CPU
   cycles.  It certainly can't return a number based on the CPU MHz.

Hence why this change to jack was the only sane thing to do:

https://github.com/jackaudio/jack2/commit/d425d8035b761b4a362c538c41eca874ff4

This wasn't even a kernel regression - the kernel never provided the
value on ARM, and in many cases the kernel doesn't know the right
value (as I've said previously in this thread.)

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
