From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Wed, 30 Mar 2016 00:18:58 +0200
Subject: [PATCH v4 8/8] arm64: dts: rockchip: Add Landingship config
In-Reply-To: <3754303.PKl0CGdnnX@diego>
References: <1458136727-32075-1-git-send-email-afaerber@suse.de>
 <1458136727-32075-9-git-send-email-afaerber@suse.de>
 <3754303.PKl0CGdnnX@diego>
Message-ID: <56FAFF52.3000301@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 29.03.2016 um 22:18 schrieb Heiko St?bner:
> This needs a commit message explaining the i2c1/i2c2 voodoo below - especially 
> as this is the only difference to the core geekbox board.

You're probably right about the commit message, but there is no voodoo
about i2c2 below.

Would you rather have i2c1 dropped for now? Having it disabled at least
documents that the connectors are there.

>From a distro perspective I like dtb filename stability and not needing
to mess with filename changing from .dtb to -landingship.dtb, so I
rather add it from the start than later as more nodes get added.

> And I'm still not fully convinced about having the landing ship separate.

Separate would've been copy&paste! It's using the preprocessor
specifically to avoid having them be separate.

> I guess I'll just go to the talk about "Portable Device Tree Connector: 
> Painless Expansion Board Support" [0] on monday to help make up my mind ;-) .

This is not a random expansion board to exchange, it's a baseboard and
as we found out one very specific to this module, so no reuse unlike
Shields. As mentioned elsewhere, I2C are not the only difference,
they're the only difference _for now_. USB-SATA bridge comes for free
via USB node; there's four GPIO buttons to be figured out, an I2S codec
somewhere, display options (that I cannot test myself) and additional
regulator(s) needed.

Do enjoy the talk and report your findings. The pure existence of
overlays for Beagleboard is not convincing to me for dropping this patch
though - we've had similar discussions among distro people before
settling for EFI boot. Reality is messy, unfortunately. For an FPGA I've
grudgingly agreed that given a sane U-Boot one can use dtb commands to
add a couple nodes via a boot.scr, sanitizing the matrix of hardware
models x FPGA bitstreams to just the hardware models; however this
Landingship board is actually sold in hardware and is the only sane
rk3368 devboard to date rather than just some bitstream file, and we at
openSUSE are looking to abandon boot.scr in favor of generic bootefi,
running counter to that idea. Here I'm still dealing with a vendor
U-Boot, so neither works for now, only supplying a feature-complete .dtb
in the resource image partition does, which I need to build from
something - this patch. So no is not a solution. And it's not like
you're swamped in rk3368 .dts files anyway.

Thanks for queuing the core bits,

Andreas

> [0] http://openiotelc2016.sched.org/event/6DA4/portable-device-tree-connector-painless-expansion-board-support-pantelis-antoniou-konsulko-group
[...]
>> +&i2c1 {
>> +	status = "disabled";
>> +};
>> +
>> +&i2c2 {
>> +	status = "okay";
>> +};

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton; HRB 21284 (AG N?rnberg)
