From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 7 Jun 2013 21:53:03 +0200
Subject: [PATCH 03/14] bus: mvebu-mbus: Introduce device tree binding
In-Reply-To: <20130607194430.GA7854@obsidianresearch.com>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <201306072110.35856.arnd@arndb.de>
 <20130607194430.GA7854@obsidianresearch.com>
Message-ID: <201306072153.03855.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 07 June 2013, Jason Gunthorpe wrote:
> We have a minimum requirement that the bootloader setup internal regs,
> so the minimum required DT bindings is going to be this:
> 
> mbus {
>   compatible = ...
>   ranges = <INTERNAL_REGS_MAP_ID 0xf1000000 0x100000>;
>   reg = <0xf1000xxx ...>; // MBUS regs block
>   #address/size-cells...
> 
>   internal-regs  {
>       ranges = <0 INTERNAL_REGS_MAP_ID 0x100000>;
>   }
> }
> 
> ie the ranges should never be empty.

Right, that's what I thought.

> Discovery of the address of the mbus control registers is via the reg
> property on its own node (which is untranslated), and all other
> internal regs blocks will automatically translate as they are supposed
> to (Thomas's work to make internal regs 0xd/0xf1 relies on this, AFAIK)
> 
> INTERNAL_REGS_MAP_ID is an invalid target ID value, defined to mean
> the internal registers target. 0xFFFFFFFF is a better choice for this
> than 0, because 0xFFFFFFFF is never going to be a valid target id, it
> is too large.

Can you explain to me why it is an invalid target ID value? Is it
treated very differently by the mbus register setup than all the
others? I guess we can define it as something else to make a valid
target ID, by using one or more of the remaining bits in the first
address cell.

	Arnd
