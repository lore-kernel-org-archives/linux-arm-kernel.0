From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Wed, 21 Jun 2017 10:35:49 +0100
Subject: [PATCH 00/51] rtc: stop using rtc deprecated functions
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DD00278C0@AcuExch.aculab.com>
References: <20170620100348.zh4ygvjjgnhxvmvl@piout.net>
 <20170620121011.GA13221@amd>
 <20170620122400.sm7qqvwyj6cuzarw@piout.net>
 <20170620132620.GA16881@amd>
 <6ED8E3B22081A4459DAC7699F3695FB7018CD96FCD@SW-EX-MBX02.diasemi.com>
 <20170620134458.GA10104@amd>
 <20170620134827.ubvzhh25klaotupv@piout.net>
 <CA+M3ks68+z6nDtYM8CDpso7SxjB6Nt5E=rOc1yxx=kDz6PUeVQ@mail.gmail.com>
 <20170620211536.GM4902@n2100.armlinux.org.uk>
 <063D6719AE5E284EB5DD2968C1650D6DD00278C0@AcuExch.aculab.com>
Message-ID: <20170621093549.GQ4902@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 21, 2017 at 09:26:51AM +0000, David Laight wrote:
> From: Russell King - ARM Linux
> > Sent: 20 June 2017 22:16
> ..
> > Consider that at the moment, we define the 32-bit RTC representation to
> > start at a well known epoch.  We _could_ decide that when it wraps to
> > 0x80000000 seconds, we'll define the lower 0x40000000 seconds to mean
> > dates in the future - and keep rolling that forward each time we cross
> > another 0x40000000 seconds.  Unless someone invents a real time machine,
> > we shouldn't need to set a modern RTC back to 1970.
> 
> True, just treating the value as unsigned gives another 67 years.

We _already_ do treat it as an unsigned number, so already the panicing
about 2038 is complete and utter nonsense - that's why I've been
consistently stating the 2106 date.

> If a 32bit RTC is programmed with the low 32bits of the 64bit 'seconds
> since 1970' the kernel should have no real difficulty sorting out the
> high bits from other available information.

Right, but converting all the 32-bit conversion functions to 64-bit
means that rather than "sorting out" that from the core RTC driver,
we have to implement solutions in each and every driver.

While that may appear to be a good idea, many RTCs that are 32-bit
counters do not themselves have additional non-volatile storage, so
it means that we're ending up with a lot of RTC specific hacks to
go and get the additional information from some other driver elsewhere
in the system.

> Problems with things like the x86 bios setting the rtc to stupid values
> are another matter.

Forget x86, the RTC there does not store time as a 32-bit integer, it's
stored as its component values, and there's non-volatile memory attached
to the RTC.  Hence, it's out of scope of "what to do about RTCs that
store time in 32-bit format" and also out of scope of "what to do about
RTC drivers that use the 32-bit time conversion function."

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
