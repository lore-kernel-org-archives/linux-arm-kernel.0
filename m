From: ithamar.adema@team-embedded.nl (Ithamar R. Adema)
Date: Fri, 18 Mar 2011 18:06:14 +0100
Subject: [PATCH v2 2/9] lpc2k: Exception vector handling
In-Reply-To: <20110318151650.GL29758@n2100.arm.linux.org.uk>
References: <1300461116-6028-1-git-send-email-ithamar.adema@team-embedded.nl>
	<1300461116-6028-3-git-send-email-ithamar.adema@team-embedded.nl>
	<20110318151650.GL29758@n2100.arm.linux.org.uk>
Message-ID: <1300467974.2138.164.camel@team-embedded-2>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-03-18 at 15:16 +0000, Russell King - ARM Linux wrote:
> On Fri, Mar 18, 2011 at 04:11:49PM +0100, Ithamar R. Adema wrote:
> > Since the LPC2K does not have an MMU (ARM7TDMI based), it expects the vectors to be
> > stored in on-chip SRAM. However, this moves the vectors too far away from the stubs
> > page, requiring the vector jumps to be indirect.
> 
> Why not copy the vectors and stubs just like we do for MMU-based kernels?

The problem here is the remapping of the low vectors that the LPC2K SoC
does. Although we store the vectors (and stubs) @ 0x40000000 (SRAM) the
SoC remaps only the first 64 bytes of that to address 0x00000000 (low
vectors).

This means that although the vectors are accessible, the stubs are not.
The 64 bytes cover the vectors itself, and the 1-word per vector address
variable stored directly after the vectors.

I'll update the commit log to be a bit more clear on this.

Regards,

Ithamar.
