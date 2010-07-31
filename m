From: cbouatmailru@gmail.com (Anton Vorontsov)
Date: Sat, 31 Jul 2010 20:38:54 +0400
Subject: [PATCH 1/4] ARM: SCU: Add generic routines for secondary CPU
	bootup
In-Reply-To: <20100731154134.GF27064@n2100.arm.linux.org.uk>
References: <20100727171109.GA7929@oksana.dev.rtsoft.ru>
	<20100727171140.GA10375@oksana.dev.rtsoft.ru>
	<20100731154134.GF27064@n2100.arm.linux.org.uk>
Message-ID: <20100731163854.GA19180@oksana.dev.rtsoft.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 31, 2010 at 04:41:34PM +0100, Russell King - ARM Linux wrote:
> On Tue, Jul 27, 2010 at 09:11:40PM +0400, Anton Vorontsov wrote:
> > For CNS3xxx we want to reuse the original ARM approach of booting
> > secondary CPUs. This patch turns VExpress' code into "SCU library",
> > so that now platform code can call the generic routines.
> 
> I'm not sure this should become a "SCU library" - the name seems wrong.

Well, how would you name it? Would you also move these routines
into a separate file (is there any preference for the file name)?

> When you consider that the SCU is the 'snoop control unit', which has
> no relation to how secondary CPUs are booted, it makes little sense.
> 
> The secondary CPU boot protocol has much more to do with the boot
> loader than with the hardware.

Yup.

> I also suspect that we can get rid of the 'holding pen' stuff and just
> rely on the IPI being sent to the intended target CPU.  I don't think
> anyone has really updated this since the initial ARM SMP implementation.

Sure, but I belive that this patch set is a step into the right
direction, basically it just gets rid of code duplication, and
then we can improve the bootup code for all interested machines.

With these patches, machines don't* bother with the holding pen,
it just becomes an implementation detail of the SCU/secondary
CPU bootup code.

So it makes sense to consolidate the code anyway (which exactly
what these patches do), right?

* Except realview, it also uses scu_pen_release for hotplug
  handling.

-- 
Anton Vorontsov
email: cbouatmailru at gmail.com
irc://irc.freenode.net/bd2
