From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 9 Feb 2017 12:14:59 +0000
Subject: [PATCH v5] PCI: Xilinx NWL: Modifying irq chip for legacy
 interrupts
In-Reply-To: <8520D5D51A55D047800579B094147198263E68AA@XAP-PVEXMBX02.xlnx.xilinx.com>
References: <1486364596-19699-1-git-send-email-bharatku@xilinx.com>
 <4b04e834-08b6-a728-8fe5-13106d50b3b2@arm.com>
 <8520D5D51A55D047800579B094147198263E68AA@XAP-PVEXMBX02.xlnx.xilinx.com>
Message-ID: <131228fb-d3f8-3836-3713-e948ed30d398@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/02/17 12:01, Bharat Kumar Gogada wrote:
>> On 06/02/17 07:03, Bharat Kumar Gogada wrote:
>>> +static struct irq_chip nwl_leg_irq_chip = {
>>> +	.name = "nwl_pcie:legacy",
>>> +	.irq_enable = nwl_unmask_leg_irq,
>>> +	.irq_disable = nwl_mask_leg_irq,
>>
>> You don't need these two if they are implemented in terms of mask/unmask.
> 
> These are being invoked by some drivers other than interrupt flow.
> Ex: drivers/net/wireless/ath/ath9k/main.c
> static int ath_reset_internal(struct ath_softc *sc, struct ath9k_channel *hchan) 
> {
>          ....
>          disable_irq(sc->irq);
>          tasklet_disable(&sc->intr_tq);
>         ...
>         ...
>         enable_irq(sc->irq);
>         spin_unlock_bh(&sc->sc_pcu_lock);
> }
> For us masking/unmasking is the way to enable/disable interrupts.

And if you looked at the way disable_irq is implemented, you would have
found out that it falls back to masking if there is no disable method,
preserving the semantic you expect.

	M.
-- 
Jazz is not dead. It just smells funny...
