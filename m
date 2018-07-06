From: andriy.shevchenko@linux.intel.com (Andy Shevchenko)
Date: Fri, 06 Jul 2018 20:39:30 +0300
Subject: [PATCH v2 3/3] serial: 8250_dw: add fractional divisor support
In-Reply-To: <20180705145458.7e7d9b9f@xhacker.debian>
References: <20180704165908.4bb8b090@xhacker.debian>
 <20180704170310.56772d77@xhacker.debian>
 <f2733332a58e7f2d92948e2ff252581f93e5073a.camel@linux.intel.com>
 <20180705143921.6a8aeb50@xhacker.debian>
 <20180705145458.7e7d9b9f@xhacker.debian>
Message-ID: <891eef6922d6ed2c69fa28241d047ae8fded7804.camel@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2018-07-05 at 14:54 +0800, Jisheng Zhang wrote:
> On Thu, 5 Jul 2018 14:39:21 +0800 Jisheng Zhang wrote:
> 
> <snip>
> 
> > >   
> > > > +	serial_port_out(p, UART_LCR, up->lcr | UART_LCR_DLAB);
> > > > +	serial_dl_write(up, quot);    
> > > 
> > > At some point it would be a helper, I think. We can call
> > > serial8250_do_set_divisor() here. So, perhaps we might export
> > > it.  
> > 
> > serial8250_do_set_divisor will drop the frac, that's not we want ;)
> > 
> 
> And most importantly, serial8250_do_set_divisor() will set a wrong
> BRD(I)
> for fractional capable DW uarts. For example, clk = 25MHZ, baud =
> 115200.
> 
> In fractional capable DW uarts, we should set BRD(I) as
> 25000000/(16*115200) = 13
> 
> but serial8250_do_set_divisor() will set BRD(I) as
> DIV_ROUND_CLOSEST(25*1000000, 16*115200)) = 14

How come? It doesn't do any calculus (for DW 8250), it just writes few
registers based on input.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
