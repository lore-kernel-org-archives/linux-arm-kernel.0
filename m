From: richard.zhao@freescale.com (Richard Zhao)
Date: Wed, 29 Aug 2012 16:22:55 +0800
Subject: [PATCH v2 04/11] USB: chipidea: clear gadget struct at udc_start
 fail path
In-Reply-To: <87y5kyjfa3.fsf@ashishki-desk.ger.corp.intel.com>
References: <1346137397-32374-1-git-send-email-richard.zhao@freescale.com>
 <1346137397-32374-5-git-send-email-richard.zhao@freescale.com>
 <87oblv2zdc.fsf@ashishki-desk.ger.corp.intel.com>
 <20120828090942.GX4011@b20223-02.ap.freescale.net>
 <87y5kyjfa3.fsf@ashishki-desk.ger.corp.intel.com>
Message-ID: <20120829082254.GH4011@b20223-02.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2012 at 11:03:48AM +0300, Alexander Shishkin wrote:
> Richard Zhao <richard.zhao@freescale.com> writes:
> 
> > On Tue, Aug 28, 2012 at 11:29:35AM +0300, Alexander Shishkin wrote:
> >> Richard Zhao <richard.zhao@freescale.com> writes:
> >> 
> >> > States in gadget are not needed any more, set it to zero.
> >> 
> >> It's generally a good practice to mention in the commit message what is
> >> it that you are fixing with this patch.
> > It fixes the following dump if udc_start register gadget->dev but fail
> > the start process:
> > kobject (bf8330a0): tried to init an initialized object, something is seriously wrong.
> > [<80011d90>] (dump_backtrace+0x0/0x10c) from [<804b65ac>] (dump_stack+0x18/0x1c)
> > [<804b6594>] (dump_stack+0x0/0x1c) from [<80247d98>] (kobject_init+0x7c/0x9c)
> > [<80247d1c>] (kobject_init+0x0/0x9c) from [<802a3870>] (device_initialize+0x28/0x70)
> > [<802a3848>] (device_initialize+0x0/0x70) from [<802a4798>] (device_register+0x14/0x20)
> > [<802a4784>] (device_register+0x0/0x20) from [<80359a70>] (udc_start+0x180/0x2c8)
> > [<803598f0>] (udc_start+0x0/0x2c8) from [<80356e9c>] (ci_role_work+0xc8/0xec)
> > [<80356dd4>] (ci_role_work+0x0/0xec) from [<8003a8a0>] (process_one_work+0x158/0x474)
> > [<8003a748>] (process_one_work+0x0/0x474) from [<8003af6c>] (worker_thread+0x140/0x3b4)
> > [<8003ae2c>] (worker_thread+0x0/0x3b4) from [<8003fe60>] (kthread+0x90/0x9c)
> > [<8003fdd0>] (kthread+0x0/0x9c) from [<8002774c>] (do_exit+0x0/0x350)
> >> 
> >> > Signed-off-by: Richard Zhao <richard.zhao@freescale.com>
> >> > ---
> >> >  drivers/usb/chipidea/udc.c |    1 +
> >> >  1 file changed, 1 insertion(+)
> >> >
> >> > diff --git a/drivers/usb/chipidea/udc.c b/drivers/usb/chipidea/udc.c
> >> > index c7a032a..9fb6394 100644
> >> > --- a/drivers/usb/chipidea/udc.c
> >> > +++ b/drivers/usb/chipidea/udc.c
> >> > @@ -1746,6 +1746,7 @@ free_pools:
> >> >  	dma_pool_destroy(ci->td_pool);
> >> >  free_qh_pool:
> >> >  	dma_pool_destroy(ci->qh_pool);
> >> > +	memset(&ci->gadget, 0, sizeof(ci->gadget));
> >> 
> >> I understand that you're probably hitting "kobject already initialized"
> >> warning here, but I think the real problem is that this function gets
> >> called twice and fails the first time. Why does that happen?
> > I saw the dump at early stage of adding imx otg support, when there's
> > things not ready. I think it's less important why udc_start fail,
> > because no one enable imx otg before.  It's important when it fails,
> > the dump shows up.
> 
> I'd prefer that whenever udc_start() fails it doesn't go unnoticed,
> except probably for the cases when it fails due to transceiver not being
> ready at the probe time, which needs to be handled separately.
Is it related to the patch? The patch is logically right that reset the
status, agree?

Thanks
Richard
> 
> Regards,
> --
> Alex
> 
