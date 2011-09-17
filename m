From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 17 Sep 2011 15:30:25 -0600
Subject: [PATCH v2] pata-generic/of: Make probing via device tree
	non-powerpc-specific
In-Reply-To: <2615461.zA8fCfbHH2@wuerfel>
References: <1316183890-13677-1-git-send-email-dave.martin@linaro.org>
	<1316190120-17010-1-git-send-email-dave.martin@linaro.org>
	<20110917153732.GR3523@ponder.secretlab.ca>
	<2615461.zA8fCfbHH2@wuerfel>
Message-ID: <CACxGe6u8a0HbCSisVadhasMKpdmgmVP1OZOo0+pLWcNncJozbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 12:40 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 17 September 2011 09:37:32 Grant Likely wrote:
>> What driver is normally used for versatile express pata? ?This driver
>> is kind of legacy in that it was created when there was a split
>> between platform_device and of_platform_devices. ?But that split was a
>> bad idea and the same driver should be used regardless of whether or
>> not DT is enabled. ?pata_of_platform.c really should be removed.
>
> It normally uses the plain pata_platform.c driver.
>
> Note that the pata_of_platform driver is already just a shim on
> top of the regular pata_platform driver. They could easily be combined,
> but the current state is also ok, since there is very little code
> duplication.

A bunch of the code is actually redundant since the resource table is
no populated for DT devices.  I also see some directly references to
reg-shift and pio-mode property values without using be32_to_cpu(), so
that will also need to be fixed.  The of_irq_to_resource() and
of_address_to_resource() calls are now redundant since
platform_get_*() works for DT sourced platform device (with one quirk
for the electra-ide device).  Given that the conversion is straight
forward, I'd rather see pata_of_platform.c dropped and rolled into
pata_platform.c.  I've hacked together a patch to do so, but I've only
compile tested it.  Dave, if I send it to you, can you take care of
testing it?

Thanks,
g.
