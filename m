From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Nov 2017 16:37:14 +0000
Subject: [PATCH] ARM: verify size of zImage
In-Reply-To: <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
References: <E1eJiiq-0006k9-FE@rmk-PC.armlinux.org.uk>
 <CAKv+Gu-oXSpUcJ6acBKyohQ3WxSDp3sK7A4No2y4CHCFw1kSaQ@mail.gmail.com>
Message-ID: <20171128163714.GA8356@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 28, 2017 at 04:32:42PM +0000, Ard Biesheuvel wrote:
> (+ Gregory)
> 
> On 28 November 2017 at 16:27, Russell King <rmk+kernel@armlinux.org.uk> wrote:
> > The linker can sometimes add additional sections to the zImage ELF file
> > which results in the zImage binary being larger than expected.  This
> > causes appended DT blobs to fail.
> >
> > Verify that the zImage binary is the expected size, and fail the build
> > if this is not the case.
> >
> > Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
> > ---
> > As this patch is different, I've dropped Matthias' tested-by.  I'd
> > appreciate a replacement, thanks.  Also, I seem to remember that
> > Ard's toolchain was giving issues - maybe this alternative will
> > finally resolve them.
> >
> 
> $ nm arch/arm/boot/compressed/vmlinux |grep _edata
> 007b8200 D _edata
> 007b8200 D _edata_real
> 
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> 
> although I don't remember seeing this fail. It think it may have been
> Gregory who was having these issues?

The failing case was with a few ld versions when we had:

	ASSERT(. == _edata, "error: zImage file size is incorrect");

in place of the _edata_real assignment.  Yet, those very same linkers
have shown that they set _edata_real to the same value as _edata.

I forget who had the problem, sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
