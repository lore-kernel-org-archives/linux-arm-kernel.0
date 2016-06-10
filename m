From: eric@anholt.net (Eric Anholt)
Date: Thu, 09 Jun 2016 17:21:35 -0700
Subject: [PATCH v2 4/9] arm64: Add platform selection for BCM2835.
In-Reply-To: <20160608091219.GA16322@e104818-lin.cambridge.arm.com>
References: <1464934708-24769-1-git-send-email-kraxel@redhat.com>
 <1464934708-24769-5-git-send-email-kraxel@redhat.com>
 <20160603112721.GC1128@e104818-lin.cambridge.arm.com>
 <87bn3gu3to.fsf@eliezer.anholt.net>
 <20160608091219.GA16322@e104818-lin.cambridge.arm.com>
Message-ID: <87h9d1x59s.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Catalin Marinas <catalin.marinas@arm.com> writes:

> On Sat, Jun 04, 2016 at 12:55:15PM -0700, Eric Anholt wrote:
>> Catalin Marinas <catalin.marinas@arm.com> writes:
>> > On Fri, Jun 03, 2016 at 08:18:23AM +0200, Gerd Hoffmann wrote:
>> >> diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
>> >> index 7ef1d05..ea88402 100644
>> >> --- a/arch/arm64/Kconfig.platforms
>> >> +++ b/arch/arm64/Kconfig.platforms
>> >> @@ -13,6 +13,19 @@ config ARCH_ALPINE
>> >>  	  This enables support for the Annapurna Labs Alpine
>> >>  	  Soc family.
>> >>  
>> >> +config ARCH_BCM2835
>> >> +	bool "Broadcom BCM2835 family"
>> >> +	select ARCH_REQUIRE_GPIOLIB
>> >> +	select CLKSRC_OF
>> >> +	select PINCTRL
>> >> +	select PINCTRL_BCM2835
>> >> +	select ARM_AMBA
>> >> +	select ARM_TIMER_SP804
>> >> +	select HAVE_ARM_ARCH_TIMER
>> >> +	help
>> >> +	  This enables support for the Broadcom BCM2837 SoC.
>
> Even the BCM number is inconsistent here.

Well, given the past chip numbers, we could call the family's Kconfig
ARCH_BCM283X, and for now arm64 would only do the 2837 in the family.
Back when I was doing 2836, other maintainers agreed that renaming all
of the ARCH_BCM2835 in the tree to BCM283X was pointless thrashing.

>> >> +	  This SoC is used in the Raspberry Pi 3 device.
>> >
>> > I thought we would just use ARCH_BCM, or is it too generic?
>> 
>> Consensus last time around seemed to be to drop adding ARCH_BCM, in
>> favor of patch 1 of the series.
>
> I may have missed that discussion. My point was about consistency with
> existing ARCH_* definitions in the arm64 Kconfig.platforms. I can see
> why it's easier for you since some drivers are built based on
> ARCH_BCM2835. Looking at drivers/clk/bcm/Makefile, there is an
> inconsistent mix of CLK_BCM_* and ARCH_BCM_*. I would rather have a new
> CLK_BCM2835 that's selected/enabled accordingly (maybe simply depending
> on ARCH_BCM).

So I introduce a new ARCH_BCM here, that selects the just the 283x
family's core drivers?  That seems strange, but I'm willing if that's
what you want.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160609/1b8ec2d7/attachment-0001.sig>
