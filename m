From: broonie@kernel.org (Mark Brown)
Date: Thu, 6 Aug 2015 17:46:56 +0100
Subject: [RFC PATCH 1/5] spi: introduce flag for memory mapped read
In-Reply-To: <20150806135129.GJ7576@n2100.arm.linux.org.uk>
References: <55C0FD98.1090107@ti.com> <20150805115013.GJ20873@sirena.org.uk>
 <CAOMqctQXwcHyiWBwtugSDSE_k65qrNfrwnhjQMDJkLoJMmGzUw@mail.gmail.com>
 <20150805124412.GN20873@sirena.org.uk>
 <CAOMqctS9Y5FxpUCCJew6+cnjH5iTvbzkH3g-8yrXs4OuS2pSGA@mail.gmail.com>
 <20150806090202.GO20873@sirena.org.uk>
 <CAOMqctQZRZ4zG_yYy=CeX3DX4NVNWN1COP4Q-2YvMun9xYOA7g@mail.gmail.com>
 <20150806102225.GI7576@n2100.arm.linux.org.uk>
 <55C35233.2000105@ti.com>
 <20150806135129.GJ7576@n2100.arm.linux.org.uk>
Message-ID: <20150806164656.GY20873@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 06, 2015 at 02:51:29PM +0100, Russell King - ARM Linux wrote:

> The M25P80 driver just appends additional bytes to the message to
> achieve this:
> 
>         struct m25p *flash = nor->priv;
>         unsigned int dummy = nor->read_dummy;
> 
>         /* convert the dummy cycles to the number of bytes */
>         dummy /= 8;
> 
>         flash->command[0] = nor->read_opcode;
>         m25p_addr2cmd(nor, from, flash->command);
> 
>         t[0].tx_buf = flash->command;
>         t[0].len = m25p_cmdsz(nor) + dummy;
>         spi_message_add_tail(&t[0], &m);

> The reason that the number of dummy bytes can't be detected is because
> it's all hidden in the first transaction as the total number of bytes to
> be transmitted - and the dummy bytes are uninitialised, so you can't
> make any assumptions what value they are.  There is no way for the SPI
> driver to know whether these dummy bytes are dummy bytes or whether they
> have an effect on the targetted device.

We *could* (as you suggest below) indicate dummy transfers by having a
separate transfer which omits the transmit buffers though I'd expect
that normally that is going to be a small performance hit if interpreted
directly so we need to think what to do there.  We do get other devices
sending dummy bytes, it's sometimes a requirement for high speed
register access to give settling time for the device, so other things
would get some milage from it.

> What may make more sense from the SPI point of view is to communicate to
> all SPI drivers how many dummy bytes are to be transferred.  I'm not fully
> up on SPI, but maybe something like this:

> 	t[0].tx_buf = flash->command;
> 	t[0].len = m25p_cmdsz(nor);
> 	spi_message_add_tail(&t[0], &m);
> 	t[1].tx_buf = dummy_buffer;
> 	t[1].len = dummy;
> 	t[1].dummy = 1;
> 	spi_message_add_tail(&t[1], &m);

> This way, we're describing the transfer to the SPI core, and explicitly
> indicating that there are some dummy bytes.  The SPI driver can then
> tell that these are dummy bytes, and if the SPI message consists of:

That'd work as well, my first thought would to use NULL as a dummy
buffer pointer and let the core substitute in data for the drivers.  We
currently insist on having at least one buffer but that's fixable.

> This would not be a hack to the SPI code: we're describing to the SPI
> code what we want to achieve in terms of the activity on the bus, and
> providing that level of description then allows the SPI driver to make
> informed decisions on whether it can handle the transfer using some
> non-standard feature.

Yup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150806/9b3dcd74/attachment-0001.sig>
