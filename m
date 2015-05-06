From: pali.rohar@gmail.com (Pali =?utf-8?B?Um9ow6Fy?=)
Date: Wed, 6 May 2015 13:44:17 +0200
Subject: [RESEND] [PATCH v2 1/2] arm: devtree: Set system_rev from DT
 revision
In-Reply-To: <3529567.PeFp1NNa1q@wuerfel>
References: <1430902142-17035-1-git-send-email-pali.rohar@gmail.com>
 <3577431.y872Foi4kj@wuerfel> <20150506103752.GG30910@pali>
 <3529567.PeFp1NNa1q@wuerfel>
Message-ID: <20150506114417.GI30910@pali>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 06 May 2015 13:04:01 Arnd Bergmann wrote:
> On Wednesday 06 May 2015 12:37:52 Pali Roh?r wrote:
> > On Wednesday 06 May 2015 11:31:15 Arnd Bergmann wrote:
> > > On Wednesday 06 May 2015 10:49:01 Pali Roh?r wrote:
> > > > With this patch "revision" DT string entry is used to set global system_rev
> > > > variable. DT "revision" is expected to be string with one hexadecimal number.
> > > > So "Revision" line in /proc/cpuinfo will be same as "revision" DT value.
> > > > 
> > > > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > > > Acked-by: Pavel Machek <pavel@ucw.cz>
> > > 
> > > +devicetree mailing list
> > > 
> > > The property needs to be specified in a binding somewhere.
> > > 
> > > > @@ -246,5 +247,14 @@ const struct machine_desc * __init setup_machine_fdt(unsigned int dt_phys)
> > > >     /* Change machine number to match the mdesc we're using */
> > > >     __machine_arch_type = mdesc->nr;
> > > >  
> > > > +   /* Set system revision from DT */
> > > > +   prop = of_get_flat_dt_prop(dt_root, "revision", &size);
> > > > +   if (prop && size > 0) {
> > > > +           char revision[11];
> > > > +           strlcpy(revision, prop, min(size, (int)sizeof(revision)));
> > > > +           if (kstrtouint(revision, 16, &system_rev) != 0)
> > > > +                   system_rev = 0;
> > > > +   }
> > > > +
> > > >     return mdesc;
> > > >  }
> > > > 
> > > 
> > > What is the reason for doing it this early? I think it would be nicer to do
> > > it after unflattening the DT.
> > > 
> > 
> > It needs to be done in this code, so "system_rev" variable is set
> > properly...
> 
> What I mean is which code accesses this variable that early?
> 

ATAG code is doing it at same early stage, so I added it to same early
stage...

> > > Also, it seems strange to have a string property and then use kstrtouint
> > > to convert it into a number. I think it should either be specified in a DT
> > > binding to be a string and then have the kernel not assume that it is a number,
> > > or we should define it to be binary.
> > > 
> > >       Arnd
> > 
> > Variable "system_rev" is number and it always was. So chaning type will
> > break more parts.
> > 
> > And it is string DT property to be human readable. Some other developers
> > suggested for v2 to change it to string (from number).
> 
> Both of them would be human readable, you just use something else to
> read them ;-)
> 
> If we have a string here, we should just change all uses of system_rev
> in the kernel accordingly, there are only a few of them:
> 
> $ git grep -w system_rev
> arch/arm/include/asm/system_info.h:extern unsigned int system_rev;
> arch/arm/kernel/atags_parse.c:  system_rev = tag->u.revision.rev;
> arch/arm/kernel/setup.c:unsigned int system_rev;
> arch/arm/kernel/setup.c:EXPORT_SYMBOL(system_rev);
> arch/arm/kernel/setup.c:        seq_printf(m, "Revision\t: %04x\n", system_rev);
> arch/arm/mach-clps711x/devices.c:       system_rev = SYSFLG1_VERID(readl(base + SYSFLG1));
> arch/arm/mach-clps711x/devices.c:       soc_dev_attr->revision = kasprintf(GFP_KERNEL, "%u", system_rev);
> arch/arm/mach-davinci/board-da850-evm.c:        switch (system_rev & 0xF) {
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev = 0x27000;
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |= (mo_version << MOTHERBOARD_SHIFT);
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    system_rev |= (exp_version << EXPBOARD_SHIFT);
> arch/arm/mach-imx/mach-imx27_visstrim_m10.c:    mo_version = (system_rev >> MOTHERBOARD_SHIFT) & VERSION_MASK;
> arch/arm/mach-ixp4xx/goramo_mlr.c:              system_rev = __raw_readl(flash + CFG_REV);
> arch/arm/mach-omap2/board-rx51-peripherals.c:   if ((system_rev >= SYSTEM_REV_S_USES_VAUX3 && system_rev < 0x100) ||
> arch/arm/mach-omap2/board-rx51-peripherals.c:       system_rev >= SYSTEM_REV_B_USES_VAUX3) {
> arch/arm/mach-orion5x/dns323-setup.c:   if (machine_is_dns323() && system_rev == DNS323_REV_A1)
> arch/arm/mach-orion5x/dns323-setup.c:   system_rev = dns323_identify_rev();
> arch/arm/mach-orion5x/dns323-setup.c:   pr_info("DNS-323: Identified HW revision %c1\n", 'A' + system_rev);
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-orion5x/dns323-setup.c:   switch(system_rev) {
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130) {
> arch/arm/mach-pxa/cm-x300.c:    if (system_rev < 130)
> arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
> arch/arm/mach-pxa/magician.c:           if (system_rev < 3)
> arch/arm/mach-pxa/magician.c:           system_rev = board_id & 0x7;
> arch/arm/mach-pxa/magician.c:           if (lcd_select && (system_rev < 3))
> arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) == 2) {
> arch/arm/mach-pxa/raumfeld.c:   if ((system_rev & 0xff) > 1) {
> arch/arm/mach-pxa/viper.c:              system_rev = (VIPER_BOARD_VERSION(version) << 8) |
> arch/arm/mach-pxa/zeus.c:       system_rev = __raw_readw(ZEUS_CPLD_VERSION);
> arch/arm/mach-pxa/zeus.c:       pr_info("Zeus CPLD V%dI%d\n", (system_rev & 0xf0) >> 4, (system_rev & 0x0f));
> arch/arm/mach-zynq/common.c:    system_rev = zynq_get_revision();
> arch/arm/mach-zynq/common.c:    soc_dev_attr->revision = kasprintf(GFP_KERNEL, "0x%x", system_rev);
> 
> In fact, half the uses of this actually assign the revision number themselves.
> code outside of arch/arm/mach-* and /proc/cpuinfo currently uses the variable.
> 
> 	Arnd

-- 
Pali Roh?r
pali.rohar at gmail.com
