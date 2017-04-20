From: robh@kernel.org (Rob Herring)
Date: Thu, 20 Apr 2017 09:02:53 -0500
Subject: [PATCH v4 02/11] clk: sunxi-ng: add support for DE2 CCU
In-Reply-To: <20170416120849.54542-3-icenowy@aosc.io>
References: <20170416120849.54542-1-icenowy@aosc.io>
 <20170416120849.54542-3-icenowy@aosc.io>
Message-ID: <20170420140252.vd6aeeweshx2tdou@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 16, 2017 at 08:08:40PM +0800, Icenowy Zheng wrote:
> The "Display Engine 2.0" in Allwinner newer SoCs contains a clock
> management unit for its subunits, like the DE CCU in A80.
> 
> Add a sunxi-ng style driver for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
> ---
> Changes in v4:
> - Fixed the inconsistence between mixer_div clocks' number and real clock.
> Changes in v2:
> - Rename sunxi-de2-ccu to sun8i-de2-ccu.
> 
>  drivers/clk/sunxi-ng/Kconfig          |   5 +
>  drivers/clk/sunxi-ng/Makefile         |   1 +
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.c  | 218 ++++++++++++++++++++++++++++++++++
>  drivers/clk/sunxi-ng/ccu-sun8i-de2.h  |  28 +++++
>  include/dt-bindings/clock/sun8i-de2.h |  54 +++++++++
>  include/dt-bindings/reset/sun8i-de2.h |  50 ++++++++

These 2 includes belong with the binding patch.

>  6 files changed, 356 insertions(+)
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.c
>  create mode 100644 drivers/clk/sunxi-ng/ccu-sun8i-de2.h
>  create mode 100644 include/dt-bindings/clock/sun8i-de2.h
>  create mode 100644 include/dt-bindings/reset/sun8i-de2.h


> diff --git a/include/dt-bindings/clock/sun8i-de2.h b/include/dt-bindings/clock/sun8i-de2.h
> new file mode 100644
> index 000000000000..982c6d18c75b
> --- /dev/null
> +++ b/include/dt-bindings/clock/sun8i-de2.h
> @@ -0,0 +1,54 @@
> +/*
> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

You can use SPDX tag here:

SPDX-License-Identifier: (GPL-2.0+ OR MIT)

> +
> +#ifndef _DT_BINDINGS_CLOCK_SUN8I_DE2_H_
> +#define _DT_BINDINGS_CLOCK_SUN8I_DE2_H_
> +
> +#define CLK_BUS_MIXER0		0
> +#define CLK_BUS_MIXER1		1
> +#define CLK_BUS_WB		2
> +
> +#define CLK_MIXER0		6
> +#define CLK_MIXER1		7
> +#define CLK_WB			8
> +
> +#endif /* _DT_BINDINGS_CLOCK_SUN8I_DE2_H_ */
> diff --git a/include/dt-bindings/reset/sun8i-de2.h b/include/dt-bindings/reset/sun8i-de2.h
> new file mode 100644
> index 000000000000..52af2dc55376
> --- /dev/null
> +++ b/include/dt-bindings/reset/sun8i-de2.h
> @@ -0,0 +1,50 @@
> +/*
> + * Copyright (C) 2016 Icenowy Zheng <icenowy@aosc.io>
> + *
> + * This file is dual-licensed: you can use it either under the terms
> + * of the GPL or the X11 license, at your option. Note that this dual
> + * licensing only applies to this file, and not this project as a
> + * whole.
> + *
> + *  a) This file is free software; you can redistribute it and/or
> + *     modify it under the terms of the GNU General Public License as
> + *     published by the Free Software Foundation; either version 2 of the
> + *     License, or (at your option) any later version.
> + *
> + *     This file is distributed in the hope that it will be useful,
> + *     but WITHOUT ANY WARRANTY; without even the implied warranty of
> + *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + *     GNU General Public License for more details.
> + *
> + * Or, alternatively,
> + *
> + *  b) Permission is hereby granted, free of charge, to any person
> + *     obtaining a copy of this software and associated documentation
> + *     files (the "Software"), to deal in the Software without
> + *     restriction, including without limitation the rights to use,
> + *     copy, modify, merge, publish, distribute, sublicense, and/or
> + *     sell copies of the Software, and to permit persons to whom the
> + *     Software is furnished to do so, subject to the following
> + *     conditions:
> + *
> + *     The above copyright notice and this permission notice shall be
> + *     included in all copies or substantial portions of the Software.
> + *
> + *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
> + *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
> + *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
> + *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
> + *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
> + *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
> + *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
> + *     OTHER DEALINGS IN THE SOFTWARE.
> + */

And here.

Rob
