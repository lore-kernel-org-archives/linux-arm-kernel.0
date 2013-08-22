From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Aug 2013 01:12:52 +0100
Subject: build warnings: multi_v7_defconfig + LPAE, printk with
 variable types
In-Reply-To: <87a9kaob61.fsf@linaro.org>
References: <87k3jfqdmp.fsf@linaro.org>
 <CAOMZO5C44GRnTs+Oq9tCJ-mtH-9kyjMqEQWRDVadDfgOOSwaLA@mail.gmail.com>
 <87a9kaob61.fsf@linaro.org>
Message-ID: <20130822001252.GC6617@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 21, 2013 at 04:51:18PM -0700, Kevin Hilman wrote:
> Fabio Estevam <festevam@gmail.com> writes:
> 
> > On Wed, Aug 21, 2013 at 12:15 PM, Kevin Hilman <khilman@linaro.org> wrote:
> >> [1]
> >> Warnings:
> >>         arch/arm/mach-omap2/gpmc.c:1495:4: warning: format '%x'
> >> expects argument of type 'unsigned int', but argument 4 has type
> >> resource_size_t' [-Wformat]
> >
> > For this warning, what about this?
> >
> > --- a/arch/arm/mach-omap2/gpmc.c
> > +++ b/arch/arm/mach-omap2/gpmc.c
> > @@ -1491,8 +1491,8 @@ static int gpmc_probe_generic_child(struct
> > platform_device *pdev,
> >          */
> >         ret = gpmc_cs_remap(cs, res.start);
> >         if (ret < 0) {
> > -               dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%x\n",
> > -                       cs, res.start);
> > +               dev_err(&pdev->dev, "cannot remap GPMC CS %d to 0x%pa\n",
> > +                       cs, &res.start);
> 
> hmm, why did you add the '&' ?  That changes the behavior, not just the
> format.

Remember that these strings are checked by the standard printf-format
checker.  So, in order to remain compatible, these extra extensions are
made to the %p format - hence %p with an a suffix.  Normally, the 'a'
would get printed with standard printf, but the kernel's version
will detect the following letter and use it to decide how to print the
pointer argument.

See Documentation/printk-formats.txt, and note that for %pa is says
"passed by reference".

If you don't like passing by reference here, the alternative solution is
this, from the same document:

If <type> is dependent on a config option for its size (e.g., sector_t,
blkcnt_t) or is architecture-dependent for its size (e.g., tcflag_t), use a
format specifier of its largest possible type and explicitly cast to it.
Example:

        printk("test: sector number/total blocks: %llu/%llu\n",
                (unsigned long long)sector, (unsigned long long)blockcount);
