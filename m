From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 15 Oct 2012 09:45:08 +0800
Subject: [PATCH] ARM: imx6q: remove imx_src_prepare_restart() call
In-Reply-To: <20121013180512.24ac6c59@wker>
References: <1345180316-9209-1-git-send-email-shawn.guo@linaro.org>
 <20121013180512.24ac6c59@wker>
Message-ID: <20121015014503.GA24393@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 13, 2012 at 06:05:12PM +0200, Anatolij Gustschin wrote:
> Hi Shawn,
> 
> On Fri, 17 Aug 2012 13:11:56 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Currently, imx_src_prepare_restart which is called by imx6q_restart
> > assumes that cpu0 must be the running cpu, so it disables all secondary
> > cpus.  However this is not the case, the restart routine could possibly
> > running on cpu1 or any other secondary cores.  In that case, disabling
> > the cpu that runs restart routine will hang up system.
> > 
> > Also it turns out that everything that is done by imx_src_prepare_restart
> > is not really necessary, because the watchdog reset will have those
> > registers reset properly.  So let's remove the imx_src_prepare_restart
> > call completely.
> 
> What is the fate of this patch?
> 
Discarded.

Further testing suggests that imx_src_prepare_restart call is needed,
otherwise secondary cores will fail to come online, though system
reboot works with core0.

The issue has been solved at kernel core level by the following patch.

  a985941 kernel/sys.c: call disable_nonboot_cpus() in kernel_restart()

Shawn
