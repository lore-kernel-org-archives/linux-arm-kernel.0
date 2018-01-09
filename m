From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 9 Jan 2018 13:01:58 -0200
Subject: arm: Is VFP hotplug notifiers wrong?
In-Reply-To: <104db10119fd453ba38edac32a228ab6@JPA000SECMN21.palet.jp.panasonic.com>
References: <20180109.201221.1319754994300492102.okuno.kohji@jp.panasonic.com>
 <20180109114048.GF17719@n2100.armlinux.org.uk>
 <alpine.DEB.2.20.1801091457210.1766@nanos>
 <104db10119fd453ba38edac32a228ab6@JPA000SECMN21.palet.jp.panasonic.com>
Message-ID: <CAOMZO5BKanS2xuAvG8i=JHY3zEaCWN4doyvB5o6HDEx++MYQwQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Okuno,

On Tue, Jan 9, 2018 at 12:46 PM,  <okuno.kohji@jp.panasonic.com> wrote:
> Dear Russel and Thomas,
>
> Thank you for your quick response.
> Thomas, do you create the patch?

Looks like the fix should be like this:

--- a/arch/arm/vfp/vfpmodule.c
+++ b/arch/arm/vfp/vfpmodule.c
@@ -648,7 +648,7 @@ int vfp_restore_user_hwstate(struct user_vfp __user *ufp,
  */
 static int vfp_dying_cpu(unsigned int cpu)
 {
-       vfp_force_reload(cpu, current_thread_info());
+       vfp_current_hw_state[cpu] = NULL;
        return 0;
 }

Could you please test it?

Thanks
