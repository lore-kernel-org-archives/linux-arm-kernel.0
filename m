From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Sat, 17 Jan 2015 23:21:42 +0000
Subject: SMBIOS/DMI data under CONFIG_STRICT_DEVMEM
In-Reply-To: <54BAC21D.9040009@redhat.com>
References: <54BAC21D.9040009@redhat.com>
Message-ID: <20150117232142.GN3827@bivouac.eciton.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 17, 2015 at 03:12:13PM -0500, Jon Masters wrote:
> Hi Catalin, all,
> 
> I would like to ensure that the SMBIOS data provided by firmware is
> always readable from userspace on AArch64, through /dev/mem.

No, we need to ensure /dev/mem can be completely disabled on any
system that ever wants to have any level of reliability.

Fortunately, for SMBIOS there is /sys/firmware/dmi. Expect to see some
patches from Ivan Khoronzhuk on this next week. (He has a working
prototype of dmidecode, and a couple of minor kernel patches, as of
yesterday.)

For acpidump, there is /sys/firmware/acpi, and we're looking into that
as well.

> When building a kernel with CONFIG_STRICT_DEVMEM, arm64 follows broadly
> x86 with the exception of an assumption surrounding the low range of
> memory (which doesn't apply on AArch64 platforms universally anyway).
> Thus on x86, they can directly read the SMBIOS table from dmidecode when
> it tries to map /dev/mem due to its location. I'm hacking something up
> for the moment, but I would like to solve this.

STRICT_DEVMEM is a trainwreck on all architectures, but particularly
bad on ARM*, since we don't have anything resembling a predictable
memory map. While I like Ard's approach to improve it with data
actually available, I would also like add the ability to make it
tweakable as read-write, read-only or no access.

I sent out a series looking to consolidate STRICT_DEVMEM handling
across architectures (i.e. not have separate definitions per
architecture Kconfig), but had little response. If anyone is
interested in seeing that happening, let me know and I'll resend with
you on cc.

/
    Leif
