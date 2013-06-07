From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Fri, 7 Jun 2013 14:09:56 -0600
Subject: [PATCH 03/14] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <201306072153.03855.arnd@arndb.de>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072110.35856.arnd@arndb.de>
 <20130607194430.GA7854@obsidianresearch.com>
 <201306072153.03855.arnd@arndb.de>
Message-ID: <20130607200956.GB9010@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 07, 2013 at 09:53:03PM +0200, Arnd Bergmann wrote:
 
> Can you explain to me why it is an invalid target ID value? Is it
> treated very differently by the mbus register setup than all the
> others? I guess we can define it as something else to make a valid
> target ID, by using one or more of the remaining bits in the first
> address cell.

There is a special dedicated window register for the internal regs
base. Marvell did not define it a target ID or window attributes, and
only that window register can be used to configure it. The mbus driver
should never read or write this register.

So we have a 2 cell address encoding of the form:

 IIAA0000 00oooooo

Where:
 -- I = Marvell defined target ID for programmable windows
 -- A = Marvell defined target attributes for programmable windows
 -- o = offset within the window

Now, we need 2 cell format that tells the driver that this is the
internal regs block. Assuming that marvell defines all I/A values we
need another value (I called it an invalid valid) to indicate internal
regs, several choices:

  FFFFFFFF 00oooooo
  0000FFFF 00oooooo
  00000001 00oooooo

Doesn't really matter which is picked, as far as I can tell, though
maybe the 01 option is best, leading to:

  IIAAssss 00oooooo

Where:
 -- s = target space
   == 0 means I/A are:
    -- I = Marvell defined target ID for programmable windows
    -- A = Marvell defined target attributes for programmable windows
   == 1 means internal regs block
 -- o = offset within the target

Which is pretty tidy..

Jason
