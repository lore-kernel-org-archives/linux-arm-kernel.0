From: nico@fluxnic.net (Nicolas Pitre)
Date: Mon, 05 Jul 2010 12:03:10 -0400 (EDT)
Subject: [PATCH 09/11] ARM: uImage: require passing a LOADADDR when
	building with RUNTIME_PHYSOFFSET
In-Reply-To: <1278339329-23739-9-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20100705141344.GA25407@pengutronix.de>
	<1278339329-23739-9-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <alpine.LFD.2.00.1007051140180.6020@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 5 Jul 2010, Uwe Kleine-K?nig wrote:

> the default load address (in the CONFIG_ZBOOT_ROM=n case) is ZRELADDR
> which (apart from being a stupid load address for the
> RUNTIME_PHYSOFFSET=n case) might not be a valid read/write memory on the
> target machine at all.  So require passing a LOADADDR on the command
> line.  This obiously makes the uImage more machine dependant than the
> zImage.

Why is this required?  If something is stupid here, it is the fact that 
the U-Boot image format insists on having a load address being built 
into it.  That certainly makes uImage an unsuitable image format for the 
distribution of a cross platform kernel image.

Besides that, you are claiming above that ZRELADDR might not be a valid 
writable address when ZBOOT_ROM=n.  If that was true we would be having 
boot failures all over the place already.

Remember that the goal for this revived effort behind the 
RUNTIME_PHYSOFFSET support is to eventually be able to boot a single 
kernel binary on multiple different platforms.  Asking that a load 
address be provided at kernel compile time is rather incompatible with 
that goal.  If there is no good default LOADADDR value for mkimage then 
simply don't provide any.  I hope that mkimage can cope with that.  
Otherwise just give it 0 which is as wrong as any other value and let 
that be an incentive for the U-Boot people to fix the tool properly 
(i.e. use that as a flag to let U-Boot that the load address must be 
explicitly provided with the load command or whatever).

Therefore, this is a NAK from me.


Nicolas
