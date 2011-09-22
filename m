From: tom.leiming@gmail.com (Ming Lei)
Date: Thu, 22 Sep 2011 15:48:51 +0800
Subject: [PATCH v5 09/15] OMAP2+: UART: Add runtime pm support for
	omap-serial driver
In-Reply-To: <1316607206-21669-7-git-send-email-govindraj.raja@ti.com>
References: <1316607206-21669-1-git-send-email-govindraj.raja@ti.com>
	<1316607206-21669-7-git-send-email-govindraj.raja@ti.com>
Message-ID: <CACVXFVMpvF5foA1asLYE5WbvHQ3b_eXaBpiMT7Q1h0KHDGLSCg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Sep 21, 2011 at 8:13 PM, Govindraj.R <govindraj.raja@ti.com> wrote:
> Adapts omap-serial driver to use pm_runtime API's.

> ? ? ? ?console_unlock();
>
> - ? ? ? if ((cpu_is_omap34xx() && bdata->pads) ||
> - ? ? ? ? ? ? ? (pdata->wk_en && pdata->wk_mask))
> + ? ? ? if ((cpu_is_omap34xx() && bdata->pads))
> ? ? ? ? ? ? ? ?device_init_wakeup(&pdev->dev, true);

Just a bit curious, why doesn't the code enable wakeup at default
on omap4, which will disable runtime pm of serial port on omap4.

I have tested your patches on omap4 panda(enable wakeup at
default manually), runtime pm of serial port 2 can work well and
remote wakeup too.

>
> ? ? ? ?kfree(pdata);
> diff --git a/arch/arm/plat-omap/include/plat/omap-serial.h b/arch/arm/plat-omap/include/plat/omap-serial.h
> index 74822b3..8ef81ce 100644
> --- a/arch/arm/plat-omap/include/plat/omap-serial.h
> +++ b/arch/arm/plat-omap/include/plat/omap-serial.h
> @@ -62,6 +62,9 @@ struct omap_uart_port_info {
> ? ? ? ?upf_t ? ? ? ? ? ? ? ? ? flags; ? ? ? ? ?/* UPF_* flags */
>
> ? ? ? ?u32 ? ? ? ? ? ? ? ? ? ? errata;
> +
> + ? ? ? void (*enable_wakeup)(struct platform_device *, bool);
> + ? ? ? u32 (*get_context_loss_count)(struct device *);
> ?};
>
> ?struct uart_omap_dma {
> @@ -113,6 +116,8 @@ struct uart_omap_port {
> ? ? ? ?unsigned char ? ? ? ? ? msr_saved_flags;
> ? ? ? ?char ? ? ? ? ? ? ? ? ? ?name[20];
> ? ? ? ?unsigned long ? ? ? ? ? port_activity;
> + ? ? ? u32 ? ? ? ? ? ? ? ? ? ? context_loss_cnt;
> + ? ? ? u8 ? ? ? ? ? ? ? ? ? ? ?wakeups_enabled;
> ?};
>
> ?#endif /* __OMAP_SERIAL_H__ */
> diff --git a/drivers/tty/serial/omap-serial.c b/drivers/tty/serial/omap-serial.c
> index 9a0eac2..43c33da 100644
> --- a/drivers/tty/serial/omap-serial.c
> +++ b/drivers/tty/serial/omap-serial.c
> @@ -37,11 +37,14 @@
> ?#include <linux/clk.h>
> ?#include <linux/serial_core.h>
> ?#include <linux/irq.h>
> +#include <linux/pm_runtime.h>
>
> ?#include <plat/dma.h>
> ?#include <plat/dmtimer.h>
> ?#include <plat/omap-serial.h>
>
> +#define OMAP_UART_AUTOSUSPEND_DELAY -1
> +
> ?static struct uart_omap_port *ui[OMAP_MAX_HSUART_PORTS];
>
> ?/* Forward declaration of functions */
> @@ -102,6 +105,8 @@ static void serial_omap_stop_rxdma(struct uart_omap_port *up)
> ? ? ? ? ? ? ? ?omap_free_dma(up->uart_dma.rx_dma_channel);
> ? ? ? ? ? ? ? ?up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
> ? ? ? ? ? ? ? ?up->uart_dma.rx_dma_used = false;
> + ? ? ? ? ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? ? ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ?}
> ?}
>
> @@ -110,8 +115,11 @@ static void serial_omap_enable_ms(struct uart_port *port)
> ? ? ? ?struct uart_omap_port *up = (struct uart_omap_port *)port;
>
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_enable_ms+%d\n", up->pdev->id);
> +
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?up->ier |= UART_IER_MSI;
> ? ? ? ?serial_out(up, UART_IER, up->ier);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ?}
>
> ?static void serial_omap_stop_tx(struct uart_port *port)
> @@ -129,23 +137,32 @@ static void serial_omap_stop_tx(struct uart_port *port)
> ? ? ? ? ? ? ? ?omap_stop_dma(up->uart_dma.tx_dma_channel);
> ? ? ? ? ? ? ? ?omap_free_dma(up->uart_dma.tx_dma_channel);
> ? ? ? ? ? ? ? ?up->uart_dma.tx_dma_channel = OMAP_UART_DMA_CH_FREE;
> + ? ? ? ? ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? ? ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ?}
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?if (up->ier & UART_IER_THRI) {
> ? ? ? ? ? ? ? ?up->ier &= ~UART_IER_THRI;
> ? ? ? ? ? ? ? ?serial_out(up, UART_IER, up->ier);
> ? ? ? ?}
> +
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ?}
>
> ?static void serial_omap_stop_rx(struct uart_port *port)
> ?{
> ? ? ? ?struct uart_omap_port *up = (struct uart_omap_port *)port;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?if (up->use_dma)
> ? ? ? ? ? ? ? ?serial_omap_stop_rxdma(up);
> ? ? ? ?up->ier &= ~UART_IER_RLSI;
> ? ? ? ?up->port.read_status_mask &= ~UART_LSR_DR;
> ? ? ? ?serial_out(up, UART_IER, up->ier);
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ?}
>
> ?static inline void receive_chars(struct uart_omap_port *up, int *status)
> @@ -262,7 +279,10 @@ static void serial_omap_start_tx(struct uart_port *port)
> ? ? ? ?int ret = 0;
>
> ? ? ? ?if (!up->use_dma) {
> + ? ? ? ? ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ? ? ? ? ?serial_omap_enable_ier_thri(up);
> + ? ? ? ? ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? ? ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ? ? ? ? ?return;
> ? ? ? ?}
>
> @@ -272,6 +292,7 @@ static void serial_omap_start_tx(struct uart_port *port)
> ? ? ? ?xmit = &up->port.state->xmit;
>
> ? ? ? ?if (up->uart_dma.tx_dma_channel == OMAP_UART_DMA_CH_FREE) {
> + ? ? ? ? ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ? ? ? ? ?ret = omap_request_dma(up->uart_dma.uart_dma_tx,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"UART Tx DMA",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(void *)uart_tx_dma_callback, up,
> @@ -354,9 +375,13 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
> ? ? ? ?unsigned int iir, lsr;
> ? ? ? ?unsigned long flags;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?iir = serial_in(up, UART_IIR);
> - ? ? ? if (iir & UART_IIR_NO_INT)
> + ? ? ? if (iir & UART_IIR_NO_INT) {
> + ? ? ? ? ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? ? ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ? ? ? ? ?return IRQ_NONE;
> + ? ? ? }
>
> ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
> ? ? ? ?lsr = serial_in(up, UART_LSR);
> @@ -378,6 +403,9 @@ static inline irqreturn_t serial_omap_irq(int irq, void *dev_id)
> ? ? ? ? ? ? ? ?transmit_chars(up);
>
> ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> +
> ? ? ? ?up->port_activity = jiffies;
> ? ? ? ?return IRQ_HANDLED;
> ?}
> @@ -388,11 +416,12 @@ static unsigned int serial_omap_tx_empty(struct uart_port *port)
> ? ? ? ?unsigned long flags = 0;
> ? ? ? ?unsigned int ret = 0;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_tx_empty+%d\n", up->pdev->id);
> ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
> ? ? ? ?ret = serial_in(up, UART_LSR) & UART_LSR_TEMT ? TIOCSER_TEMT : 0;
> ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> -
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ? ? ? ?return ret;
> ?}
>
> @@ -402,7 +431,10 @@ static unsigned int serial_omap_get_mctrl(struct uart_port *port)
> ? ? ? ?unsigned char status;
> ? ? ? ?unsigned int ret = 0;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?status = check_modem_status(up);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> +
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_get_mctrl+%d\n", up->pdev->id);
>
> ? ? ? ?if (status & UART_MSR_DCD)
> @@ -433,9 +465,11 @@ static void serial_omap_set_mctrl(struct uart_port *port, unsigned int mctrl)
> ? ? ? ?if (mctrl & TIOCM_LOOP)
> ? ? ? ? ? ? ? ?mcr |= UART_MCR_LOOP;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?up->mcr = serial_in(up, UART_MCR);
> ? ? ? ?up->mcr |= mcr;
> ? ? ? ?serial_out(up, UART_MCR, up->mcr);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ?}
>
> ?static void serial_omap_break_ctl(struct uart_port *port, int break_state)
> @@ -444,6 +478,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
> ? ? ? ?unsigned long flags = 0;
>
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_break_ctl+%d\n", up->pdev->id);
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
> ? ? ? ?if (break_state == -1)
> ? ? ? ? ? ? ? ?up->lcr |= UART_LCR_SBC;
> @@ -451,6 +486,7 @@ static void serial_omap_break_ctl(struct uart_port *port, int break_state)
> ? ? ? ? ? ? ? ?up->lcr &= ~UART_LCR_SBC;
> ? ? ? ?serial_out(up, UART_LCR, up->lcr);
> ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ?}
>
> ?static int serial_omap_startup(struct uart_port *port)
> @@ -469,6 +505,7 @@ static int serial_omap_startup(struct uart_port *port)
>
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_startup+%d\n", up->pdev->id);
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?/*
> ? ? ? ? * Clear the FIFO buffers and disable them.
> ? ? ? ? * (they will be reenabled in set_termios())
> @@ -524,6 +561,8 @@ static int serial_omap_startup(struct uart_port *port)
> ? ? ? ?/* Enable module level wake up */
> ? ? ? ?serial_out(up, UART_OMAP_WER, OMAP_UART_WER_MOD_WKUP);
>
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ?up->port_activity = jiffies;
> ? ? ? ?return 0;
> ?}
> @@ -534,6 +573,8 @@ static void serial_omap_shutdown(struct uart_port *port)
> ? ? ? ?unsigned long flags = 0;
>
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_shutdown+%d\n", up->pdev->id);
> +
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?/*
> ? ? ? ? * Disable interrupts from this port
> ? ? ? ? */
> @@ -567,6 +608,7 @@ static void serial_omap_shutdown(struct uart_port *port)
> ? ? ? ? ? ? ? ? ? ? ? ?up->uart_dma.rx_buf_dma_phys);
> ? ? ? ? ? ? ? ?up->uart_dma.rx_buf = NULL;
> ? ? ? ?}
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ? ? ? ?free_irq(up->port.irq, up);
> ?}
>
> @@ -682,6 +724,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
> ? ? ? ? * Ok, we're now changing the port state. Do it with
> ? ? ? ? * interrupts disabled.
> ? ? ? ? */
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?spin_lock_irqsave(&up->port.lock, flags);
>
> ? ? ? ?/*
> @@ -814,6 +857,7 @@ serial_omap_set_termios(struct uart_port *port, struct ktermios *termios,
> ? ? ? ?serial_omap_configure_xonxoff(up, termios);
>
> ? ? ? ?spin_unlock_irqrestore(&up->port.lock, flags);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_set_termios+%d\n", up->pdev->id);
> ?}
>
> @@ -825,6 +869,8 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
> ? ? ? ?unsigned char efr;
>
> ? ? ? ?dev_dbg(up->port.dev, "serial_omap_pm+%d\n", up->pdev->id);
> +
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> ? ? ? ?efr = serial_in(up, UART_EFR);
> ? ? ? ?serial_out(up, UART_EFR, efr | UART_EFR_ECB);
> @@ -834,6 +880,7 @@ serial_omap_pm(struct uart_port *port, unsigned int state,
> ? ? ? ?serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B);
> ? ? ? ?serial_out(up, UART_EFR, efr);
> ? ? ? ?serial_out(up, UART_LCR, 0);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ?}
>
> ?static void serial_omap_release_port(struct uart_port *port)
> @@ -911,19 +958,26 @@ static inline void wait_for_xmitr(struct uart_omap_port *up)
> ?static void serial_omap_poll_put_char(struct uart_port *port, unsigned char ch)
> ?{
> ? ? ? ?struct uart_omap_port *up = (struct uart_omap_port *)port;
> +
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ?wait_for_xmitr(up);
> ? ? ? ?serial_out(up, UART_TX, ch);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> ?}
>
> ?static int serial_omap_poll_get_char(struct uart_port *port)
> ?{
> ? ? ? ?struct uart_omap_port *up = (struct uart_omap_port *)port;
> - ? ? ? unsigned int status = serial_in(up, UART_LSR);
> + ? ? ? unsigned int status;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> + ? ? ? status = serial_in(up, UART_LSR);
> ? ? ? ?if (!(status & UART_LSR_DR))
> ? ? ? ? ? ? ? ?return NO_POLL_CHAR;
>
> - ? ? ? return serial_in(up, UART_RX);
> + ? ? ? status = serial_in(up, UART_RX);
> + ? ? ? pm_runtime_put(&up->pdev->dev);
> + ? ? ? return status;
> ?}
>
> ?#endif /* CONFIG_CONSOLE_POLL */
> @@ -951,6 +1005,8 @@ serial_omap_console_write(struct console *co, const char *s,
> ? ? ? ?unsigned int ier;
> ? ? ? ?int locked = 1;
>
> + ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> +
> ? ? ? ?local_irq_save(flags);
> ? ? ? ?if (up->port.sysrq)
> ? ? ? ? ? ? ? ?locked = 0;
> @@ -983,6 +1039,8 @@ serial_omap_console_write(struct console *co, const char *s,
> ? ? ? ?if (up->msr_saved_flags)
> ? ? ? ? ? ? ? ?check_modem_status(up);
>
> + ? ? ? pm_runtime_mark_last_busy(&up->pdev->dev);
> + ? ? ? pm_runtime_put_autosuspend(&up->pdev->dev);
> ? ? ? ?if (locked)
> ? ? ? ? ? ? ? ?spin_unlock(&up->port.lock);
> ? ? ? ?local_irq_restore(flags);
> @@ -1065,19 +1123,18 @@ static struct uart_driver serial_omap_reg = {
> ? ? ? ?.cons ? ? ? ? ? = OMAP_CONSOLE,
> ?};
>
> -static int
> -serial_omap_suspend(struct platform_device *pdev, pm_message_t state)
> +static int serial_omap_suspend(struct device *dev)
> ?{
> - ? ? ? struct uart_omap_port *up = platform_get_drvdata(pdev);
> + ? ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>
> ? ? ? ?if (up)
> ? ? ? ? ? ? ? ?uart_suspend_port(&serial_omap_reg, &up->port);
> ? ? ? ?return 0;
> ?}
>
> -static int serial_omap_resume(struct platform_device *dev)
> +static int serial_omap_resume(struct device *dev)
> ?{
> - ? ? ? struct uart_omap_port *up = platform_get_drvdata(dev);
> + ? ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
>
> ? ? ? ?if (up)
> ? ? ? ? ? ? ? ?uart_resume_port(&serial_omap_reg, &up->port);
> @@ -1140,6 +1197,7 @@ static int serial_omap_start_rxdma(struct uart_omap_port *up)
> ? ? ? ?int ret = 0;
>
> ? ? ? ?if (up->uart_dma.rx_dma_channel == -1) {
> + ? ? ? ? ? ? ? pm_runtime_get_sync(&up->pdev->dev);
> ? ? ? ? ? ? ? ?ret = omap_request_dma(up->uart_dma.uart_dma_rx,
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?"UART Rx DMA",
> ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?(void *)uart_rx_dma_callback, up,
> @@ -1305,6 +1363,16 @@ static int serial_omap_probe(struct platform_device *pdev)
> ? ? ? ? ? ? ? ?up->uart_dma.rx_dma_channel = OMAP_UART_DMA_CH_FREE;
> ? ? ? ?}
>
> + ? ? ? pm_runtime_use_autosuspend(&pdev->dev);
> + ? ? ? pm_runtime_set_autosuspend_delay(&pdev->dev,
> + ? ? ? ? ? ? ? ? ? ? ? OMAP_UART_AUTOSUSPEND_DELAY);
> +
> + ? ? ? pm_runtime_irq_safe(&pdev->dev);
> + ? ? ? if (device_may_wakeup(&pdev->dev)) {
> + ? ? ? ? ? ? ? pm_runtime_enable(&pdev->dev);
> + ? ? ? ? ? ? ? pm_runtime_get_sync(&pdev->dev);
> + ? ? ? }
> +
> ? ? ? ?ui[pdev->id] = up;
> ? ? ? ?serial_omap_add_console_port(up);
>
> @@ -1312,6 +1380,7 @@ static int serial_omap_probe(struct platform_device *pdev)
> ? ? ? ?if (ret != 0)
> ? ? ? ? ? ? ? ?goto do_release_region;
>
> + ? ? ? pm_runtime_put(&pdev->dev);
> ? ? ? ?platform_set_drvdata(pdev, up);
> ? ? ? ?return 0;
> ?err:
> @@ -1326,22 +1395,96 @@ static int serial_omap_remove(struct platform_device *dev)
> ?{
> ? ? ? ?struct uart_omap_port *up = platform_get_drvdata(dev);
>
> - ? ? ? platform_set_drvdata(dev, NULL);
> ? ? ? ?if (up) {
> + ? ? ? ? ? ? ? pm_runtime_disable(&up->pdev->dev);
> ? ? ? ? ? ? ? ?uart_remove_one_port(&serial_omap_reg, &up->port);
> ? ? ? ? ? ? ? ?kfree(up);
> ? ? ? ?}
> +
> + ? ? ? platform_set_drvdata(dev, NULL);
> + ? ? ? return 0;
> +}
> +
> +static void serial_omap_restore_context(struct uart_omap_port *up)
> +{
> + ? ? ? serial_out(up, UART_OMAP_MDR1, up->mdr1);
> + ? ? ? serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
> + ? ? ? serial_out(up, UART_EFR, UART_EFR_ECB);
> + ? ? ? serial_out(up, UART_LCR, 0x0); /* Operational mode */
> + ? ? ? serial_out(up, UART_IER, 0x0);
> + ? ? ? serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
> + ? ? ? serial_out(up, UART_DLL, up->dll);
> + ? ? ? serial_out(up, UART_DLM, up->dlh);
> + ? ? ? serial_out(up, UART_LCR, 0x0); /* Operational mode */
> + ? ? ? serial_out(up, UART_IER, up->ier);
> + ? ? ? serial_out(up, UART_FCR, up->fcr);
> + ? ? ? serial_out(up, UART_LCR, UART_LCR_CONF_MODE_A);
> + ? ? ? serial_out(up, UART_MCR, up->mcr);
> + ? ? ? serial_out(up, UART_LCR, UART_LCR_CONF_MODE_B); /* Config B mode */
> + ? ? ? serial_out(up, UART_EFR, up->efr);
> + ? ? ? serial_out(up, UART_LCR, up->lcr);
> + ? ? ? /* UART 16x mode */
> + ? ? ? serial_out(up, UART_OMAP_MDR1, up->mdr1);
> +}
> +
> +static int serial_omap_runtime_suspend(struct device *dev)
> +{
> + ? ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
> + ? ? ? struct omap_uart_port_info *pdata = dev->platform_data;
> +
> + ? ? ? if (!up)
> + ? ? ? ? ? ? ? return -EINVAL;
> +
> + ? ? ? if (!pdata->enable_wakeup || !pdata->get_context_loss_count)
> + ? ? ? ? ? ? ? return 0;
> +
> + ? ? ? if (pdata->get_context_loss_count)
> + ? ? ? ? ? ? ? up->context_loss_cnt = pdata->get_context_loss_count(dev);
> +
> + ? ? ? if (device_may_wakeup(dev)) {
> + ? ? ? ? ? ? ? if (!up->wakeups_enabled) {
> + ? ? ? ? ? ? ? ? ? ? ? pdata->enable_wakeup(up->pdev, true);
> + ? ? ? ? ? ? ? ? ? ? ? up->wakeups_enabled = true;
> + ? ? ? ? ? ? ? }
> + ? ? ? } else {
> + ? ? ? ? ? ? ? if (up->wakeups_enabled) {
> + ? ? ? ? ? ? ? ? ? ? ? pdata->enable_wakeup(up->pdev, false);
> + ? ? ? ? ? ? ? ? ? ? ? up->wakeups_enabled = false;
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> + ? ? ? return 0;
> +}
> +
> +static int serial_omap_runtime_resume(struct device *dev)
> +{
> + ? ? ? struct uart_omap_port *up = dev_get_drvdata(dev);
> + ? ? ? struct omap_uart_port_info *pdata = dev->platform_data;
> +
> + ? ? ? if (up) {
> + ? ? ? ? ? ? ? if (pdata->get_context_loss_count) {
> + ? ? ? ? ? ? ? ? ? ? ? u32 loss_cnt = pdata->get_context_loss_count(dev);
> +
> + ? ? ? ? ? ? ? ? ? ? ? if (up->context_loss_cnt != loss_cnt)
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? serial_omap_restore_context(up);
> + ? ? ? ? ? ? ? }
> + ? ? ? }
> +
> ? ? ? ?return 0;
> ?}
>
> +static const struct dev_pm_ops serial_omap_dev_pm_ops = {
> + ? ? ? SET_SYSTEM_SLEEP_PM_OPS(serial_omap_suspend, serial_omap_resume)
> + ? ? ? SET_RUNTIME_PM_OPS(serial_omap_runtime_suspend,
> + ? ? ? ? ? ? ? ? ? ? ? ? ? ? ? serial_omap_runtime_resume, NULL)
> +};
> +
> ?static struct platform_driver serial_omap_driver = {
> ? ? ? ?.probe ? ? ? ? ?= serial_omap_probe,
> ? ? ? ?.remove ? ? ? ? = serial_omap_remove,
> -
> - ? ? ? .suspend ? ? ? ?= serial_omap_suspend,
> - ? ? ? .resume ? ? ? ? = serial_omap_resume,
> ? ? ? ?.driver ? ? ? ? = {
> ? ? ? ? ? ? ? ?.name ? = DRIVER_NAME,
> + ? ? ? ? ? ? ? .pm ? ? = &serial_omap_dev_pm_ops,
> ? ? ? ?},
> ?};
>
> --
> 1.7.4.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>


thanks,
-- 
Ming Lei
