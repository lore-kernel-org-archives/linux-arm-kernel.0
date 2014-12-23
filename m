From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Dec 2014 21:58:49 +0100
Subject: [RFC][PATCH RESEND] mm: vmalloc: remove ioremap align constraint
In-Reply-To: <1419328813-2211-1-git-send-email-d.safonov@partner.samsung.com>
References: <1419328813-2211-1-git-send-email-d.safonov@partner.samsung.com>
Message-ID: <11656044.WGcPr1b8t8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 December 2014 13:00:13 Dmitry Safonov wrote:
> ioremap uses __get_vm_area_node which sets alignment to fls of requested size.
> I couldn't find any reason for such big align. Does it decrease TLB misses?
> I tested it on custom ARM board with 200+ Mb of ioremap and it works.
> What am I missing?

The alignment was originally introduced in this commit:

commit ff0daca525dde796382b9ccd563f169df2571211
Author: Russell King <rmk@dyn-67.arm.linux.org.uk>
Date:   Thu Jun 29 20:17:15 2006 +0100

    [ARM] Add section support to ioremap
    
    Allow section mappings to be setup using ioremap() and torn down
    with iounmap().  This requires additional support in the MM
    context switch to ensure that mappings are properly synchronised
    when mapped in.
    
    Based an original implementation by Deepak Saxena, reworked and
    ARMv6 support added by rmk.
    
    Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

and then later extended to 16MB supersection mappings, which indeed
is used to reduce TLB pressure.

I don't see any downsides to it, why change it?

	Arnd
