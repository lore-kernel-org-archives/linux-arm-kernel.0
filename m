From: balbi@ti.com (Felipe Balbi)
Date: Mon, 5 Jan 2015 20:10:05 -0600
Subject: [PATCH 2/3] soc: ti: Add wkup_m3_ipc driver
In-Reply-To: <54AB14E4.2010607@ti.com>
References: <1420228817-41310-1-git-send-email-d-gerlach@ti.com>
 <1420228817-41310-3-git-send-email-d-gerlach@ti.com>
 <20150102201643.GE4920@saruman> <54AB14E4.2010607@ti.com>
Message-ID: <20150106021005.GC24980@saruman>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 05, 2015 at 04:49:08PM -0600, Dave Gerlach wrote:
> >> +	/*
> >> +	 * Write a dummy message to the mailbox in order to trigger the RX
> >> +	 * interrupt to alert the M3 that data is available in the IPC
> >> +	 * registers. We must enable the IRQ here and disable it after in
> >> +	 * the RX callback to avoid multiple interrupts being received
> >> +	 * by the CM3.
> >> +	 */
> >> +	omap_mbox_enable_irq(m3_ipc_state.mbox, IRQ_RX);
> >> +	ret = mbox_send_message(m3_ipc_state.mbox, (void *)dummy_msg);
> > 
> > unnecessary cast.
> 
> I get a compiler warning without this one, may need it.

right, try with:

	ret = mbox_send_mesage(m3->mbox, &dummy_msg);

Another option is to just get rid of mbox_msg_t altogether since that's
just a u32 anyway. Then fix omap-mailbox.c::omap_mbox_chan_send_data()
so it knows it's receiving a void *, then it could:

	u32 data = *(u32 *)mssg;

but as Tony said, better not to add more dependencies to this series.

> >> +	m3_rproc = rproc_get_by_phandle(rproc_phandle);
> >> +	if (!m3_rproc) {
> >> +		dev_err(&pdev->dev, "could not get rproc handle\n");
> >> +		ret = -EPROBE_DEFER;
> >> +		goto err;
> >> +	}
> >> +
> >> +	m3_ipc_state.rproc = m3_rproc;
> >> +	m3_ipc_state.dev = dev;
> >> +	m3_ipc_state.state = M3_STATE_RESET;
> >> +
> >> +	/*
> >> +	 * Wait for firmware loading completion in a thread so we
> >> +	 * can boot the wkup_m3 as soon as it's ready without holding
> >> +	 * up kernel boot
> >> +	 */
> >> +	task = kthread_run((void *)wkup_m3_rproc_boot_thread, m3_rproc,
> >> +			   "wkup_m3_rproc_loader");
> > 
> > I wonder two things:
> > 
> > 1) This thread will only be used during boot up. Do we really need a
> > thread or would request_firmware_nowait() be enough ?
> > 
> > 2) what's the size of the firmware ? Is it really so large that we must
> > run this as a separate thread ? Meaning, why isn't request_firmware()
> > enough ? How much time would we be waiting ?
> 
> The issue here comes from the case where you attempt to load a firmware stored
> in the rootfs which is the typical use case for this. Remoteproc core requests
> the firmware twice, first with _nowait to load the resource table and then again

sounds like a bug to me. Or am I missing something ?

> without nowait to boot the rproc. rproc_boot requires the resource table to be
> loaded. The thread is really to wait for the firmware loaded completion, which
> gets set after the resource table has been loaded, to let boot proceed. System
> boot will get stuck otherwise as this driver can probe before rootfs is available.

IMO, that should be fixed in remoteproc, but it probably goes towards
"let's not add more dependencies".

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150105/855bbdb1/attachment.sig>
