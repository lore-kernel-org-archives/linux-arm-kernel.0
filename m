From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 27 Jan 2016 10:25:39 +0100
Subject: [PATCH 2/6] mtd: physmap_of: add a hook for Versatile write
 protection
In-Reply-To: <20160126113707.GL10826@n2100.arm.linux.org.uk>
References: <1453806725-4880-1-git-send-email-linus.walleij@linaro.org>
 <1453806725-4880-3-git-send-email-linus.walleij@linaro.org>
 <20160126113707.GL10826@n2100.arm.linux.org.uk>
Message-ID: <CACRpkdYnWiARgFACZ0P_m+awTPbUf5yoQSawphRiKkWRV8ZD1Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 12:37 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 26, 2016 at 12:12:01PM +0100, Linus Walleij wrote:
>> Solve this by looking for the arm,versatile-flash compatible
>> string in the flash device tree node. In the driver,
>> add a special hook to check for the various Versatile syscons and
>> register a callback for .set_vpp() if this compatible is present.
>
> You are aware that the "write enable" applies to all flash devices
> on the board, and not just NOR flash.  What that means is if you
> have drivers for the other flash devices, you need to have a way
> to enable writes when _any_ driver wants write access.
>
> So, it shouldn't be part of the flash driver at all.

Yes this is correct ... I put in the current code to be able to
test writes on the hardware. As to actually write to flash on
the Integrator both flags must be set to 1.

I don't see why it would just be a problem just for write
enable though, as I guess the VPP bit is *also* shared by all
devices?

After
commit 876fe76d793d03077
"mtd: maps: physmap: Add reference counter to set_vpp()"

As long as the flash devices are all physmap this reference
counter should hold VPP+WP enabled with this code as
long as any flash device has called .set_vpp().

It is a bit unintuitive that .set_vpp() is named like that though.
.enable_write() or something would be better I guess.
(The reference count also makes it start to reimplement
the regulator infrastructure.)

Yours,
Linus Walleij
