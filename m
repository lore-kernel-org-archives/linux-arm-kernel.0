From: nm@ti.com (Menon, Nishanth)
Date: Fri, 10 Feb 2012 09:23:04 -0600
Subject: [PATCH RFC] OMAP: serial: Release the claimed memory region in
 remove
In-Reply-To: <1328853482-3687-1-git-send-email-shubhrajyoti@ti.com>
References: <1328853482-3687-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <CAOMWX4f0Mpj=NRBXZgtLbvCg3uo+8tZY8OAkriPu2YucRGoPkw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 9, 2012 at 23:58, Shubhrajyoti D <shubhrajyoti@ti.com> wrote:
> Currently the memory region is not released the folowing error is
> observed.
>
> /testsuites # insmod omap-serial.ko
> [ ?130.746917] omap_uart omap_uart.0: memory region already claimed
> [ ?130.753143] omap_uart: probe of omap_uart.0 failed with error -16
> [ ?130.759338] omap_uart omap_uart.1: memory region already claimed
> [ ?130.765380] omap_uart: probe of omap_uart.1 failed with error -16
> [ ?130.771606] omap_uart omap_uart.2: memory region already claimed
> [ ?130.777679] omap_uart: probe of omap_uart.2 failed with error -16
> [ ?130.783905] omap_uart omap_uart.3: memory region already claimed
> [ ?130.789947] omap_uart: probe of omap_uart.3 failed with error -16
>
> Fix it by releasing the memory region.
>
> Cc: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: Shubhrajyoti D <shubhrajyoti@ti.com>
> ---
> ?drivers/tty/serial/omap-serial.c | ? ?4 ++++
> ?1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 130f7f8..4def6c3 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -1480,6 +1480,10 @@ do_release_region:
> ?static int serial_omap_remove(struct platform_device *dev)
> ?{
> ? ? ? ?struct uart_omap_port *up = platform_get_drvdata(dev);
> + ? ? ? struct resource ? ? ? ? *r;
> +
> + ? ? ? r = platform_get_resource(dev, IORESOURCE_MEM, 0);
> + ? ? ? release_mem_region(r->start, resource_size(r));
if this is the same region which ioremapped to up->port.membase, then
please release mem region after the unmap.
Regards,
Nishanth Menon

>
> ? ? ? ?if (up) {
> ? ? ? ? ? ? ? ?iounmap(up->port.membase);
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
