From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 27 Jun 2016 15:54:46 +0100
Subject: BUG?: kernel does not (re)set irq smp_affinity to reboot_cpu
In-Reply-To: <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
References: <4dc8bd4c-8456-9f94-b7eb-c5d227ddc673@redhat.com>
 <5770EE21.90103@arm.com>
 <20160627094552.GE1041@n2100.armlinux.org.uk>
 <d3a266d3-2cfc-81c7-25a6-b39c8012bcf0@redhat.com>
 <20160627113143.GF1041@n2100.armlinux.org.uk>
 <842a453d-3295-ffbd-f3dd-67baba1692d2@redhat.com>
Message-ID: <20160627145445.GA29321@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 27, 2016 at 02:53:16PM +0200, Hans de Goede wrote:
> Note this does not mean that all pm_power_off implementations
> are going to be happy with machine_power_off leaving irqs
> enabled, I would esp. expect the efi and psci implementations
> to potentially be unhappy about this. See below for a proposal
> to deal with this.

Neither PSCI nor EFI care either way about interrupts.

PSCI makes synchronous HVC/SMC calls to a higher exception level, and
can be safely called with interrupts enabled or disabled.

EFI's ResetSystem (which backs pm_power_off) can be called with
interrupts enabled or disabled, so long as there is not a clashing call
in progress already (see 7.1 "Runtime Services Rules and Restrictions")
in the EFI 2.6 spec.

Thanks,
Mark.
