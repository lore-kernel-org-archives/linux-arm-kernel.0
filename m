From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 24 Apr 2014 20:42:08 +0200
Subject: [PATCH 2/2] of/irq: do irq resolution in platform_get_irq
In-Reply-To: <1398293861-7682-3-git-send-email-robherring2@gmail.com>
References: <1398293861-7682-1-git-send-email-robherring2@gmail.com>
 <1398293861-7682-3-git-send-email-robherring2@gmail.com>
Message-ID: <20140424184207.GC27443@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 23, 2014 at 05:57:41PM -0500, Rob Herring wrote:
> From: Rob Herring <robh@kernel.org>
> 
> Currently we get the following kind of errors if we try to use interrupt
> phandles to irqchips that have not yet initialized:
> 
> irq: no irq domain found for /ocp/pinmux at 48002030 !
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171 of_device_alloc+0x144/0x184()
> Modules linked in:
> CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.12.0-00038-g42a9708 #1012
> (show_stack+0x14/0x1c)
> (dump_stack+0x6c/0xa0)
> (warn_slowpath_common+0x64/0x84)
> (warn_slowpath_null+0x1c/0x24)
> (of_device_alloc+0x144/0x184)
> (of_platform_device_create_pdata+0x44/0x9c)
> (of_platform_bus_create+0xd0/0x170)
> (of_platform_bus_create+0x12c/0x170)
> (of_platform_populate+0x60/0x98)
> 
> This is because we're wrongly trying to populate resources that are not
> yet available. It's perfectly valid to create irqchips dynamically, so
> let's fix up the issue by resolving the interrupt resources when
> platform_get_irq is called.
> 
> And then we also need to accept the fact that some irqdomains do not
> exist that early on, and only get initialized later on. So we can
> make the current WARN_ON into just into a pr_debug().
> 
> We still attempt to populate irq resources when we create the devices.
> This allows current drivers which don't use platform_get_irq to continue
> to function. Once all drivers are fixed, this code can be removed.
> 
> Suggested-by: Russell King <linux@arm.linux.org.uk>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/base/platform.c |  7 ++++++-
>  drivers/of/irq.c        | 26 ++++++++++++++++++++++++++
>  drivers/of/platform.c   |  4 +++-
>  include/linux/of_irq.h  |  7 ++++++-
>  4 files changed, 41 insertions(+), 3 deletions(-)

Hehe... that's largely what we already had back in January[0]. Glad to
see that people could finally agree on what to do about this.

Thierry

[0]: https://lkml.org/lkml/2014/1/8/240
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140424/c83b02f7/attachment.sig>
