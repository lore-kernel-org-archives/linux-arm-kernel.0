From: enrico.scholz@sigma-chemnitz.de (Enrico Scholz)
Date: Wed, 13 Feb 2013 13:00:50 +0100
Subject: [i2c-mxs] Broken DMA operations from within a module
Message-ID: <lyehgkift9.fsf@ensc-virt.intern.sigma-chemnitz.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

the i2c-mxs driver does not work when transmit buffers are located
within module memory.

E.g. when doing something like

	struct i2c_msg xfer = {
               .buf = "something",
               ...
        };

        ret = i2c_transfer(client->adapter, &xfer, 1);

random data will be sent because buf is not DMA mapable ("something" is
located in the .strtab section within module memory). MXS has a memory
layout like

    vmalloc : 0xc8800000 - 0xff000000   ( 872 MB)
    lowmem  : 0xc0000000 - 0xc8000000   ( 128 MB)
    modules : 0xbf000000 - 0xc0000000   (  16 MB)
      .text : 0xc0008000 - 0xc04b1e8c   (4776 kB)
      .init : 0xc04b2000 - 0xc04e61ac   ( 209 kB)
      .data : 0xc04e8000 - 0xc051b578   ( 206 kB)
       .bss : 0xc051b578 - 0xc05eba44   ( 834 kB)

and is CONFIG_FLATMEM.  Buffers above are e.g. at 0xbf0cdaf0.

You can verify the problem e.g. with the edt-ft5x06.c touch driver;
dumping 'sg->dma_address' in mxs_dma_prep_slave_sg() shows physical
addresses like 0x3f0cdaf0 for such strings, which are outside of valid
memory (0x40000000-0x7fffffff).

Does the i2c layer require DMA mapable buffers in its xfer structures
(e.g. like usb), or is the problem in the generic ARM/MXS layer or in
the mxs i2c driver?



Enrico
