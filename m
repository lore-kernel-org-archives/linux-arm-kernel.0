From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 5 Sep 2014 13:13:16 +0100
Subject: [PATCH] ARM: /proc/cpuinfo: Use DT machine name when possible
In-Reply-To: <201409051338.40988@pali>
References: <1403110464-29646-1-git-send-email-pali.rohar@gmail.com>
 <201409051338.40988@pali>
Message-ID: <20140905121316.GI30401@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 05, 2014 at 01:38:40PM +0200, Pali Roh?r wrote:
> On Wednesday 18 June 2014 18:54:24 Pali Roh?r wrote:
> > Machine name from board description is some generic name on DT
> > kernel. DT provides machine name property which is specific
> > for board, so use it instead generic one when possible.
> > 
> > Signed-off-by: Pali Roh?r <pali.rohar@gmail.com>
> > ---
> >  arch/arm/kernel/setup.c |    7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
> > index 8a16ee5..fbc7b4f 100644
> > --- a/arch/arm/kernel/setup.c
> > +++ b/arch/arm/kernel/setup.c
> > @@ -875,10 +875,13 @@ void __init setup_arch(char **cmdline_p)
> > 
> >  	setup_processor();
> >  	mdesc = setup_machine_fdt(__atags_pointer);
> > -	if (!mdesc)
> > +	if (mdesc)
> > +		machine_name = of_flat_dt_get_machine_name();
> > +	else
> >  		mdesc = setup_machine_tags(__atags_pointer,
> > __machine_arch_type); machine_desc = mdesc;
> > -	machine_name = mdesc->name;
> > +	if (!machine_name)
> > +		machine_name = mdesc->name;
> > 
> >  	if (mdesc->reboot_mode != REBOOT_HARD)
> >  		reboot_mode = mdesc->reboot_mode;
> 
> So, do you really want to break userspace which reading file 
> /proc/cpuinfo (after migration from boardcode --> DT)?
> 
> I still do not see reason for that. And only this one file is 
> problematic...

Sorry, I just don't give a damn about your whinging about this.  I've
made the situation perfectly clear.  Your patch will not be accepted.

Thanks.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
