From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Jan 2013 17:45:46 +0000
Subject: [PATCH 1/5] dmaengine: dw_dmac: move to generic DMA binding
In-Reply-To: <201301291636.38773.arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
 <201301291455.49347.arnd@arndb.de>
 <20130129154409.GA23505@n2100.arm.linux.org.uk>
 <201301291636.38773.arnd@arndb.de>
Message-ID: <20130129174546.GE23505@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 29, 2013 at 04:36:38PM +0000, Arnd Bergmann wrote:
> If the pl080 driver already has code for the mux in it, then it should
> handle both of_dma_controller instances in my example. It would
> not change anything regarding the binding, which just describes the
> way that the hardware is connected. I have not looked at the implementation
> of the pl080 driver, but I'd assume we could get away with just having
> two separate xlate() functions.

Well, how it all works in the PL08x driver at present is:

- the platform code passes into the PL08x driver a description of the
  virtual channels, eg:

        [1] = {
                /* Muxed on channel 0-3 */
                .bus_id = "aacirx",
                .min_signal = 0,
                .max_signal = 2,
                .muxval = 0x01,
                .periph_buses = PL08X_AHB1 | PL08X_AHB2,
        },

- the virtual channels include:
  - the minimum and maximum index of the DMA request signals into the
    PL08x that can be used with this peripheral.
  - the the register value for the external mux, if any.
  - other PL08x specific data to do with this DMA peripheral

- when a virtual channel is requested by a DMA client, it claims just
  the virtual channel.  No actual hardware resources are assigned,
  and no mappings are setup.

- when a transfer is prepared on a virtual channel, part of the
  preparation is to locate the request signal to be used - and
  platform code is requested to supply that from the description
  associated with the channel (such as the above fragment.)

- the versatile PL08x code looks at min_signal/max_signal, and walks
  this space looking for an unassigned request signal.  If there is
  an external mux associated with this request signal, the mux is
  appropriately programmed.  If a request signal is currently assigned
  the next request signal will be tried until there are no further
  possibilities, when failure occurs.  In that case, the prepare
  function also fails.

- the PL08x driver then knows which request signal is associated with
  the peripheral, and sets up the descriptors to be dependent on this
  request signal.  This mapping must not change until the transfer
  has completed.

- when the descriptor is completed - and freed, the muxing is released
  and the DMA request signal becomes available for other users to make
  use of.

Practically, what this means is that:

(a) we've ensured that all drivers using PL08x do _not_ expect that
descriptors can always be prepared; they must continue to work correctly
when the prepare function returns NULL.

(b) several devices end up sharing the first three request signals
and they're used on an opportunistic basis.  Theoretically, if you have
one of these boards where AACI DMA works, you can be using one of these
DMA requests for audio playback, another for record, and the remaining
one can be used on an opportunistic basis between the second MMCI
interface (should that also work - which I've proven is an impossiblity!)
and the 3rd UART... or the USB if there was a driver for that device.
