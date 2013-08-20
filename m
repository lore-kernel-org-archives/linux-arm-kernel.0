From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 20 Aug 2013 18:14:53 +0100
Subject: [PATCH] arm64: add screen_info for console support
In-Reply-To: <20130820133733.GF26129@mudshark.cambridge.arm.com>
References: <1376842970.11104.11.camel@t520.redhat.com>
 <20130820133733.GF26129@mudshark.cambridge.arm.com>
Message-ID: <20130820171453.GF21383@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 20, 2013 at 02:37:33PM +0100, Will Deacon wrote:
> Hi Mark,
> 
> On Sun, Aug 18, 2013 at 05:22:50PM +0100, Mark Salter wrote:
> > The arm64 port doesn't provide a screen_info struct for console support
> > which leads to a build failure with some configurations:
> > 
> >   drivers/video/console/vgacon.c:820: undefined reference to `screen_info'
> > 
> > This patch adds an empty declaration of screen_info to fix the build
> > problem. Some additional runtime code is needed to actually make it
> > useful.
> > 
> > Signed-off-by: Mark Salter <msalter@redhat.com>
> > ---
> >  arch/arm64/kernel/setup.c | 4 ++++
> >  1 file changed, 4 insertions(+)
> > 
> > diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> > index add6ea6..eb9f93a 100644
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -64,6 +64,10 @@ static const char *cpu_name;
> >  static const char *machine_name;
> >  phys_addr_t __fdt_pointer __initdata;
> >  
> > +#if defined(CONFIG_VGA_CONSOLE) || defined(CONFIG_DUMMY_CONSOLE)
> > +struct screen_info screen_info;
> > +#endif
> 
> You may be able to do something similar to the proposal for PARPORT here and
> factor out the lengthy "depends on" clause for VGA_CONSOLE instead of adding
> the dummy info.

I was wondering about this but do we need screen_info for DUMMY_CONSOLE
as well?

-- 
Catalin
