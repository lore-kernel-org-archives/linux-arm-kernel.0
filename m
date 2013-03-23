From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sat, 23 Mar 2013 16:17:44 +0100
Subject: [PATCH] ARM: Kirkwood: fix unused mvsdio gpio pins
In-Reply-To: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130323161744.5d13c570@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sebastian Hesselbarth,

On Sat, 23 Mar 2013 13:56:58 +0100, Sebastian Hesselbarth wrote:
> mvsdio_platform_data allows to pass card detect and write protect gpio
> numbers to the driver. Some kirkwood boards don't use both pins as
> they are not connected, and don't set the corresponding value in
> platform_data.
> 
> This will leave the unset values in platform_data initialized as 0,
> which is in fact a valid gpio pin. mvsdio will grab that pin and
> configure it as gpio, which in turn breaks nand controller as mpp0
> also carries nand_io2.
> 
> This patch fixes the above by initializing unused gpio functions in
> the platform_data with an invalid (-1) value.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Soeren Moch <smoch@web.de>

This somewhat "conflicts" with the patch I've submitted on the mvsdio
driver to exclude 0 as a valid GPIO, see
http://lists.infradead.org/pipermail/linux-arm-kernel/2013-March/157157.html.
This patch ensures that the mvsdio driver behaves as it was behaving
before 3.9 as far as legacy probing is concerned.

That said, I have nothing against explicitly setting those GPIO values
to an invalid value. Maybe -EINVAL would make more sense than just -1 ?

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
