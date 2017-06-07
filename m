From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Wed, 7 Jun 2017 17:37:09 +0300
Subject: [PATCH v4 16/28] tty: serial: owl: Implement console driver
In-Reply-To: <20170606005426.26446-17-afaerber@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-17-afaerber@suse.de>
Message-ID: <CAHp75VcYtdxknAw5b1zp+qLi1MT3ktwm99rOJEivcBrc+9B-cg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 6, 2017 at 3:54 AM, Andreas F?rber <afaerber@suse.de> wrote:
> Implement serial console driver to complement earlycon.
>
> Based on LeMaker linux-actions tree.

> +#define OWL_UART_CTL_DWLS_MASK         (0x3 << 0)

GENMASK() ?

> +#define OWL_UART_CTL_PRS_MASK          (0x7 << 4)

Ditto.

>  #define OWL_UART_STAT_TRFL_MASK                (0x1f << 11)

Ditto.

> +static struct owl_uart_port *owl_uart_ports[OWL_UART_PORT_NUM];

And this is needed for...?

> +static void owl_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
> +{
> +}

Do we need an empty stub?

> +static void owl_uart_send_chars(struct uart_port *port)
> +{

> +               xmit->tail = (xmit->tail + 1) & (SERIAL_XMIT_SIZE - 1);

% SERIAL_XMIT_SIZE shorter (I hope it's a power of 2), but it's up to you.

> +}

> +static irqreturn_t owl_uart_irq(int irq, void *dev_id)
> +{
> +       struct uart_port *port = (struct uart_port *)dev_id;

Useless casting.

> +       spin_lock(&port->lock);

spin_lock_irqsave() ?

Consider the kernel command option that switches all IRQ handlers to
be threaded.

> +}

> +static void owl_uart_change_baudrate(struct owl_uart_port *owl_port,
> +                                    unsigned long baud)
> +{
> +       clk_set_rate(owl_port->clk, baud * 8);
> +}

> +static void owl_uart_release_port(struct uart_port *port)
> +{
> +       struct platform_device *pdev = to_platform_device(port->dev);
> +       struct resource *res;
> +

> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return;
> +
> +       if (port->flags & UPF_IOREMAP) {
> +               devm_release_mem_region(port->dev, port->mapbase,
> +                       resource_size(res));
> +               devm_iounmap(port->dev, port->membase);
> +               port->membase = NULL;
> +       }

Above is entirely redundant.

> +}
> +
> +static int owl_uart_request_port(struct uart_port *port)
> +{
> +       struct platform_device *pdev = to_platform_device(port->dev);
> +       struct resource *res;
> +
> +       res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res)
> +               return -ENXIO;
> +
> +       if (!devm_request_mem_region(port->dev, port->mapbase,
> +                       resource_size(res), dev_name(port->dev)))
> +               return -EBUSY;
> +
> +       if (port->flags & UPF_IOREMAP) {
> +               port->membase = devm_ioremap_nocache(port->dev, port->mapbase,
> +                               resource_size(res));
> +               if (!port->membase)
> +                       return -EBUSY;
> +       }
> +
> +       return 0;
> +}

> +static void owl_uart_config_port(struct uart_port *port, int flags)
> +{

> +       if (flags & UART_CONFIG_TYPE) {

if (!(...))
 return;

?

> +               port->type = PORT_OWL;
> +               owl_uart_request_port(port);
> +       }
> +}


> +static int owl_uart_probe(struct platform_device *pdev)
> +{
> +       struct resource *res_mem, *res_irq;
> +       struct owl_uart_port *owl_port;
> +       int ret;
> +
> +       if (pdev->dev.of_node)
> +               pdev->id = of_alias_get_id(pdev->dev.of_node, "serial");
> +
> +       if (pdev->id < 0 || pdev->id >= OWL_UART_PORT_NUM) {
> +               dev_err(&pdev->dev, "id %d out of range\n", pdev->id);
> +               return -EINVAL;
> +       }
> +


> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +       if (!res_mem) {
> +               dev_err(&pdev->dev, "could not get mem\n");
> +               return -ENODEV;
> +       }

You can use

struct resource *mem;

mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
x = devm_ioremap_resource();
if (IS_ERR(x))
 return PTR_ERR(x);

and remote IOREMAP flag below.

> +       res_irq = platform_get_resource(pdev, IORESOURCE_IRQ, 0);
> +       if (!res_irq) {
> +               dev_err(&pdev->dev, "could not get irq\n");
> +               return -ENODEV;
> +       }

platform_get_irq()

> +       if (owl_uart_ports[pdev->id]) {
> +               dev_err(&pdev->dev, "port %d already allocated\n", pdev->id);
> +               return -EBUSY;
> +       }

I guess it's redundant. It should be conflicting by resource (for example, IRQ).

> +       owl_port->clk = clk_get(&pdev->dev, NULL);

devm_ ?

> +       owl_port->port.iotype = UPIO_MEM;
> +       owl_port->port.mapbase = res_mem->start;
> +       owl_port->port.irq = res_irq->start;


> +       owl_port->port.uartclk = clk_get_rate(owl_port->clk);

You need to check if it's 0 and use device property instead or bail out.

> +       owl_port->port.flags = UPF_BOOT_AUTOCONF | UPF_IOREMAP | UPF_LOW_LATENCY;
> +       owl_port->port.x_char = 0;
> +       owl_port->port.fifosize = 16;
> +       owl_port->port.ops = &owl_uart_ops;
> +
> +       owl_uart_ports[pdev->id] = owl_port;

> +       platform_set_drvdata(pdev, owl_port);

It should be just before return 0, right?..

> +
> +       ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
> +       if (ret)
> +               owl_uart_ports[pdev->id] = NULL;

...and thus, taking into consideration redundancy of that global var:

      ret = uart_add_one_port(&owl_uart_driver, &owl_port->port);
      if (ret)
          retrun ret;

      platform_set_drvdata(pdev, owl_port);
      return 0;

> +       return ret;
> +}

> +
> +static int owl_uart_remove(struct platform_device *pdev)
> +{

> +       struct owl_uart_port *owl_port;
> +
> +       owl_port = platform_get_drvdata(pdev);

Do above in one line.

> +       uart_remove_one_port(&owl_uart_driver, &owl_port->port);

> +       owl_uart_ports[pdev->id] = NULL;

Redundant.

> +
> +       return 0;
> +}

> +/* Actions Semi Owl UART */
> +#define PORT_OWL       117

We can use holes for now IIUC.

See 36 or alike

-- 
With Best Regards,
Andy Shevchenko
