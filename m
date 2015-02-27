From: will.deacon@arm.com (Will Deacon)
Date: Fri, 27 Feb 2015 19:53:23 +0000
Subject: [RFC PATCH] arm64: Implement cpu_relax as yield
In-Reply-To: <CAEgOgz6Ld3r2p=j2LnaDOo+s1WxeVkgBTG9nwFW3JSyrn6WYwA@mail.gmail.com>
References: <1424819257-22664-1-git-send-email-peter.crosthwaite@xilinx.com>
 <20150225132437.GD12377@arm.com>
 <CAEgOgz6Ld3r2p=j2LnaDOo+s1WxeVkgBTG9nwFW3JSyrn6WYwA@mail.gmail.com>
Message-ID: <20150227195323.GC24818@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 27, 2015 at 07:43:27PM +0000, Peter Crosthwaite wrote:
> On Wed, Feb 25, 2015 at 5:24 AM, Will Deacon <will.deacon@arm.com> wrote:
> > On Tue, Feb 24, 2015 at 11:07:37PM +0000, Peter Crosthwaite wrote:
> >> ARM64 has the yield nop hint which has the intended semantics of
> >> cpu_relax. Implement.
> >>
> >> The immediate application is ARM CPU emulators. An emulator can take
> >> advantage of the yield hint to de-prioritise an emulated CPU in favor
> >> of other emulation tasks. QEMU A64 SMP emulation has yield awareness,
> >> and sees a significant boot time performance increase with this change.
> >
> > Could you elaborate on the QEMU SMP boot case please? Usually SMP pens
> > for booting make use of wfe/sev to minimise the spinning overhead.
> >
> 
> So I did some follow up experiments. With my patch applied I started
> trapping instances of cpu_relax (now yielding) in gdb. I then
> commented out the cpu_relax's one by one.
> 
> This one seems to be the key:
> 
> diff --git a/kernel/smp.c b/kernel/smp.c
> index f38a1e6..1c692be 100644
> --- a/kernel/smp.c
> +++ b/kernel/smp.c
> @@ -108,7 +108,8 @@ void __init call_function_init(void)
>  static void csd_lock_wait(struct call_single_data *csd)
>  {
>         while (csd->flags & CSD_FLAG_LOCK)
> -               cpu_relax();
> +               ;
> +               //cpu_relax();
>  }
> 
> Hack above causes boot time delay even with my patch applied, so this
> is causing my issue it seems.

Ok; I was wondering whether this was going to be part of the bootloader, but
as it's not and this feature is useful to you, then feel free to add my:

  Acked-by: Will Deacon <will.deacon@arm.com>

to your original patch.

Thanks,

Will
