From: leigh@solinno.co.uk (Leigh Brown)
Date: Sat, 19 Oct 2013 17:23:50 +0100
Subject: [PATCH RFC 0/4] MDIO bus timeout issues on Dreamplug
Message-ID: <cover.1382199042.git.leigh@solinno.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I just upgraded my Dreamplug to kernel 3.12-rc4 and began encountering
timeout errors in the log, like the following :-

orion-mdio f1072004.mdio-bus: Timeout when reading PHY

I discovered that the mv643xx_eth driver had been converted to use the
mvmdio driver to talk to the PHY rather than the old code that was
embedded in the driver.  The new code had some inconsistent timeouts
and always polled for a response rather than using the interrupt, where
available.  The timeout was 1ms when polling but the Dreamplug can
take up to 4.9ms to respond.

So, making reference to the old 3.9 driver I changed the mvmdio driver
to have more consistent timeouts and use interrupts to poll, where
available. I set the timeout to 10ms.  Patches 1 and 2 do this.

I got carried away checking the size of the code and patch 3 is a 
simple optimisation to reduce the code size. The final patch updates
the documentation in mvmdio to make it reflect the current situation.

I have tested the patches on my Dreamplug and Mirabox and have not 
encountered any issues.

One final thing I noticed when testing: you can unload the mvmdio 
driver and the machine will crash shortly after.  I tried to understand
how the module reference counting would apply to these kinds of drivers
and got a bit stuck.  I think these modules should not be unloadable
while there is an ethernet driver that uses them.

Regards,

Leigh.

Leigh Brown (4):
  net: mvmdio: make orion_mdio_wait_ready consistent
  net: mvmdio: orion_mdio_ready: remove manual poll
  net: mvmdio: slight optimisation of orion_mdio_write
  net: mvmdio: doc: mvmdio now used by mv643xx_eth

 drivers/net/ethernet/marvell/mvmdio.c |   93 +++++++++++++++------------------
 1 file changed, 42 insertions(+), 51 deletions(-)

-- 
1.7.10.4
