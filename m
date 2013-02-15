From: balbi@ti.com (Felipe Balbi)
Date: Fri, 15 Feb 2013 18:03:28 +0200
Subject: [RFC/NOT FOR MERGING 2/3] serial: omap: remove hwmod dependency
In-Reply-To: <87obfl60x7.fsf@linaro.org>
References: <1360840554-26901-1-git-send-email-balbi@ti.com>
 <1360840554-26901-2-git-send-email-balbi@ti.com>
 <87obfl60x7.fsf@linaro.org>
Message-ID: <20130215160328.GA20334@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Feb 15, 2013 at 07:40:04AM -0800, Kevin Hilman wrote:
> Felipe Balbi <balbi@ti.com> writes:
> 
> > Currently the omap-serial driver will not
> > work properly if booted via DT with CPUIDLE
> > enabled because it depends on function pointers
> > provided by hwmod to change its own SYSCONFIG
> > register.
> >
> > Remove that relyance on hwmod by moving SYSCONFIG
> > handling to driver itself. Note that this also
> > fixes a possible corner case bug where we could
> > be putting UART in Force Idle mode if we called
> > omap_serial_enable_wakeup(up, false) after setting
> > NOIDLE to the idle mode. This is because hwmod
> > has no protection against that situation.
> >
> > NYET-Signed-off-by: Felipe Balbi <balbi@ti.com>
> 
> Here's another approach to getting rid of the sysconfig twiddling in the
> driver.  I wrote this some time ago at my former company ;) but don't
> think I ever got around to posting it.
> 
> It doesn't solve the whole problem (e.g. doesn't address the
> context_loss or enable_wakeup func pointers), but at least gets rid of
> the need for any SYSCONFIG access in the driver for the idle modes.

wakeup is still done by setting smart_idle_wakeup right, at least to
some IPs. Following omap_serial_enable_wakeup() calls, I can see that it
turns out to fiddle with sysconfig ;-)

> @@ -229,8 +209,6 @@ static void serial_omap_stop_tx(struct uart_port *port)
>  		serial_out(up, UART_IER, up->ier);
>  	}
>  
> -	serial_omap_set_forceidle(up);
> -
>  	pm_runtime_mark_last_busy(up->dev);
>  	pm_runtime_put_autosuspend(up->dev);
>  }
> @@ -298,7 +276,6 @@ static void serial_omap_start_tx(struct uart_port *port)
>  
>  	pm_runtime_get_sync(up->dev);
>  	serial_omap_enable_ier_thri(up);
> -	serial_omap_set_noidle(up);

this is no different then the patches Santosh has sent just a few
minutes ago, what gives ? It's exactly the same patch...

Anyway, I have exposed a problem with this aproach.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130215/36013e1f/attachment.sig>
