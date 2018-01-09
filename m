From: okuno.kohji@jp.panasonic.com (okuno.kohji at jp.panasonic.com)
Date: Tue, 9 Jan 2018 22:51:41 +0000
Subject: arm: Is VFP hotplug notifiers wrong?
In-Reply-To: <CAOMZO5BKanS2xuAvG8i=JHY3zEaCWN4doyvB5o6HDEx++MYQwQ@mail.gmail.com>
References: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
 <20180109114048.GF17719@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1801091457210.1766@nanos>
 <104db10119fd453ba38edac32a228ab6@JPA000SECMN21.palet.jp.panasonic.com>
 <CAOMZO5BKanS2xuAvG8i=JHY3zEaCWN4doyvB5o6HDEx++MYQwQ@mail.gmail.com>
Message-ID: <bac2069cb92a4294a0fa15df5be69c97@JPA000SECMN21.palet.jp.panasonic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Fabio and Russel,

Fabio, thank you for providing your patch. It should be work good.
Unfortunately, I do not have an environment to try out the latest kernel right now.
Indeed, I encountered the issue(*) for VFP in using kernel 3.10.x. Then, I noticed the problem at the master.
kernel 3.10.x does not introduce this fix.

(*) Under certain conditions, VFP registers becomes undefined values after resume.
   - a last thread using VFP before suspend was executed by CPU other than CPU#0
   - the first thread using VFP after resume was the same thread as above,
     and, the thread was executed on the same CPU as before suspend.

Best regards,
 Kohji Okuno

> -----Original Message-----
> From: Fabio Estevam [mailto:festevam at gmail.com]
> Sent: Wednesday, January 10, 2018 12:02 AM
> To: Okuno Kohji (?? ??)
> Cc: Thomas Gleixner; Russell King - ARM Linux; moderated list:ARM/FREESCALE
> IMX / MXC ARM ARCHITECTURE
> Subject: Re: arm: Is VFP hotplug notifiers wrong?
> 
> Hi Okuno,
> 
> On Tue, Jan 9, 2018 at 12:46 PM,  <okuno.kohji@jp.panasonic.com> wrote:
> > Dear Russel and Thomas,
> >
> > Thank you for your quick response.
> > Thomas, do you create the patch?
> 
> Looks like the fix should be like this:
> 
> --- a/arch/arm/vfp/vfpmodule.c
> +++ b/arch/arm/vfp/vfpmodule.c
> @@ -648,7 +648,7 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
>   */
>  static int vfp_dying_cpu(unsigned int cpu)  {
> -       vfp_force_reload(cpu, current_thread_info());
> +       vfp_current_hw_state[cpu] = NULL;
>         return 0;
>  }
> 
> Could you please test it?
> 
> Thanks
