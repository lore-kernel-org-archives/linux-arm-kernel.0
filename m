From: gnomes@lxorguk.ukuu.org.uk (Alan Cox)
Date: Mon, 22 May 2017 19:26:36 +0100
Subject: [PATCH 1/1] xilinx ps uart: Adding a kernel parameter for the
 number of xilinx ps uarts
In-Reply-To: <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
References: <20170520022154.6766-1-kernel.development@povil.us>
 <20170520172008.5a979e8a@alans-desktop>
 <517d864d-d230-3abc-eb3c-4b628dc4625f@xilinx.com>
Message-ID: <20170522192636.5b578d89@alans-desktop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> We have in soc vendor tree similar patch but the reason is different.
> 
>     tty: serial: Added a CONFIG_SERIAL_XILINX_NR_UARTS option.
> 
>     This patch Adds CONFIG_SERIAL_XILINX_NR_UARTS option to allow
>     the user to provide the Max number of uart ports information.
>     If multiple cards (or) PL UARTS are present, the default limit
>     of 2 ports should be increased.
> 
> I haven't checked all drivers but in our case we have added this as
> quick fix for scenarios where you use serial aliases where alias is
> pointed to serial2 or more.
> In cdns_uart_init() cdns_uart_uart_driver is passed which contains .nr
> which is required to be passed.
> 
> What's the best driver to look at dynamic allocation?

So there are quite a few that dynamically allocate the objects as they
are enumerated (eg max3100), but have a maximum set that is just pointers
(so for the max number of ports cheaper than the dynamic code)

The other question is why is it a CONFIG_ option. I'm assuming these
platforms are all ARM and in that case you could just pass the value in
the device tree, or hard code a safe maximum number of pointers to a
value which is the worst case and then install them as they are
enumerated.

There are lots of options better than breaking the "one kernel many
platforms" model.

Alan
