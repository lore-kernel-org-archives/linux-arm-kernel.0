From: yamada.masahiro@socionext.com (yamada.masahiro at socionext.com)
Date: Thu, 2 Nov 2017 08:48:46 +0000
Subject: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
 top-level Makefile
In-Reply-To: <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com>
References: <1509591085-23940-1-git-send-email-yamada.masahiro@socionext.com>
 <CAK8P3a3FoRJeO=TQGMRf6t4-bP8nP6KUEhkCrHP6L8XaF1Ee7g@mail.gmail.com>
Message-ID: <bb7c1a637afa47e8943ce494798f957c@SOC-EX01V.e01.socionext.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,


> -----Original Message-----
> From: arndbergmann at gmail.com [mailto:arndbergmann at gmail.com] On Behalf Of
> Arnd Bergmann
> Sent: Thursday, November 02, 2017 5:38 PM
> To: Yamada, Masahiro/?? ?? <yamada.masahiro@socionext.com>
> Cc: DTML <devicetree@vger.kernel.org>; Rob Herring <robh@kernel.org>;
> linux-arch <linux-arch@vger.kernel.org>; open list:RALINK MIPS
> ARCHITECTURE <linux-mips@linux-mips.org>; Linux Kbuild mailing list
> <linux-kbuild@vger.kernel.org>; Russell King <linux@armlinux.org.uk>;
> Ralf Baechle <ralf@linux-mips.org>; Pantelis Antoniou
> <pantelis.antoniou@gmail.com>; Mark Rutland <mark.rutland@arm.com>;
> Frank Rowand <frowand.list@gmail.com>; Linux ARM
> <linux-arm-kernel@lists.infradead.org>
> Subject: Re: [PATCH v2] kbuild: clean up *.dtb and *.dtb.S patterns from
> top-level Makefile
> 
> On Thu, Nov 2, 2017 at 3:51 AM, Masahiro Yamada
> <yamada.masahiro@socionext.com> wrote:
> > We need to add "clean-files" in Makfiles to clean up DT blobs, but we
> > often miss to do so.
> >
> > Since there are no source files that end with .dtb or .dtb.S, so we
> > can clean-up those files from the top-level Makefile.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> 
> Acked-by: Arnd Bergmann <arnd@arndb.de>
> 
> 
> On a (barely) related note, I'm struggling with another problem in the
> way we handle
> the .dtb files in arm64 when CONFIG_OF_ALL_DTBS is enabled: when building
> on a lot of CPUs, we try to build the same files from both
> arch/arm64/boot/dts/Makefile
> and arch/arm64/boot/dts/*/Makefile, which then results in a failed
> build when writing
> the temporary files.
> 
> I have come up with a workaround that I use locally, but it seemed too ugly
> to
> submit that for inclusion. Maybe you can come up with a nicer a solution
> for
> this as well?
> 
>       Arnd

Yeah, I had also noticed this race problem on parallel building
with CONFIG_OF_ALL_DTBS.

I was planning to do it
when I come up with a clean implementation.

One idea is to handle dtb-y and CONFIG_OF_ALL_DTBS
natively in scripts/Makefile.build or somewhere
as scripts/Makefile.dtbinst already recognizes dtb-y as a special variable.
