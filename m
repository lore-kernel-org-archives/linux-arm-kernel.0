From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 23 Mar 2016 09:38:42 -0700
Subject: [PATCH] ARM64: dts: amlogic: add basic support for P200 and
 odroid-C2
In-Reply-To: <56F1E847.3060004@suse.de> ("Andreas =?utf-8?Q?F=C3=A4rber=22?=
 =?utf-8?Q?'s?= message of "Wed, 23 Mar 2016 01:50:15 +0100")
References: <1458692498-9210-1-git-send-email-khilman@baylibre.com>
 <56F1E847.3060004@suse.de>
Message-ID: <7htwjxqhd9.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Am 23.03.2016 um 01:21 schrieb Kevin Hilman:
>> Add basic, minimal DT files for the Amlogic GXBB-based P200
>> development board and Hardkernel ODROID-C2 boards.
>> 
>> Used the other gxbb boards from Andreas F?rber as a starting point.
>> 
>> Cc: Andreas F?rber <afaerber@suse.de>
>> Cc: Carlo Caione <carlo@endlessm.com>
>> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
>> ---
>> Boot tested on top of next-20160321 on both boards.
>> 
>>  arch/arm64/boot/dts/amlogic/Makefile               |  2 +
>>  .../arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts | 65 +++++++++++++++++++++
>>  arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts    | 66 ++++++++++++++++++++++
>>  3 files changed, 133 insertions(+)
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>>  create mode 100644 arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> 
>> diff --git a/arch/arm64/boot/dts/amlogic/Makefile b/arch/arm64/boot/dts/amlogic/Makefile
>> index eb672f38f89e..2cbaea3587ae 100644
>> --- a/arch/arm64/boot/dts/amlogic/Makefile
>> +++ b/arch/arm64/boot/dts/amlogic/Makefile
>> @@ -1,6 +1,8 @@
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-pro.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-meta.dtb
>>  dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-vega-s95-telos.dtb
>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-p200.dtb
>
> Please keep the list sorted alphabetically. (vega-s95 only deviates in
> keeping Pro and Meta sorted in logically ascending order.)

OK.

>> +dtb-$(CONFIG_ARCH_MESON) += meson-gxbb-odroidc2.dtb
>
> Hm, intuitively I would've named it meson-gxbb-odroid-c2.dtb. But I see
> that all other *odroid*.dts are named this way, so best to stick to the
> scheme I guess.

Yeah, I would've preferred odroid-c2 as well, but decided to stick to
the pattern already set.

>>  
>>  always		:= $(dtb-y)
>>  subdir-y	:= $(dts-dirs)
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> new file mode 100644
>> index 000000000000..1a9e0332729c
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
>> @@ -0,0 +1,65 @@
>> +/*
>> + * Copyright (c) 2016 Andreas F?rber
>> + * Copyright (c) 2016 BayLibre, Inc.
>> + * Author: Kevin Hilman <khilman@kernel.org>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxbb.dtsi"
>> +
>> +/ {
>> +	compatible = "amlogic,meson-gxbb-odroidc2", "amlogic,meson-gxbb";
>
> This should be "hardkernel,odroid-c2", "amlogic,meson-gxbb".
>
> And the compatible string needs to be documented in
> Documentation/devicetree/bindings/arm/amlogic.txt. Officially that's
> requested to be a separate patch, so maybe split P200 and C2 while at it
> to encourage people providing a Tested-by for this more common one?

OK.

>> +	model = "Hardkernel ODROID-C2";
>> +	
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x80000000>;
>> +	};
>> +};
>> +
>> +&uart_AO {
>> +	status = "okay";
>> +};
>
> Otherwise looks good and I tested a similar dtb (telos) okay on the
> ODROID-C2.
>
>> diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> new file mode 100644
>> index 000000000000..231abf2d719d
>> --- /dev/null
>> +++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-p200.dts
>> @@ -0,0 +1,66 @@
>> +/*
>> + * Copyright (c) 2016 Andreas F?rber
>> + * Copyright (c) 2016 BayLibre, Inc.
>> + * Author: Kevin Hilman <khilman@kernel.org>
>> + *
>> + * This file is dual-licensed: you can use it either under the terms
>> + * of the GPL or the X11 license, at your option. Note that this dual
>> + * licensing only applies to this file, and not this project as a
>> + * whole.
>> + *
>> + *  a) This library is free software; you can redistribute it and/or
>> + *     modify it under the terms of the GNU General Public License as
>> + *     published by the Free Software Foundation; either version 2 of the
>> + *     License, or (at your option) any later version.
>> + *
>> + *     This library is distributed in the hope that it will be useful,
>> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>> + *     GNU General Public License for more details.
>> + *
>> + * Or, alternatively,
>> + *
>> + *  b) Permission is hereby granted, free of charge, to any person
>> + *     obtaining a copy of this software and associated documentation
>> + *     files (the "Software"), to deal in the Software without
>> + *     restriction, including without limitation the rights to use,
>> + *     copy, modify, merge, publish, distribute, sublicense, and/or
>> + *     sell copies of the Software, and to permit persons to whom the
>> + *     Software is furnished to do so, subject to the following
>> + *     conditions:
>> + *
>> + *     The above copyright notice and this permission notice shall be
>> + *     included in all copies or substantial portions of the Software.
>> + *
>> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
>> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
>> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
>> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
>> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
>> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
>> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
>> + *     OTHER DEALINGS IN THE SOFTWARE.
>> + */
>> +
>> +/dts-v1/;
>> +
>> +#include "meson-gxbb.dtsi"
>> +
>> +/ {
>> +	compatible = "amlogic,meson-gxbb-p200", "amlogic,meson-gxbb";
>
> How unique is P200? I wonder whether we could simplify this to
> "amlogic,p200", "amlogic,meson-gxbb". I.e., is there or might there be a
> P200 board for a different SoC?

OK.

>> +	model = "Amlogic Meson GXBB P200 Development Board";
>> +	
>> +	chosen {
>> +		stdout-path = "serial0:115200n8";
>> +	};
>> +
>> +	memory at 0 {
>> +		device_type = "memory";
>> +		reg = <0x0 0x0 0x0 0x40000000>;
>> +	};
>> +};
>> +
>> +/* This UART is brought out to the DB9 connector */
>> +&uart_AO {
>> +	status = "okay";
>> +};
>
> Otherwise looks fine.

Thanks, I'll respin shortly.

Kevin
