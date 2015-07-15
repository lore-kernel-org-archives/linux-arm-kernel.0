From: ludovic.desroches@atmel.com (Ludovic Desroches)
Date: Wed, 15 Jul 2015 15:30:48 +0200
Subject: [PATCH] pinctrl: at91: fix null pointer dereference
In-Reply-To: <1E6EC50F-3896-4EA3-95BC-755E861D5F21@jcrosoft.com>
References: <1435853202-1632-1-git-send-email-davidcdueck@googlemail.com>
 <22EFD5CA-DAA3-46A9-A937-90A0A9C82917@jcrosoft.com>
 <20150713130022.GC21043@odux.rfo.atmel.com>
 <1E6EC50F-3896-4EA3-95BC-755E861D5F21@jcrosoft.com>
Message-ID: <20150715133048.GD14886@odux.rfo.atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 14, 2015 at 04:30:14AM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> 
> > On Jul 13, 2015, at 9:00 PM, Ludovic Desroches <ludovic.desroches@atmel.com> wrote:
> > 
> > On Mon, Jul 13, 2015 at 02:14:51PM +0800, Jean-Christophe PLAGNIOL-VILLARD wrote:
> >> 
> >>> On Jul 3, 2015, at 12:06 AM, David Dueck <davidcdueck@googlemail.com> wrote:
> >>> 
> >>> Not all gpio banks are necessarily enabled, in the current code this can
> >>> lead to null pointer dereferences.
> >>> 
> >>> [   51.130000] Unable to handle kernel NULL pointer dereference at virtual address 00000058
> >>> [   51.130000] pgd = dee04000
> >>> [   51.130000] [00000058] *pgd=3f66d831, *pte=00000000, *ppte=00000000
> >>> [   51.140000] Internal error: Oops: 17 [#1] ARM
> >>> [   51.140000] Modules linked in:
> >>> [   51.140000] CPU: 0 PID: 1664 Comm: cat Not tainted 4.1.1+ #6
> >>> [   51.140000] Hardware name: Atmel SAMA5
> >>> [   51.140000] task: df6dd880 ti: dec60000 task.ti: dec60000
> >>> [   51.140000] PC is at at91_pinconf_get+0xb4/0x200
> >>> [   51.140000] LR is at at91_pinconf_get+0xb4/0x200
> >>> [   51.140000] pc : [<c01e71a0>]    lr : [<c01e71a0>]    psr: 600f0013
> >>> sp : dec61e48  ip : 600f0013  fp : df522538
> >>> [   51.140000] r10: df52250c  r9 : 00000058  r8 : 00000068
> >>> [   51.140000] r7 : 00000000  r6 : df53c910  r5 : 00000000  r4 : dec61e7c
> >>> [   51.140000] r3 : 00000000  r2 : c06746d4  r1 : 00000000  r0 : 00000003
> >>> [   51.140000] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment user
> >>> [   51.140000] Control: 10c53c7d  Table: 3ee04059  DAC: 00000015
> >>> [   51.140000] Process cat (pid: 1664, stack limit = 0xdec60208)
> >>> [   51.140000] Stack: (0xdec61e48 to 0xdec62000)
> >>> [   51.140000] 1e40:                   00000358 00000000 df522500 ded15f80 c05a9d08 ded15f80
> >>> [   51.140000] 1e60: 0000048c 00000061 df522500 ded15f80 c05a9d08 c01e7304 ded15f80 00000000
> >>> [   51.140000] 1e80: c01e6008 00000060 0000048c c01e6034 c01e5f6c ded15f80 dec61ec0 00000000
> >>> [   51.140000] 1ea0: 00020000 ded6f280 dec61f80 00000001 00000001 c00ae0b8 b6e80000 ded15fb0
> >>> [   51.140000] 1ec0: 00000000 00000000 df4bc974 00000055 00000800 ded6f280 b6e80000 ded6f280
> >>> [   51.140000] 1ee0: ded6f280 00020000 b6e80000 00000000 00020000 c0090dec c0671e1c dec61fb0
> >>> [   51.140000] 1f00: b6f8b510 00000001 00004201 c000924c 00000000 00000003 00000003 00000000
> >>> [   51.140000] 1f20: df4bc940 00022000 00000022 c066e188 b6e7f000 c00836f4 000b6e7f ded6f280
> >>> [   51.140000] 1f40: ded6f280 b6e80000 dec61f80 ded6f280 00020000 c0091508 00000000 00000003
> >>> [   51.140000] 1f60: 00022000 00000000 00000000 ded6f280 ded6f280 00020000 b6e80000 c0091d9c
> >>> [   51.140000] 1f80: 00000000 00000000 ffffffff 00020000 00020000 b6e80000 00000003 c000f124
> >>> [   51.140000] 1fa0: dec60000 c000efa0 00020000 00020000 00000003 b6e80000 00020000 000271c4
> >>> [   51.140000] 1fc0: 00020000 00020000 b6e80000 00000003 7fffe000 00000000 00000000 00020000
> >>> [   51.140000] 1fe0: 00000000 bef50b64 00013835 b6f29c76 400f0030 00000003 00000000 00000000
> >>> [   51.140000] [<c01e71a0>] (at91_pinconf_get) from [<c01e7304>] (at91_pinconf_dbg_show+0x18/0x2c0)
> >>> [   51.140000] [<c01e7304>] (at91_pinconf_dbg_show) from [<c01e6034>] (pinconf_pins_show+0xc8/0xf8)
> >>> [   51.140000] [<c01e6034>] (pinconf_pins_show) from [<c00ae0b8>] (seq_read+0x1a0/0x464)
> >>> [   51.140000] [<c00ae0b8>] (seq_read) from [<c0090dec>] (__vfs_read+0x20/0xd0)
> >>> [   51.140000] [<c0090dec>] (__vfs_read) from [<c0091508>] (vfs_read+0x7c/0x108)
> >>> [   51.140000] [<c0091508>] (vfs_read) from [<c0091d9c>] (SyS_read+0x40/0x94)
> >>> [   51.140000] [<c0091d9c>] (SyS_read) from [<c000efa0>] (ret_fast_syscall+0x0/0x3c)
> >>> [   51.140000] Code: eb010ec2 e30a0d08 e34c005a eb0ae5a7 (e5993000)
> >>> [   51.150000] ---[ end trace fb3c370da3ea4794 ]---
> >>> 
> >>> Signed-off-by: David Dueck <davidcdueck@googlemail.com>
> >>> CC: Nicolas Ferre <nicolas.ferre@atmel.com>
> >>> CC: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> >>> CC: Ludovic Desroches <ludovic.desroches@atmel.com>
> >>> CC: Boris Brezillon <boris.brezillon@free-electrons.com>
> >>> CC: linux-arm-kernel at lists.infradead.org
> >>> CC: linux-kernel at vger.kernel.org
> >>> ---
> >>> drivers/pinctrl/pinctrl-at91.c | 15 +++++++++++++++
> >>> 1 file changed, 15 insertions(+)
> >>> 
> >>> diff --git a/drivers/pinctrl/pinctrl-at91.c b/drivers/pinctrl/pinctrl-at91.c
> >>> index a082447..2deb130 100644
> >>> --- a/drivers/pinctrl/pinctrl-at91.c
> >>> +++ b/drivers/pinctrl/pinctrl-at91.c
> >>> @@ -320,6 +320,9 @@ static const struct pinctrl_ops at91_pctrl_ops = {
> >>> static void __iomem *pin_to_controller(struct at91_pinctrl *info,
> >>> 				 unsigned int bank)
> >>> {
> >>> +	if (!gpio_chips[bank])
> >>> +		return NULL;
> >> 
> >> if the bank is not enabled you should never arrived here
> > 
> > But you can because in pinconf_pins_show you have:
> > for (i = 0; i < pctldev->desc->npins; i++)
> > 
> > And in the pinctrl-at91 driver you have:
> > at91_pinctrl_desc.npins = gpio_banks * MAX_NB_GPIO_PER_BANK;
> > 
> >> 
> >> 
> >>> +
> >>> 	return gpio_chips[bank]->regbase;
> >>> }
> >>> 
> >>> @@ -729,6 +732,10 @@ static int at91_pmx_set(struct pinctrl_dev *pctldev, unsigned selector,
> >>> 		pin = &pins_conf[i];
> >>> 		at91_pin_dbg(info->dev, pin);
> >>> 		pio = pin_to_controller(info, pin->bank);
> >>> +
> >>> +		if (!pio)
> >>> +			continue;
> >>> +
> >> 
> >> or here
> >>> 		mask = pin_to_mask(pin->pin);
> >>> 		at91_mux_disable_interrupt(pio, mask);
> >>> 		switch (pin->mux) {
> >>> @@ -848,6 +855,10 @@ static int at91_pinconf_get(struct pinctrl_dev *pctldev,
> >>> 	*config = 0;
> >>> 	dev_dbg(info->dev, "%s:%d, pin_id=%d", __func__, __LINE__, pin_id);
> >>> 	pio = pin_to_controller(info, pin_to_bank(pin_id));
> >>> +
> >>> +	if (!pio)
> >>> +		return -EINVAL;
> >>> +
> >> ditto
> >>> 	pin = pin_id % MAX_NB_GPIO_PER_BANK;
> >>> 
> >>> 	if (at91_mux_get_multidrive(pio, pin))
> >>> @@ -889,6 +900,10 @@ static int at91_pinconf_set(struct pinctrl_dev *pctldev,
> >>> 			"%s:%d, pin_id=%d, config=0x%lx",
> >>> 			__func__, __LINE__, pin_id, config);
> >>> 		pio = pin_to_controller(info, pin_to_bank(pin_id));
> >>> +
> >>> +		if (!pio)
> >>> +			return -EINVAL;
> >>> +
> >> 
> >> ditoo
> >> 
> >> NACK
> >> 
> >> the problem is somewhere else
> > 
> > I agree that the root cause is somewhere else.
> 
> So we MUST fix the root and not do quick fix

I agree there is a root cause leading to NULL pointers but why it should
be considered as a wrong behavior?

It is the patch you have proposed in order to allow having a disabled
pio controller which leads to have NULL pointers due to the way
gpio_chips is filled.

> 
> > We have a
> > 'gpio_chips[MAX_GPIO_BANKS]' table and 'npins = gpio_banks *
> > MAX_NB_GPIO_PER_BANK' where 'gpio_banks = max(gpio_banks, alias_idx +
> > 1)'. If you have a disabled controller, you will have a NULL pointer in
> > the gpio_chips table and some pins which can't be accessed (for example
> > because this pio controller is secure only).
> 
> I agree but you to catch in one point ONLY of the bank is enabled or not
> not everywhere.
> 
> > 
> > This patch is a sanity check.
> 
> You need only one at the entry point if you do have a NULL pointer accessed by the code
> path the kernel need to oops so you known there is a problem, specially in secure mode.
> This could means a bug or worse.

You declare that you have 160 pins to Linux that's the SoC description so I
won't considered this as wrong.
You have a disabled pio controller for any reasons so some pins are not
accessible for Linux. It seems right too.
If you request one of these pins, the pin_to_controller() function will return
a NULL pointer then a EINVAL error will be returned. It is a proper way to
manage it. Why needing a oops in this case, an error is enough.

> 
> And This will cause CPU cycle consuming for nothing.
> 
> > It is a bit rude to nack this kind of
> > patch telling we should never get this situation. There is always some
> > cases we didn't think of. Moreover, I think this patch is in the view of
> > the driver: the device can manage up to 160 pins but for some reasons, only
> > 128 can be managed by Linux.
> 
> This an other issue.

It is exactly the use case leading to this 'bug'.



Regards

Ludovic
