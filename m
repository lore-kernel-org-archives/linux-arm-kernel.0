From: balbi@ti.com (Felipe Balbi)
Date: Mon, 18 Feb 2013 12:45:41 +0200
Subject: [RFC/RFT PATCH 0/2] SERIAL: OMAP: Remove idle handling from driver
In-Reply-To: <20130218104216.GC32688@arwen.pp.htv.fi>
References: <1360929970-31934-1-git-send-email-santosh.shilimkar@ti.com>
 <5121FCC8.7090604@ti.com> <20130218101032.GA32688@arwen.pp.htv.fi>
 <20130218101113.GB32688@arwen.pp.htv.fi> <5122019D.9030100@ti.com>
 <20130218104216.GC32688@arwen.pp.htv.fi>
Message-ID: <20130218104541.GD32688@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 18, 2013 at 12:42:16PM +0200, Felipe Balbi wrote:
> Hi,
> 
> On Mon, Feb 18, 2013 at 03:55:33PM +0530, Santosh Shilimkar wrote:
> > >>I wonder what are your ideas to sort that part out, I mean, how do you
> > >>plan to implement ->set_wake() for the tty port ?"
> > >
> > >[1] http://marc.info/?l=linux-omap&m=136093334914275&w=2
> > >
> > The main need for uart wakeup is the io_ring() trigger and that needs
> > to happen via generic pin control API. SYSC wakeup bit isn't something
> > needs to be toggled so that can be decoupled. So again the idea is
> > to make SYSC handling transparent to UART drivers and let driver toggle
> > the io_ring() based on ->set_wake() as it is done today.
> 
> We're either reading different code bases or not understanding each
> other. Currently this is how ->set_wake() is implemented:
> 
> serial_omap_set_wake()
>  serial_omap_enable_wakeup()
>   omap_uart_enable_wakeup()
>    omap_hwmod_enable_wakeup()
>     if (SYSC_HAS_ENAWAKEUP) {	/* true for UART */
>      _enable_wakeup()
>      _write_sysconfig()
>     }
>     set_idle_ioring_wakeup()
>      if (!oh->mux || !oh->mux->enabled)
>       return;
> 
> If I read the code correctly there's nothing setting oh->mux during DT
> boot. The only caller to omap_hwmod_mux_init() (which allocates and
> returns omap_hwmod_mux_info pointer) is
> arch/arm/mach-omap2/devices.c::omap4_keyboard_init(). This has nothing

actually arch/arm/mach-omap2/serial.c::omap_serial_init_port() also
calls that, but it's also not used during DT boots.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130218/9f1b7bf9/attachment.sig>
