From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Mar 2015 13:12:07 +0000
Subject: [PATCH] n_tty: use kmalloc() instead of vmalloc() to avoid crash
 on armada-xp
In-Reply-To: <55018E8B.8060704@list.ru>
References: <54FF21BE.2040506@list.ru>
 <20150311175227.499612af@free-electrons.com>
 <55007ADD.6080505@list.ru>
 <20150311174618.GE8656@n2100.arm.linux.org.uk>
 <55008483.8050603@list.ru>
 <20150311193343.0317e3e1@free-electrons.com>
 <55018A3C.7020409@list.ru>
 <20150312134756.5335cb32@free-electrons.com>
 <55018E8B.8060704@list.ru>
Message-ID: <20150312131207.GQ8656@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 12, 2015 at 04:03:07PM +0300, Stas Sergeev wrote:
> Yeah, I realize that, but I was hoping that some work-around
> exists. For example, move entire dimm above 4G? Is this really
> impossible? Or maybe move overlapping region above 8G...

You /really/ don't want to do that.  We have that situation on TI Keystone
SoCs and it's really horrible for the kernel to deal with.

For early kernel boot, we require RAM below the 4GB boundary, so that
we are able to execute code before the MMU is enabled.  No RAM below
4GB basically means there is no way to execute any code from RAM.

Keystone SoCs work around that by having an alias of RAM below 4GB,
and by doing some architecturally dubious, potentially fault-inducing
manipulation of the kernel page tables - so dubious that booting Linux
on Keystone SoCs with this leads us to print a big warning, and
immediately taint the kernel at the moment.

That's on my list of things which need to be worked on, subject to
commercial issues.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
