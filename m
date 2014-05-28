From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 28 May 2014 17:36:12 +0200
Subject: [PATCH] ahci: imx: manage only sata_ref_clk in
 imx_sata_enable[disable]
In-Reply-To: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
References: <1401289539-3485-1-git-send-email-shawn.guo@freescale.com>
Message-ID: <5386026C.1010603@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 05/28/2014 05:05 PM, Shawn Guo wrote:
> Doing suspend/resume on imx6q and imx53 boards with no SATA disk
> attached will trigger the following warning.
> 
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 661 at drivers/ata/libahci.c:224 ahci_enable_ahci+0x74/0x8)
> Modules linked in:
> CPU: 0 PID: 661 Comm: sh Tainted: G        W     3.15.0-rc5-next-20140521-000027
> Backtrace:
> [<80011c90>] (dump_backtrace) from [<80011e2c>] (show_stack+0x18/0x1c)
>  r6:803a22f4 r5:00000000 r4:00000000 r3:00000000
> [<80011e14>] (show_stack) from [<80661e60>] (dump_stack+0x88/0xa4)
> [<80661dd8>] (dump_stack) from [<80028fdc>] (warn_slowpath_common+0x70/0x94)
>  r5:00000009 r4:00000000
> [<80028f6c>] (warn_slowpath_common) from [<80029024>] (warn_slowpath_null+0x24/)
>  r8:808f68c4 r7:00000000 r6:00000000 r5:00000000 r4:e0810004
> [<80029000>] (warn_slowpath_null) from [<803a22f4>] (ahci_enable_ahci+0x74/0x80)
> [<803a2280>] (ahci_enable_ahci) from [<803a2324>] (ahci_reset_controller+0x24/0)
>  r8:ddcd9410 r7:80351178 r6:ddcd9444 r5:dde8b850 r4:e0810000 r3:ddf35e90
> [<803a2300>] (ahci_reset_controller) from [<803a2c68>] (ahci_platform_resume_ho)
>  r7:80351178 r6:ddcd9444 r5:dde8b850 r4:ddcd9410
> [<803a2c30>] (ahci_platform_resume_host) from [<803a38f0>] (imx_ahci_resume+0x2)
>  r5:00000000 r4:ddcd9410
> [<803a38c4>] (imx_ahci_resume) from [<803511ac>] (platform_pm_resume+0x34/0x54)
> ....
> 
> The reason is that the SATA controller has no working clock at this
> point, and thus ahci_enable_ahci() fails to enable the controller.  In
> case that there is no SATA disk attached, the imx_sata_disable() gets
> called in ahci_imx_error_handler(), and both sata_clk and sata_ref_clk
> will be disabled there.  Because all the imx_sata_enable() calls
> afterward will return immediately due to imxpriv->no_device check, the
> SATA controller working clock sata_clk will never get any chance to be
> enabled again.
> 
> This is a regression caused by commit 90870d79d4f2 (ahci-imx: Port to
> library-ised ahci_platform).  Before the commit, only sata_ref_clk is
> managed by the driver in enable/disable function.  But after the commit,
> all the clocks are enabled/disabled in a row by ahci platform helpers
> ahci_platform_enable[disable]_clks.  Since ahb_clk is a bus clock which
> does not have gate at all, and i.MX low-power hardware module already
> manages sata_clk across suspend/resume cycle, the only clock that needs
> to be managed by software is sata_ref_clk.
> 
> So instead of using ahci_platform_enable[disable]_clks to manage all
> the clocks in a row from imx_sata_enable[disable], we should manage
> only sata_ref_clk in there.

I disagree, the problem here is not the clk disable / enable, with
your patch the sata_clk never gets disabled, unless the driver gets unloaded
which clearly is the wrong thing to do.

The real problem is the weird error handling which is unique to
the ahci_imx code where if no disk is present it semi-permanently
shuts down (breaking later hotplug of sata without a reboot).

I assume that this weird error handling is done to save power in the
case no disk is attached. But if that is the case the surely disabling
the sata_clk in this scenario too is the right thing to do.

As for the "ahb_clk is a bus clock which does not have gate at all" argument,
if that were the case then the disabling of the sata_clk would not cause
any issues at all, so I'm not buying that argument.

The proper fix is obvious, if we've shutdown everything due to there
not being a device present at the initial probe, don't call
ahci_platform_resume_host on resume, as is done in the attached patch.

Regards,

Hans
-------------- next part --------------
A non-text attachment was scrubbed...
Name: 0001-ahci_imx-Fix-oops-on-suspend-resume.patch
Type: text/x-patch
Size: 2809 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140528/36aaedd0/attachment-0001.bin>
