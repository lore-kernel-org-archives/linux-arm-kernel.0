From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 10 Jun 2013 22:48:42 +0100
Subject: [PATCH RFC 2/8] DRM: Armada: Add Armada DRM driver
In-Reply-To: <51B5B41A.7070306@gmail.com>
References: <20130609190612.GM18614@n2100.arm.linux.org.uk>
 <E1UllJC-00058C-59@rmk-PC.arm.linux.org.uk> <51B5B41A.7070306@gmail.com>
Message-ID: <20130610214842.GB18614@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 10, 2013 at 01:10:18PM +0200, Sebastian Hesselbarth wrote:
> On 06/09/13 21:29, Russell King wrote:
>> +	/*
>> +	 * The spec is unclear about the polarities of the syncs.
>> +	 * We assume their non-inverted state is active high.
>> +	 */
>
> nit: "We confirmed their non-inverted state is active high."

Thanks, it's been a while since I looked at this so I had forgotten
to update the comment.  Now done.

>> +		if (resource_size(r) > SZ_4K)
>> +			mem = r;
>
> nit again: The register address window of Dove LCD is 64k although you  
> are right an no more than 512B are used. Also a comment would be nice,
> that everything above 4k (64k) is interpreted as gfx mem.

Fixed and comment added.

>> +	/* Create all LCD controllers */
>> +	for (n = 0; n < ARRAY_SIZE(priv->dcrtc); n++) {
>> +		struct clk *clk;
>> +
>> +		if (!res[n])
>> +			break;
>> +
>> +		clk = clk_get_sys("dovefb.0", "extclk");
>
> To be precise: the above should have the index at extclk as there
> is two extclk inputs that can be used for both lcdcs. So currently,
> as armada_crtc is hard-coding extclk0 input it should be
> "armadafb.%d", "extclk0".
>
> But I know, clocking in general will work-out with parent select for
> clk-mux and DT support.

I've sorted that out, but I'd forgotten there were three additional
patches on top of what I've posted sorting that stuff out - the
second one in particular:

4a5e9b7 DRM: armada: store kernel address for gem objects
f760c94 DRM: Dove: alternative variant based clocking
2e051fd DRM: Armada: convert hardware cursor support to 64x32 or 32x64 ARGB

Because they're scattered in other branches (the h/w cursor stuff
is separate) it's not trivial to generate a single series from git
for these.

>> +static const struct armada_output_type armada_drm_conn_slave = {
>> +	.connector_type	= DRM_MODE_CONNECTOR_HDMIA,
>
> For a rework of DRM slave encoder API, there should also be some way to
> get .connector_type and .encoder_type above from that slave encoder.
> IMHO it should be up to the slave encoder to determine connector and
> encoder type.

Encoder type - yes, but connector type doesn't seem sensible.  It's
possible for the TDA998x to be connected to a DVI connector - how
would the slave encoder know that?

>> diff --git a/drivers/gpu/drm/armada/armada_slave.h b/drivers/gpu/drm/armada/armada_slave.h
>> new file mode 100644
>> index 0000000..1b86696
>> --- /dev/null
>> +++ b/drivers/gpu/drm/armada/armada_slave.h
>> @@ -0,0 +1,26 @@
>> +/*
>> + * Copyright (C) 2012 Russell King
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +#ifndef ARMADA_TDA19988_H
>> +#define ARMADA_TDA19988_H
>
> nit: ARMADA_SLAVE_H

Nobbled. :)
