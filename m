From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Fri, 7 Jan 2011 18:47:14 +0300
Subject: [PATCH v2 0/3] add CNS3xxx AHCI support
In-Reply-To: <4D264DA4.6040308@pobox.com>
References: <1294206187-11487-1-git-send-email-mkl0301@gmail.com>
	<4D24B53C.4020009@pobox.com>
	<AANLkTinxNtzpzUn0=-iph_N7tffM6Nu++J9qNNhcp8pX@mail.gmail.com>
	<20110106105157.GA9560@oksana.dev.rtsoft.ru>
	<4D264DA4.6040308@pobox.com>
Message-ID: <20110107154714.GA27055@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 06, 2011 at 06:17:56PM -0500, Jeff Garzik wrote:
> >[...]
> >>>It is overkill to rename the entirety of ahci_platform just for one override
> >>>function.
> >>>This sort of thing I would have expected to be added directly to
> >>>ahci_platform.c.
> >>It might be overkill for only one controller. but it is more clean and
> >>readable to have different SoC specific changes in separate files,
> >>especially when more SoCs need to make similar changes.
> >
> >I think that renaming the file is not necessary. You can just
> >rename the module in the makefile.
> >
> >Personally I like the current approach more than putting
> >controller-specific fixups directly into ahci_platform.
> 
> My main objection is the renaming.  If ahci_platform wants to export
> some symbols for SoC modules like ahci_platform_cns, that's ok.
> 
> In general, follow the library approach rather than linking modules
> together in strange ways.

In ahci_platform case there's almost nothing to factor out to a
library. Each platform just needs its own small "fixups" that we
normally pass via platform data.

We would happily pass them via platform data, and initially Mac
did exactly this, see:

http://ns3.spinics.net/lists/linux-ide/msg39554.html

You may notice that all platform-specific quirks are in the
platform code, which is neat. But there is a problem: once
the platform code needs to use libata, then we have to
build libata into the kernel (no modules possible), i.e.

http://ns3.spinics.net/lists/linux-ide/msg39656.html

It's not something new, we have the same "problem" with SDHCI,
USB and plenty other drivers. But the solution is simple, for
example see drivers/mmc/host/sdhci-pltfm.c and sdhci-cns3xxx.c
(and sdhci-esdhc-imx.c as another example of platform-specific
hooks for sdhci-pltfm).

Of course, we could make full-fledged platform driver just for
CNS3xxx, but that's kind of overkill. IMO, it's better to make
ahci_platform flexible and suitable for generic use.

As for renaming, I agree that ahci_platform.c file does not
need to be renamed, I still think that we could just rename
the module (so far it is used only on CNS3xxx platforms, so
no big deal even if anybody rely on the module name, which
I doubt.)

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru at gmail.com
