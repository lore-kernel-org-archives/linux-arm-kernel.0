From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 21 Nov 2013 14:20:28 +0100
Subject: [PATCH v3 3/4] ata: Add APM X-Gene SoC SATA host controller driver
In-Reply-To: <CAPw-ZTmaz3nnV3ThRgecT_RaYYW0bmfWvL8Kr-S3z1aKyUWc+w@mail.gmail.com>
References: <1384465153-29902-1-git-send-email-lho@apm.com>
 <201311151448.16279.arnd@arndb.de>
 <CAPw-ZTmaz3nnV3ThRgecT_RaYYW0bmfWvL8Kr-S3z1aKyUWc+w@mail.gmail.com>
Message-ID: <201311211420.28509.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 16 November 2013, Loc Ho wrote:


> >
> > config SATA_XGENE
> >         tristate "APM X-Gene 6.0Gbps SATA host controller support"
> >         depends on ARM64 || COMPILE_TEST
> >         ...
> >
> [Loc Ho]
> Okay. How about this?
> 
>  depends on ARM64 || COMPILE_TEST
>  select SATA_XGENE_PHY && SATA_AHCI_PLATFORM

I think you already found the mistake withis and corrected this in v4.

> > The interface you are looking for is pr_debug() or dev_dbg(), which get
> > built-in only if the DEBUG macro is set.
> >
> > In a lot of cases, it's actually best to remove debug output like this from
> > the driver once you have it working  -- whoever is debugging problems in
> > the driver next might need completely different debugging information or
> > can add them back easily if needed.
> >
> > It's your choice if you want to use pr_debug() or remove that output
> > entirely. If you remove it, best remove the helper functions entirely
> > and use readl/writel directly.
> [Loc Ho]
> I would like to keep this function for now until this driver actual
> being used in production. I will use pr_debug.

Ok.

> >> diff --git a/drivers/ata/sata_xgene.h b/drivers/ata/sata_xgene.h
> >> new file mode 100644
> >> index 0000000..51e73f6
> >> --- /dev/null
> >> +++ b/drivers/ata/sata_xgene.h
> >
> > This file should probably just be folded into the driver, since it contains no
> > interfaces between  modules, just internal definitions.
> [Loc Ho]
> I can get rip this header file now. But in the future I may need to
> add this back as I intended this driver to also support running from
> our co-processor (ARMv7 32-bit). For that, I will need anothe file and
> other function that will need knowledge of the context structure and
> etc.

Hmm, is the code for that coprocessor compiled from the kernel source?
If not, it shouldn't really make a difference as it won't live in a shared
code repository.

	Arnd
