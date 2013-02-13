From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 13 Feb 2013 12:14:50 +0000
Subject: [i2c-mxs] Broken DMA operations from within a module
In-Reply-To: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
References: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
Message-ID: <20130213121450.GA17833@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 13, 2013 at 01:00:50PM +0100, Enrico Scholz wrote:
> E.g. when doing something like
> 
> 	struct i2c_msg xfer = {
>                .buf = "something",
>                ...
>         };
> 
>         ret = i2c_transfer(client->adapter, &xfer, 1);
> 
> random data will be sent because buf is not DMA mapable ("something" is
> located in the .strtab section within module memory). MXS has a memory
> layout like

DMA buffers must be located in lowmem *always*.  This means placing them
in the .data segment does not work.  USB has been through this already
and it's well known there...
