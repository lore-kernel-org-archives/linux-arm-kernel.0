From: balbi@ti.com (Felipe Balbi)
Date: Fri, 24 Oct 2014 11:08:45 -0500
Subject: [PATCH v2 00/20] rtc: omap: fixes and power-off feature
In-Reply-To: <1413913086-12730-1-git-send-email-johan@kernel.org>
References: <1412881594-25678-1-git-send-email-johan@kernel.org>
 <1413913086-12730-1-git-send-email-johan@kernel.org>
Message-ID: <20141024160845.GM26941@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Oct 21, 2014 at 07:37:46PM +0200, Johan Hovold wrote:
> This series fixes a few issues with the omap rtc-driver, cleans up a
> bit, adds device abstraction, and finally adds support for the PMIC
> control feature found in some revisions of this RTC IP block.
> 
> Ultimately, this allows for powering off the Beaglebone and waking it up
> again on RTC alarms.
> 
> Changes since v1 include:
> 
>  - add device abstraction
>  - add structured device-type info
>  - fix interrupt disable at probe separately
>  - register interrupts after class device as before
>  - add helper to read raw bcd time
>  - more clean ups
>  - add copyright entry
>  - enable pmic control only for Beaglebone Black
> 
> I realised that it was better to keep this patch series self-contained
> and include the device abstraction in it, rather than rely on some
> patches yet to be posted (contrary to what I proposed in v1). It should
> now be straight forward to add deferred-probing and regulator support on
> top of this series instead. [1]
> 
> I've kept Felipe's Reviewed-by tags only on the first and last couple of
> patches which have not changed (in any significant way).
> 
> For the record, the new functionality is easily tested on BBB with:
> 
> 	echo +30 >/sys/class/rtc/rtc0/wakealarm; poweroff
> 
> There are some patches floating around to add power-off handler
> call chains [2] as well as an RFC for a generic "poweroff-source"
> property [3]. Since it is unclear if, when (and through which tree) this
> will eventually go in, I suggest merging this series as-is now and do
> the trivial updates to use these new interfaces once the infrastructure
> is in place.

I tested this entire series with my BBB and it still works fine. However
I still get below panic. This time without any DRM errors:

[   63.087832] Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
[   63.087832] 
[   63.097399] CPU: 0 PID: 1 Comm: systemd-shutdow Not tainted 3.18.0-rc1-00095-g8524e69 #556
[   63.106060] [<c00175a4>] (unwind_backtrace) from [<c00132f0>] (show_stack+0x20/0x24)
[   63.114160] [<c00132f0>] (show_stack) from [<c0657404>] (dump_stack+0x8c/0xa4)
[   63.121706] [<c0657404>] (dump_stack) from [<c0654f70>] (panic+0xa0/0x220)
[   63.128895] [<c0654f70>] (panic) from [<c0049e64>] (do_exit+0x974/0x9d0)
[   63.135900] [<c0049e64>] (do_exit) from [<c006775c>] (SyS_reboot+0x14c/0x1e8)
[   63.143361] [<c006775c>] (SyS_reboot) from [<c000f080>] (ret_fast_syscall+0x0/0x48)
[   63.151596] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000

Then again, this also happens by simply calling poweroff without
enabling wakealarm.

In any case, for the whole series:

Tested-by: Felipe Balbi <balbi@ti.com>


-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141024/0e8c1969/attachment.sig>
