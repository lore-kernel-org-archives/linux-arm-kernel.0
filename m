From: dave.martin@linaro.org (Dave Martin)
Date: Thu, 25 Aug 2011 10:57:22 +0100
Subject: ARM processor mode, kernel startup, Hyp / secure state
In-Reply-To: <20110824170953.GA8883@n2100.arm.linux.org.uk>
References: <20051.48809.945431.800543@mariner.uk.xensource.com>
	<CAHkRjk6N+OeeHZzS9hOnWKEg+aFUJVwT5Vf_PqO0cHv=2_9CnA@mail.gmail.com>
	<20051.57876.785018.498967@mariner.uk.xensource.com>
	<20110824135109.GP32688@e102144-lin.cambridge.arm.com>
	<20110824170953.GA8883@n2100.arm.linux.org.uk>
Message-ID: <CA+wbFddzhao_Pu=-XLH3py7Bgo6Lr+K=unf4NDoQ5pv0G5-HbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 24, 2011 at 6:09 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Aug 24, 2011 at 02:51:09PM +0100, Will Deacon wrote:
>> I think it's important to separate the problems of secure boot with the
>> problems of installing a hypervisor. Whatever happens in secure world, we can
>> expect to be dropped at either HYP mode or non-secure SVC mode. Sure, on a dev
>> board you might run directly in the secure world so there's a bit of extra
>> work to do to get out of that but then we can just drop into HVC mode and
>> forget about it.
>
> I think you're painting a very simple picture there.
>
> If the kernel has been handed over to while in secure mode, that's
> probably because there is no secure monitor implemented. ?If there's
> no secure monitor implemented, there's no code in place to handle
> SMC instructions. ?To make things worse, if we drop out into non-secure
> mode, due to the lack of working SMC instructions, we have no way to
> access the various registers we need to.
>
> So, if the kernel is booted in secure mode and wants to drop into non-
> secure mode, we need a separate blob of code to install as our own
> secure monitor to provide these services.
>
>> Unlike the fragmented secure monitor API that currently exists across
>> different platforms, it's really in the interests of the vendor to
>> standardise on the HYP interface and provide calls to install code, otherwise
>> they run the risk of producing what is essentially a closed system.
>
> On the other hand, I'm sure vendors are already thinking along those
> lines - the precident has been set by the secure monitor API mess, so
> if it can be made to "work" there...

A few thoughts from my end...

The kernel potentially has a lot of work to do if it is to support
virtualisation
when booted in the Secure World, because the kernel needs to switch to
the Normal World -- security controllers on the bus will need to be reprogrammed
etc., and the kernel would also need to retain some Secure memory somewhere
for handling SMC -- i.e., per-SoC code and configuration which just
doesn't exist
in the kernel yet.  The kernel does not need a "real" monitor in this
scenario, but
it will still need to get back into the Secure World to do certain
low-level operations
as we observe on e.g. OMAP.  This is not trivial since SMC causes a change of
memory space as well as privilege.

This potentially gets quite complex and messy, and the kernel doesn't really
care; my gut feeling is that we probably don't want to go there --
it's a fair amount
of extra code from which we don't really get much benefit.

So, it could be reasonable to _require_ linux to be started in the Normal
World if linux will install its own hypervisor, with suitable (possibly minimal)
SMC and HVC handlers/stubs provided by the bootloader or (more probably)
firmware.

Hopefully, those SMC/HVC interfaces will get reasonably standardised,
but in the meantime a bit of SoC-specific code in linux should be adequate
to smooth any differences.  Vendors likely have a strong incentive to provide
adequate and working functionality at these interfaces because failure to do
so could be a significant market disadvantage.

Cheers
---Dave
