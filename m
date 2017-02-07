From: jnair@caviumnetworks.com (Jayachandran C)
Date: Tue, 7 Feb 2017 09:41:07 +0000
Subject: [PATCH RESEND 1/3] arm64: add THUNDER2 processor family
In-Reply-To: <CAK8P3a1BTV4ZH9eQHwhyZ4AVVSwxsM_MD+iuByfdXDbE3M_szg@mail.gmail.com>
References: <1486233461-2679-1-git-send-email-jnair@caviumnetworks.com>
 <1486233461-2679-2-git-send-email-jnair@caviumnetworks.com>
 <20170206100608.GA8540@arm.com>
 <CAK8P3a1_dQZd3RRyavMKqBFcHsXTQ2oAUO5vaLhyTiH99XhqrQ@mail.gmail.com>
 <20170206152140.GA2001@localhost>
 <CAK8P3a1BTV4ZH9eQHwhyZ4AVVSwxsM_MD+iuByfdXDbE3M_szg@mail.gmail.com>
Message-ID: <20170207094106.GA2194@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 06, 2017 at 04:38:24PM +0100, Arnd Bergmann wrote:
> On Mon, Feb 6, 2017 at 4:21 PM, Jayachandran C <jnair@caviumnetworks.com> wrote:
> > On Mon, Feb 06, 2017 at 02:44:13PM +0100, Arnd Bergmann wrote:
> >> On Mon, Feb 6, 2017 at 11:06 AM, Will Deacon <will.deacon@arm.com> wrote:
> >
> > The Vulcan architecture has been discontinued by Broadcom, so the platform
> > and device tree files should go away soon. Renames are going to be messy, it
> > will be better to keep Vulcan around until the transition is complete, and
> > then delete it.
> 
> What are the disadvantages of a rename in your opinion? Are you mainly
> worried about merge conflicts or something else?

Ok, we are talking about 2 renames,
1. ARCH_VULCAN -> ARCH_THUNDER2,  please see below, but I think there is
board agreement on steps:
  - add ARCH_THUNDER2 in a patchset in a dev cycle
  - when it is mainline, replace ARCH_VULCAN with ARCH_THUNDER2 in the
    next cycle for drivers

2.  boot/dts/broadcom/vulcan* -> boot/dts/cavium/thunder-99* 
If I understand correctly, the main sticking point here is the
duplication of the dtsi file for SoC, instead of just including
vulcan.dtsi in thunder-99xx board file.

It is not so bad in my view to have the duplication in a kernel version
until vulcan is removed. I think you would prefer something like this:
  - have a patchset in this dev cycle to include vulcan.dtsi in
    thunder-99xx.dts (the 99xx name to match 88xx already there)
  - patchset in an upcoming dev cycle to:
     * remove ARCH_VULCAN
     * move vulcan.dtsi -> thunder-99xx.dtsi, drop vulcan ids which are
       removed.

This seems reasonable to me, I will send out a patch to do this (if you
do not have any further comments)

> >> Hmm, an alternative would be to add the new .dtsi file and start out with an
> >> #include of the existing file, with overrides for anything that needs changing.
> >> Similarly, the Kconfig symbol could just 'select ARCH_VULCAN' for now.
> >
> > Even in this case, we will need to copy the files from boot/dts/broadcom to
> > boot/dts/cavium along the way. The current patchset is (in my opinion) the
> > least messy way to accomplish the transition. But it is the maintainer's call,
> > so if you think it has to be done differently, I can update the patchset and
> > post again.
> 
> I don't see the need to copy if we can do an #include and later move the
> file into the new place. I also see only three references to ARCH_VULCAN
> at all aside from the dts file.
> 
> arch/arm64/configs/defconfig:CONFIG_ARCH_VULCAN=y
> drivers/gpio/Kconfig:   depends on OF_GPIO && (CPU_XLP || ARCH_VULCAN
> || COMPILE_TEST)
> drivers/i2c/busses/Kconfig:     depends on CPU_XLP || ARCH_VULCAN ||
> COMPILE_TEST
> drivers/spi/Kconfig:    depends on CPU_XLP || ARCH_VULCAN || COMPILE_TEST
> 
> We can probably manage to have a single patch to rename them all at
> the same time, or we do the add+remove over two merge windows.

Doing it in a single patch has to be acked by 3 maintainers, and
merged thru the arm-soc tree.

The simpler solution is to change these in 3 different patches, and
then remove ARCH_VULCAN Kconfig entry and defconfig entry when all
the references in the tree is gone.

> I also noticed now that you dropped the vulcan "compatible" strings in
> the .dtsi files, I think we should keep those as a fallback, and to avoid
> having interdependencies with the driver updates, e.g. the top-level
> compatible string should be
> 
> compatible = "cavium,thunder-9900", "brcm,vulcan-soc";
> 
> for the SoC, plus of course the board specific identifier in front of that.
> Same for the CPU, the i2c, gpio, and pmu.

The board, SoC, and cpu compat strings will go away with the platform,
so I did not add them here. With the updated plan above, I think we can
take care of this while deleting vulcan.

There is no plan to change compat properties in drivers, we can add
cavium compat properties when necessary. PMU is a slightly special
case, but we can be compatible with vulcan there too, until things
change.

Thanks,
JC.
