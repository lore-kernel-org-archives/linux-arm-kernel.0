From: will.deacon@arm.com (Will Deacon)
Date: Mon, 15 Feb 2016 13:40:09 +0000
Subject: [PATCH v5sub1 0/8] arm64: split linear and kernel mappings
In-Reply-To: <56C1D2CF.1010108@gmail.com>
References: <1454324093-15998-1-git-send-email-ard.biesheuvel@linaro.org>
 <56BE3645.3030403@gmail.com>
 <CAKv+Gu9Qw=DSe1fZT=Dv=iKaKqzsf5ARK9dzwCWPk_0uRECm1w@mail.gmail.com>
 <56BE3C35.7070608@gmail.com>
 <CAKv+Gu_29SjYgg+P3fyGFcaRVxjapVzMs85Y2frd7_f51mPv-A@mail.gmail.com>
 <56C1D2CF.1010108@gmail.com>
Message-ID: <20160215134009.GB6298@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 15, 2016 at 02:29:51PM +0100, Matthias Brugger wrote:
> >On 12 February 2016 at 21:10, Matthias Brugger <matthias.bgg@gmail.com> wrote:
> >>On 12/02/16 20:47, Ard Biesheuvel wrote:
> >>>On 12 February 2016 at 20:45, Matthias Brugger <matthias.bgg@gmail.com>
> >>>>I bisected linux-next (20160212) with the following error on booting with
> >>>>an
> >>>>initramfs:
> >>>>   Failed to execute /init (error -8)
> >>>>   request_module: runaway loop modprobe binfmt-464c
> >>>>   Starting init: /sbin/init exists but couldn't execute it (error -8)
> >>>>   request_module: runaway loop modprobe binfmt-464c
> >>>>   Starting init: /bin/sh exists but couldn't execute it (error -8)
> >>>>   Kernel panic - not syncing: No working init found.  Try passing init=
> >>>>option to kernel. See Linux Documentation/init..
> >>>>
> >>>>I tracked down the error to patch 7 of this series. But I realized that
> >>>>patch 7 does not compile, but from patch 8 onwards I observe the error.
> >>>>
> >
> >As far as this failure is concerned, I managed to reproduce an error
> >with patch #7 and not #8 applied, involving out of range kvm symbols
> >at link time. This is reproducible with GCC 4.8 but not GCC 4.9 or
> >later. Is this what you were seeing as well? Or is there another
> >problem?
> >
> 
> I realized that I used " aarch64-linux-gnu-gcc (Linaro GCC 2014.11) 4.9.3
> 20141031 (prerelease)"  which gave me errors like:
> 
> arch/arm64/kvm/built-in.o: In function `__cpu_init_hyp_mode':
> /home/mbrugger/src/linux-next/./arch/arm64/include/asm/kvm_host.h:331:(.text+0x73b4):
> relocation truncated to fit: R_AARCH64_ADR_PREL_PG_HI21 against symbol
> `__kvm_hyp_vector' defined in .hyp.text section in arch/arm64/kvm/built-in.o
> 
> So it was time to update my toolchain to "aarch64-linux-gnu-gcc (Linaro GCC
> 5.1-2015.08) 5.1.1 20150608" which fixed the problem for me.

FWIW, I've also been seeing a bunch of reloc errors with allmodconfig,
for-next/core and GCC 4.9. loops_per_jiffy was one of the problematic
symbols, iirc, but upgrading to GCC 6 (devel) fixed the issue.

Will
