From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 29 Apr 2013 14:58:16 +0200
Subject: [PATCH 03/21] ARM: shmobile: don't call irqchip_init
 unconditionallyA
In-Reply-To: <CABYn4sxjpp3yPkjDM9XhX6fyT-g_OoCjcnD1u=5oyb+Y6y=Nmw@mail.gmail.com>
References: <1366910944-3033663-1-git-send-email-arnd@arndb.de>
 <20130426004835.GA20070@verge.net.au>
 <CABYn4sxjpp3yPkjDM9XhX6fyT-g_OoCjcnD1u=5oyb+Y6y=Nmw@mail.gmail.com>
Message-ID: <201304291458.16634.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 26 April 2013, Bastian Hecht wrote:
> > This one seems broken as the armadillo800eva board currently uses
> > it to initialise GIC even if CONFIG_ATAGS is not defined.
> >
> > I did test the above change on the armadillo800eva board
> > with the above change and CONFIG_ATAGS disabled, the result was
> > a boot failure. With the change reverted booting seems fine.
> 
> CONFIG_ATAGS and CONFIG_ARM_APPENDED_DTB are two ways to pass the
> device tree information, right?

No, the two are methods alternative methods for booting from a legacy
boot loader. CONFIG_ATAGS is the old boot method without a DT, using
a board file and a MACHINE_START() macro. ARM_APPENDED_DTB means you
have a DT linked into the kernel but pass ATAGS to the kernel which
uses the passed data to modify the DT.

> So we run into trouble when we use the later but disable the first.
> Is there a reason why you wanted to avoid using two times just "if
> (!IS_ENABLED(CONFIG_OF))", Arnd?

I incorrectly assumed that the second one was only used without DT,
since it uses hardcoded MMIO locations rather than using of_iomap().

	Arnd
