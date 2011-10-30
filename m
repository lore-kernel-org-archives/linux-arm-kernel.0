From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 30 Oct 2011 18:52:08 +0000
Subject: [PATCH] mach-ixp4xx: made gpio functions atomic
In-Reply-To: <1319973693-19063-1-git-send-email-fransmeulenbroeks@gmail.com>
References: <1319973693-19063-1-git-send-email-fransmeulenbroeks@gmail.com>
Message-ID: <20111030185208.GD19187@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 30, 2011 at 12:21:33PM +0100, Frans Meulenbroeks wrote:
> gpio_line_set and gpio_line config on ixp4xx were not atomic
> This patch fixes this by surrounding them with local_irq_save and
> local_irq_restore calls, similar to the way Lennert Buytenhek
> implemented this for iop. (see arch/arm/plat-iop/gpio.c)
> 
> Signed-off-by: Frans Meulenbroeks <fransmeulenbroeks@gmail.com>
> ---
> 
> Note: an alternative solution would be to use the set_bit and 
> clear_bit atomic functions, but I felt it better to do things
> the same way as Lennert did. Also it could be that this is a few
> bytes smaller. Didn't check that.

set_bit and clear_bit should not be used on IO memory - on ARMv6 and
later these use the load exclusive/store exclusive operations which
are only valid on 'normal memory' mappings and not 'device' mappings.

Plus of course, IO memory is supposed to be __iomem and accessed using
the proper accessors, and using set_bit and clear_bit on such pointers
will issue sparse warnings.
