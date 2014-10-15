From: balbi@ti.com (Felipe Balbi)
Date: Wed, 15 Oct 2014 12:08:32 -0500
Subject: [PATCH 00/12] rtc: omap: fixes and power-off feature
In-Reply-To: <20141015170628.GA13824@localhost>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <20141015165452.GB15770@saruman> <20141015170628.GA13824@localhost>
Message-ID: <20141015170832.GD15770@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 15, 2014 at 07:06:28PM +0200, Johan Hovold wrote:
> On Wed, Oct 15, 2014 at 11:55:02AM -0500, Felipe Balbi wrote:
> > Hi,
> > 
> > On Thu, Oct 09, 2014 at 09:06:22PM +0200, Johan Hovold wrote:
> > > This series fixes a few issues with the omap rtc-driver, cleans up a bit
> > > and finally adds support for the PMIC control feature found in some
> > > revisions of this RTC IP block.
> > > 
> > > Ultimately, this allows for powering off the Beaglebone and waking it up
> > > again on RTC alarms.
> > > 
> > > I noticed yesterday that Lokesh Vutla recently posted some patches to
> > > add regulator support to this driver. [1] While that series has some
> > > issues that needs to be addressed, I still think it could be a good idea
> > > to rebase my pmic_power_en patch on top of it as it adds some long
> > > overdue device abstraction. That would be needed anyway in order to
> > > support the new power-off infrastructure that's in the pipe in a clean
> > > way. [2]
> > > 
> > > So my suggestion is to merge the first seven patches, rebase Lokesh
> > > series on top of that, and then I rebase my final five patches on top
> > > of that in turn. Hopefully, the new power-off handler call chain will
> > > have stabilised by then.
> > 
> > BTW, how do you test this series ?
> 
> Set a 30 second wakealarm using the sysfs attribute of the rtc class
> device and power off the BBB:
> 
> 	echo +30 >wakealarm; poweroff

sweet!!!! It worked just fine :-)

Too bad there's yet another DRM bug:

[  271.150158] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[  271.150158] 
[  271.159725] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 3.17.0-08392-g7fe2269-dirty #326
[  271.168567] [<c00175a4>] (unwind_backtrace) from [<c00132f0>] (show_stack+0x20/0x24)
[  271.176668] [<c00132f0>] (show_stack) from [<c06573a4>] (dump_stack+0x8c/0xa4)
[  271.184215] [<c06573a4>] (dump_stack) from [<c0654f10>] (panic+0xa0/0x220)
[  271.191405] [<c0654f10>] (panic) from [<c0049e54>] (do_exit+0x974/0x9d0)
[  271.198410] [<c0049e54>] (do_exit) from [<c0067694>] (SyS_reboot+0x14c/0x1e8)
[  271.205870] [<c0067694>] (SyS_reboot) from [<c000f080>] (ret_fast_syscall+0x0/0x48)
[  271.214023] drm_kms_helper: panic occurred, switching back to text console
[  271.221312] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

In any case, board still powered up after 30 seconds(-ish). So this gets
a:

Tested-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141015/828ceb03/attachment-0001.sig>
