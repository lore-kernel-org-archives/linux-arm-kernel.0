From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 18 Aug 2016 15:47:22 +0200
Subject: Merging code with arch condition into head.S
In-Reply-To: <CACna6rw1eTiqijo24SiGAYi_XeEGWb-C1L5diYUzpyA3o7e+qw@mail.gmail.com>
References: <CACna6rxhhD5kfa1oJzqp2dQxBhjaUzdTkNPMcm-+iNvQHD8yzA@mail.gmail.com>
 <CAKv+Gu8dP8oAq-ykejskw+AzX-7_h_Ws6sFdXO+40MiGM14ccA@mail.gmail.com>
 <CACna6rw1eTiqijo24SiGAYi_XeEGWb-C1L5diYUzpyA3o7e+qw@mail.gmail.com>
Message-ID: <20160818134722.GA13458@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 03:23:41PM +0200, Rafa?? Mi??ecki wrote:
> On 18 August 2016 at 12:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 18 August 2016 at 12:35, Rafa?? Mi??ecki <zajec5@gmail.com> wrote:
> >> I'd like to ask for help with writing my arcm/arm/boot/compressed/head-foo.S.
> >>
> >> There is probably a bug in bootloader on *a lot* market-available
> >> devices that needs a very early fix executed during decompression. If
> >> we don't implement it, Broadcom Northstar devices hang in 25% of tries
> >> and BCM53573 devices don't boot at all.
> >>
> >
> > Could you elaborate on the nature of the fix?
> 
> I'm not ARM expert and I don't have any Broadcom datasheets, so I have
> a very little view of the issue. It seems that to make booting
> reliable, I have to clear 2 following bits in the SCTLR register:
> #define CR_M (1 << 0) /* MMU enable */
> #define CR_C (1 << 2) /* Dcache enable */
> and then invalidate the cache.

So it leaves the caches enabled?

Been there, done that. This is violating the boot loader contract to
the kernel at start time. There are a couple of Marvell Kirkwood
systems what have this problem, and it was extensively discussed at
the time. Basically, it is too late to fix by the time the kernel has
started running. The kernel is already corrupt.

https://lists.debian.org/debian-arm/2012/08/msg00128.html
https://patchwork.kernel.org/patch/3427771/

You need to find another solution, e.g. in intermediate boot loader,
or do what Debian does and append a few instructions to the kernel
when it is installed on a hardware with this issue.

     Andrew
