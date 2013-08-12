From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 12 Aug 2013 11:27:33 -0700
Subject: [PATCH v4 02/31] serial: mpc512x: cleanup clock API use
In-Reply-To: <1375821851-31609-3-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-3-git-send-email-gsi@denx.de>
Message-ID: <20130812182733.GA20233@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 06, 2013 at 10:43:42PM +0200, Gerhard Sittig wrote:
> cleanup the clock API use of the UART driver which is shared among the
> MPC512x and the MPC5200 platforms
> - get, prepare, and enable the MCLK during port allocation; disable,
>   unprepare and put the MCLK upon port release; hold a reference to the
>   clock over the period of use; check for and propagate enable errors
> - fix a buffer overflow for clock names with two digit PSC index numbers
> - stick with the PPC_CLOCK 'psc%d_mclk' name for clock lookup, only
>   switch to a fixed string later after device tree based clock lookup
>   will have become available
> 
> to achieve support for MPC512x which is neutral to MPC5200, the
> modification was done as follows
> - introduce "clock alloc" and "clock release" routines in addition to
>   the previous "clock enable/disable" routine in the psc_ops struct
> - make the clock allocation a part of the port request (resource
>   allocation), and make clock release a part of the port release, such
>   that essential resources get allocated early
> - just enable/disable the clock from within the .clock() callback
>   without any allocation or preparation as the former implementation
>   did, since this routine is called from within the startup and shutdown
>   callbacks
> - all of the above remains a NOP for the MPC5200 platform (no callbacks
>   are provided on that platform)
> - implementation note: the clock gets enabled upon allocation already
>   just in case the clock is not only required for bitrate generation but
>   for register access as well
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
