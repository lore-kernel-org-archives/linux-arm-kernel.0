From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 14 Jan 2014 07:14:51 +0100
Subject: AArch64 kernel image decompression
In-Reply-To: <CAOesGMi_QY6z_3QSdAs-3JaEUufgymJg=kiqpb9D6RNNjZF5sA@mail.gmail.com>
References: <20140110170436.GS8153@joshc.qualcomm.com>
 <e79fa209ffc4485d8cae87bae3daa656@BN1PR03MB220.namprd03.prod.outlook.com>
 <CAOesGMi_QY6z_3QSdAs-3JaEUufgymJg=kiqpb9D6RNNjZF5sA@mail.gmail.com>
Message-ID: <201401140714.52400.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 January 2014, Olof Johansson wrote:
> On Mon, Jan 13, 2014 at 7:52 PM, bhupesh.sharma at freescale.com
> <bhupesh.sharma@freescale.com> wrote:
> 
> > AFAIK, u-boot requires a u-boot specific header (see [1]) on top of any image it wants to
> > boot - whether it's a uncompressed vmlinux or a compressed vmlinux.gz
> >
> > In the ARM32 code base we had the Makefile rule to generate a uImage automatically (see [2]), with ARM64
> > now, I am forced to compress the vmlinux and put a u-boot header on top of it using 'mkimage' and then
> > feed the 'uImage' thus generated to the u-boot.
> >
> > So, it would be good if the ARM64 Makefile can mimic the ARM32 one in this aspect - now that we have
> > a working u-boot capable of booting vanilla linux on an ARMv8 foundation model.
>
> No, there should be no uImage target on arm64. Newer u-boots can
> already boot an ARM zImage (through the bootz command), and should be
> enhanced as needed to boot a vmlinux if needed.

Right. We've been trying to deprecate the uImage target on arm32 for a while,
but it's hard when all the documentation points to it. Hopefully not having
it on arm64 will teach people about the fact that it's not really needed
anyway.

Note that uImage is fundamentally incompatible with multiplatform kernels,
since it hardcodes the load address in the image file.

I thought we could already boot both zImage and vmlinux on arm32. I have
to correct myself about saying we should boot a vmlinux on arm64 though:
the documented interface is booting Image, which includes a Linux-defined
header, or Image.gz.
 
> Bringing in uImage as a target on ARM might have been a mistake, since
> now people want to bring in new targets for whatever boot format they
> happen to want. So it's a good idea to keep arm64 from going down the
> same path and stick to the native, raw, formats.

Yes. Not sure if there was much choice about uImage at the time arm32
u-boot was done, and multiplatform wasn't on the radar back then, but
we should have made the switch much earlier.

	Arnd
