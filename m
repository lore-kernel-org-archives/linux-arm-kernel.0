From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Jan 2014 12:32:59 +0000
Subject: [PATCH 18/20] clocksource / acpi: Add macro
 CLOCKSOURCE_ACPI_DECLARE
In-Reply-To: <52E1AFE8.40601@linaro.org>
References: <1389961514-13562-1-git-send-email-hanjun.guo@linaro.org>
 <1389961514-13562-19-git-send-email-hanjun.guo@linaro.org>
 <CACRpkdYKwaH5DX27irzmcTDAMhQMUhuzz6N7mjKWv9tZchv0Ug@mail.gmail.com>
 <52E1AFE8.40601@linaro.org>
Message-ID: <20140124123259.GI814@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 24, 2014 at 12:12:24AM +0000, Hanjun Guo wrote:
> Hi Linus,
> 
> Sorry for the late reply.
> 
> On 2014?01?22? 16:26, Linus Walleij wrote:
> > On Fri, Jan 17, 2014 at 1:25 PM, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> >
> >> From: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >>
> >> This macro does the same job as CLOCKSOURCE_OF_DECLARE. The device
> >> name from the ACPI timer table is matched with all the registered
> >> timer controllers and matching initialisation routine is invoked.
> >>
> >> Signed-off-by: Amit Daniel Kachhap <amit.daniel@samsung.com>
> >> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > Actually I have a fat patch renaming CLOCKSOURCE_OF_DECLARE()
> > to TIMER_OF_DECLARE() and I think this macro, if needed, should
> > be named TIMER_ACPI_DECLARE().
> >
> > The reason is that "clocksource" is a Linux-internal name and this
> > macro pertains to the hardware name in respective system
> > description type.
> 
> That make sense to me too, I will update in next version if
> this patch is still needed.
> 
> >
> >> +#ifdef CONFIG_ACPI
> >> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)                     \
> >> +       static const struct acpi_device_id __clksrc_acpi_table_##name   \
> >> +               __used __section(__clksrc_acpi_table)                   \
> >> +                = { .id = compat,                              \
> >> +                    .driver_data = (kernel_ulong_t)fn }
> >> +#else
> >> +#define CLOCKSOURCE_ACPI_DECLARE(name, compat, fn)
> >> +#endif
> > This hammers down the world to compile one binary for ACPI
> > and one binary for device tree. Maybe that's fine, I don't know.
> 
> This is a problem we can have some discussion on it.
> I prefer mutually exclusive ACPI and DT support.

A lot of work has been put into making a single kernel boot everywhere.
It's forced duplicated code to be factored out, and it's made the kernel
more flexible. While it has been painful, it's forced a far higher
quality standard across the board(s).

Having a separate ACPI-capable or DT-capable kernels goes completely
against that, and it's completely broken:

* It doubles the testing effort required for a particular kernel. I can
  guarantee that we will miss bugs (even amazingly bad build bugs)
  because no-one will be able to test a full suite of kernels.

* It introduces the possibility of completely pointles arbitrary
  differences between the two. How long until we see the first bug-fix
  that only works in one configuration?

* It creates additional work for distributions, which need to build more
  kernels test them, distribute them, and document which platforms which
  kernels are supported on. This creates more pain for end-users too.
  
Eventually we _will_ get fed up with all of those, and we'll have to do
painful invasive work to make the kernel decide at runtime.

Having separate kernels is a lazy shortcut. It's painful for everyone,
leads to a greater maintenance overhead, it's not what we want now and
not what we want in future.

No thanks.

Either the kernel figures out whether or not to deal with ACPI at
runtime, or it doesn't deal with it at all.

Thanks,
Mark.
