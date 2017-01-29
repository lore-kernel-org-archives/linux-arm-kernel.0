From: sre@kernel.org (Sebastian Reichel)
Date: Sun, 29 Jan 2017 19:50:12 +0100
Subject: syscon-poweroff: add a mask property
In-Reply-To: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
References: <71309f45-0f6c-a7af-eb01-59400f0c93a1@mobi-wize.com>
Message-ID: <20170129185012.ltzc5ocw42dz7buq@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jan 29, 2017 at 02:04:00PM +0200, Guy Shapiro wrote:
> The syscon-poweroff driver powers off the machine by writing a value to
> a register. Both the register and the value are configured via the
> device tree.
> 
> I encountered a situation where I need to mask the written value - some
> values of the register must remain unchanged during the power-down.
> (This is required to turn on the i.mx6ul using the RTC. See [1] for more
> details.)
> 
> Unfortunately, the property of the register value is currently named
> mask, so we can't just add a "mask" property.
> 
> The solutions I could think of:
> 1) Add a new mask property and name it "mask_mask" or something like
> that.
> 2) Create a new "syscon-masked-poweroff" driver that will have value and
> mask properties.
> 
> What do you think?

I suggest the we add a value property to the binding [0]
and use the following logic in the driver to keep
compatibility with the old binding:

if (!value) {
    /* support for old binding */
    val = mask;
    mask = 0xFFFFFFFF;
} else if (!mask) {
    /* support for just providing value */
    mask = 0xFFFFFFFF;
    val = value;
}

regmap_update_bits(map, offset, mask, val);

[0] Documentation/devicetree/bindings/power/reset/syscon-poweroff.txt

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170129/5f0dd3f4/attachment.sig>
