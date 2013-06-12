From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 12 Jun 2013 23:50:43 +0200
Subject: [PATCH 04/14] bus: mvebu-mbus: Add static window allocation to
 the DT binding
In-Reply-To: <20130612200248.GA23012@localhost>
References: <1370623671-7748-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <20130611215023.GA12649@obsidianresearch.com>
 <20130612200248.GA23012@localhost>
Message-ID: <201306122350.43983.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 12 June 2013, Ezequiel Garcia wrote:
> #define INTERNAL_REGS INTERNAL_REGS_ID 0
> #define DEVBUS_BOOTCS 0x012f0000 0
> #define BOOTROM       0x01e00000 0
> 
> #define INTERNAL_REGS_BASE 0 0xd0000000
> #define DEVBUS_BOOTCS_BASE 0 0xf0000000
> #define BOOTROM_BASE       0 0xfff00000
> ...
>  
> soc {
>         ranges = <INTERNAL_REGS INTERNAL_REGS_BASE 0x100000
>                   BOOTROM       BOOTROM_BASE       0x100000
>                   DEVBUS_BOOTCS DEVBUS_BOOTCS_BASE 0x1000000>;
> 

FWIW, I think using macros to pass INTERNAL_REGS_BASE is counterproductive.
It's much better to use literal numbers for those because then you
can see how things fit together by looking at the source.

The macros for the IDs seem fine, although I would actually find it
easier to have just one macro like

#define MBUS_ID(a, b) (((a) & 0xff) << 24 | ((b) & 0xff) << 16)

and pass the literals into that, to the effect of

soc {
	ranges = <1 0 0 0xd0000000 0x100000>,
		 <MBUS_ID(0x01, 0x2f) 0 0 0xfff00000 0x100000>,
		 <MBUS_ID(0x01, 0xe0) 0 0 0xf0000000 0x100000>;

I'd suggest having each macro expand only to a single value, to make
it clearer which numbers belong together in the ranges array.

	Arnd
