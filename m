From: horms@verge.net.au (Simon Horman)
Date: Wed, 31 Jul 2013 10:04:04 +0900
Subject: ARM CPU Hotplug breakage on mach-shmobile and KZM9D
In-Reply-To: <51F7CD67.6020209@windriver.com>
References: <CANqRtoRx7voEVwJG8UNNy_Jiixo=uRJCvxTD0bZdzVohoryBUA@mail.gmail.com>
 <20130725010607.GB31464@verge.net.au>
 <20130730074939.GE7210@verge.net.au>
 <51F7CD67.6020209@windriver.com>
Message-ID: <20130731010404.GJ17209@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 30, 2013 at 10:27:51AM -0400, Paul Gortmaker wrote:
> On 13-07-30 03:49 AM, Simon Horman wrote:
> > [ Cc Paul Gortmaker ]
> > 
> > On Thu, Jul 25, 2013 at 10:06:07AM +0900, Simon Horman wrote:
> >> On Thu, Jul 25, 2013 at 12:15:49AM +0900, Magnus Damm wrote:
> >>> Hi everyone,
> >>>
> >>> Bad news: CPU Hotplug on KZM9D seems broken on recent kernels.
> >>>
> >>> On renesas-next-20130710 or earlier I can perform the following:
> >>>
> >>> # echo 0 > /sys/devices/system/cpu/cpu1/online
> >>> CPU1: shutdown
> >>> # echo 1 > /sys/devices/system/cpu/cpu1/online
> >>> CPU1: Booted secondary processor
> >>> #
> >>>
> >>> While on more recent kernels the hotplug boot fails. This may be
> >>> related to the move to v3.11-rc. The tag renesas-next-20130710
> >>> surprisingly seems to be the final kernel based on v3.10-rc before
> >>> jumping to v3.11-rc.
> >>>
> >>> I wonder, do other ARM platforms have working CPU Hotplug in v3.11-rc?
> >>
> >> I have a snowball that I could test if you think it would be useful.
> > 
> > Unfortunately getting snowball to work turned out to be rather painful.
> > So instead I bisected the problem on the KZM9G (N.b: the D in the subject
> > seems to be incorrect :^)
> > 
> > The result is that the following patch, added in v3.11-rc1,
> > appears to be the culprit.
> 
> Double check that you have this commit present:
>  ---------------
> commit 8c69d7af12265e5be9326110b695e010b47505bd
> Author: Stephen Warren <swarren@nvidia.com>
> Date:   Fri Jul 5 22:59:42 2013 +0100
> 
>     ARM: 7780/1: add missing linker section markup to head-common.S
>  ---------------
> 
> as I think you are reporting the same problem that it fixed.

Unfortunately that does not seem to resolve the problem that I am seeing.
I have tried both v3.11-rc3 and 22f0a27367742f65130c0fb25ef00f7297e032c1
with 8c69d7af12265e5be9326110b695e010b47505bd cherry picked on top and
in both cases I see:

# echo 0 > /sys/devices/system/cpu/cpu1/online
CPU1: shutdown
# echo 1 > /sys/devices/system/cpu/cpu1/online
CPU1: failed to come online

> Thanks,
> Paul.
> --
> 
> > 
> > commit 22f0a27367742f65130c0fb25ef00f7297e032c1
> > Author: Paul Gortmaker <paul.gortmaker@windriver.com>
> > Date:   Mon Jun 17 18:34:14 2013 -0400
> > 
> >     init.h: remove __cpuinit sections from the kernel
> >     
> >     The __cpuinit type of throwaway sections might have made sense
> >     some time ago when RAM was more constrained, but now the savings
> >     do not offset the cost and complications.  For example, the fix in
> >     commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> >     is a good example of the nasty type of bugs that can be created
> >     with improper use of the various __init prefixes.
> >     
> >     After a discussion on LKML[1] it was decided that cpuinit should go
> >     the way of devinit and be phased out.  Once all the users are gone,
> >     we can then finally remove the macros themselves from linux/init.h.
> >     
> >     As an interim step, we can dummy out the macros to be no-ops, and
> >     this will allow us to avoid a giant tree-wide patch, and instead
> >     we can feed in smaller chunks mainly via the arch/ trees.  This
> >     is in keeping with commit 78d86c213f28193082b5d8a1a424044b7ba406f1
> >     ("init.h: Remove __dev* sections from the kernel")
> >     
> >     We don't strictly need to dummy out the macros to do this, but if
> >     we don't then some harmless section mismatch warnings may temporarily
> >     result.  For example, notify_cpu_starting() and cpu_up() are arch
> >     independent (kernel/cpu.c) and are flagged as __cpuinit.  And hence
> >     the calling functions in the arch specific code are also expected
> >     to be __cpuinit -- if not, then we get the section mismatch warning.
> >     
> >     Two of the three __CPUINIT variants are not used whatsoever, and
> >     so they are simply removed directly at this point in time.
> >     
> >     [1] https://lkml.org/lkml/2013/5/20/589
> >     
> >     Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
> > 
> > diff --git a/include/linux/init.h b/include/linux/init.h
> > index 8618147..e73f2b70 100644
> > --- a/include/linux/init.h
> > +++ b/include/linux/init.h
> > @@ -93,13 +93,13 @@
> >  
> >  #define __exit          __section(.exit.text) __exitused __cold notrace
> >  
> > -/* Used for HOTPLUG_CPU */
> > -#define __cpuinit        __section(.cpuinit.text) __cold notrace
> > -#define __cpuinitdata    __section(.cpuinit.data)
> > -#define __cpuinitconst   __constsection(.cpuinit.rodata)
> > -#define __cpuexit        __section(.cpuexit.text) __exitused __cold notrace
> > -#define __cpuexitdata    __section(.cpuexit.data)
> > -#define __cpuexitconst   __constsection(.cpuexit.rodata)
> > +/* temporary, until all users are removed */
> > +#define __cpuinit
> > +#define __cpuinitdata
> > +#define __cpuinitconst
> > +#define __cpuexit
> > +#define __cpuexitdata
> > +#define __cpuexitconst
> >  
> >  /* Used for MEMORY_HOTPLUG */
> >  #define __meminit        __section(.meminit.text) __cold notrace
> > @@ -118,9 +118,8 @@
> >  #define __INITRODATA	.section	".init.rodata","a",%progbits
> >  #define __FINITDATA	.previous
> >  
> > -#define __CPUINIT        .section	".cpuinit.text", "ax"
> > -#define __CPUINITDATA    .section	".cpuinit.data", "aw"
> > -#define __CPUINITRODATA  .section	".cpuinit.rodata", "a"
> > +/* temporary, until all users are removed */
> > +#define __CPUINIT
> >  
> >  #define __MEMINIT        .section	".meminit.text", "ax"
> >  #define __MEMINITDATA    .section	".meminit.data", "aw"
> > 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sh" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
