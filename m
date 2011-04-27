From: niclas.karlsson@enea.se (Niclas Karlsson)
Date: Wed, 27 Apr 2011 18:27:39 +0200
Subject: Getting a lot of zero values from a driver using DMA. D-cache is
	not updated?
Message-ID: <1303921659.19857.141.camel@SESTOWS194>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi!

I'm running linux on a custom made harware based on AT91SAM9263-ek
(evaluation board from Atmel). A touchcontroller (ads7846) is connected
to the SPI bus. When I read data
(cat /sys/bus/spi/devices/spi0.1/in0_input or in1_input) from the two
extra AD-channels in the ads7846 chip I get a zero value very often. The
ads7846 driver uses the atmel_spi driver. The ads7846 driver allocates
memory with kzalloc(). the atmel_spi then uses dma_map_single() before
starting the transfer with PDC (Peripheral Dma Controller). When the
transfer has finished, an interrupt is fired from the SPI.
dma_unmap_single() is then called and the value from the ADC should be
in the allocated buffer, but it's not. The buffer is still zero. If I
add a delay (like printk("wait\n")) the value from the ADC can be read
in the buffer. How do I fix this? Could it be that the d-cache is not
updated with the new value which is written by the PDC? If so, how do I
update the cache with the value the PDC just wrote to RAM?

Best regard
Niclas 
