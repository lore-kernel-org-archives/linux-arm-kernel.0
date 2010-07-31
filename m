From: santosh.shilimkar@ti.com (Shilimkar, Santosh)
Date: Sat, 31 Jul 2010 18:15:32 +0530
Subject: [PATCH 0/3] Allow late mdesc detection, v3
In-Reply-To: <20100731092522.GD23886@n2100.arm.linux.org.uk>
References: <20100731092522.GD23886@n2100.arm.linux.org.uk>
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02C6381053@dbde02.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jeremy,
> -----Original Message-----
> From: linux-omap-owner at vger.kernel.org [mailto:linux-omap-
> owner at vger.kernel.org] On Behalf Of Russell King - ARM Linux
> Sent: Saturday, July 31, 2010 2:55 PM
> To: linux-arm-kernel at lists.infradead.org; linux-omap at vger.kernel.org; Tony
> Lindgren
> Subject: Fwd: [PATCH 0/3] Allow late mdesc detection, v3
> 
> Forwarding for OMAP people - as there's outstanding questions about this
> change for their platforms.
> 
> ----- Forwarded message from Jeremy Kerr <jeremy.kerr@canonical.com> -----
> 
> Date: Fri, 30 Jul 2010 17:22:11 +0800
> From: Jeremy Kerr <jeremy.kerr@canonical.com>
> To: linux-arm-kernel at lists.infradead.org
> Subject: [PATCH 0/3] Allow late mdesc detection, v3
> Delivery-date: Sat, 31 Jul 2010 01:25:58 +0100
> 
> Hi all,
> 
> Currently, we probe for a mdesc early in boot. At this early stage, the
> only thing we use the mdesc for is to determine the debug page mapping.
> 
> However, the debug addresses (phys and virt) need to be coded into the
> addruart macro anyway; the dynamic probing is only going to tell us what
> we already know.
> 
> These changes allow us to use the addruart macros to find the debug
> mapping addresses, rather than pulling them out of the mdesc. This means
> that the addresses are only kept in the one place, and that we don't
> need the mdesc nearly as early.
> 
> The first change updates all of the addruart macros to return both
> physical and virtual addresses. I've used 'rp' and 'rv' as the macro
> arguments to indicate which address goes where
> 
> The second change updates the debug setup routine to use the addruart
> macro to establish the debug mapping, now that we can invoke the macro
> to find the phyical and virtual addresses.
> 
> This allows us to delay the requirement to have a mdesc available until
> much later. For example, we can parse one from the device tree once
> we've reached C code.
> 
> May break OMAP1/2, as the addruart macros are more complex on these
> platforms. I'd appreciate input from OMAP folks who may well tell me
> that this isn't possible.
> 
Just tried this on OMAP4, and indeed it breaks OMAP2PLUS low level debug
support.

Tony recently revamped the complete debug code, so that we can dynamically
set correct debug port based on machine ID passed by boot-loaders. Based
on this , the debug code determines the the correct debug port based on
this using a scratch pad register.

Tony can comment better on this issue.

Regards,
Santosh
