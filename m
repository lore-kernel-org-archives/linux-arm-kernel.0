From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 15 Nov 2017 08:50:10 +0100
Subject: [PATCH 02/10] dmaengine: virt-dma: Support for race free transfer
 termination
In-Reply-To: <20171114143212.8311-3-peter.ujfalusi@ti.com>
References: <20171114143212.8311-1-peter.ujfalusi@ti.com>
 <20171114143212.8311-3-peter.ujfalusi@ti.com>
Message-ID: <CACRpkdZcs0hjcmXcaRwr_+6fEH_PLxPDwVhL0Wm9LE1cRjE3MA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 14, 2017 at 3:32 PM, Peter Ujfalusi <peter.ujfalusi@ti.com> wrote:

> Even with the introduced vchan_synchronize() we can face race when
> terminating a cyclic transfer.
>
> If the terminate_all is called after the interrupt handler called
> vchan_cyclic_callback(), but before the vchan_complete tasklet is called:
> vc->cyclic is set to the cyclic descriptor, but the descriptor itself was
> freed up in the driver's terminate_all() callback.
> When the vhan_complete() is executed it will try to fetch the vc->cyclic
> vdesc, but the pointer is pointing now to uninitialized memory leading to
> (hard to reproduce) kernel crash.
>
> In order to fix this, drivers should:
> - call vchan_terminate_vdesc() from their terminate_all callback instead
> calling their free_desc function to free up the descriptor.
> - implement device_synchronize callback and call vchan_synchronize().
>
> This way we can make sure that the descriptor is only going to be freed up
> after the vchan_callback was executed in a safe manner.
>
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
