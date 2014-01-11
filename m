From: andrew@lunn.ch (Andrew Lunn)
Date: Sat, 11 Jan 2014 22:04:43 +0100
Subject: [PATCH] ARM: Kirkwood: Add DT description of QNAP 419
In-Reply-To: <1389174517.12612.87.camel@kazak.uk.xensource.com>
References: <1389048557-16364-1-git-send-email-andrew@lunn.ch>
 <1389174517.12612.87.camel@kazak.uk.xensource.com>
Message-ID: <20140111210443.GT9681@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 08, 2014 at 09:48:37AM +0000, Ian Campbell wrote:
> On Mon, 2014-01-06 at 23:49 +0100, Andrew Lunn wrote:

Hi Ian

I added in the devicetree list and the input list and added my
thoughts below.
 
> The other issue I spotted is
> that /dev/input/by-path/platform-gpio-keys-event has
> become /dev/input/by-path/platform-gpio_keys.3-event. Is it considered
> valid for a by-path name to change? In particular the 3 here is
> apparently the node depth in the DTB, which doesn't make much logical
> sense as a "path" in this context I don't think (I expect it to be some
> sort of path through the hardware buses, perhaps my expectation is
> wrong?).

The ts41x-setup.c board file creates the gpio keys platform device
using the following structure:

static struct platform_device qnap_ts41x_button_device = {
        .name           = "gpio-keys",
        .id             = -1,
        .num_resources  = 0,
        .dev            = {
                .platform_data  = &qnap_ts41x_button_data,
        }
};

The id of -1 causes platform_device_add() to set the device name to
plain "gpio-keys".

When using DT, the device name is created by the function
of_device_make_bus_id(). It has the following comment:

 * This routine will first try using either the dcr-reg or the reg property
 * value to derive a unique name.  As a last resort it will use the node
 * name followed by a unique number.

Since the gpio_keys node does not have a reg properties, it gets a
unique number appended to it. We end up with the device name
"gpio_keys.3"

So as it stands, it does not appear i can make the DT system use the
same device name as a board system.

But i'm also a little bit concerned by the "unique number" and this
ending up in /dev/input/by-path/platform-gpio_keys.3-event. Is this
path supposed to be stable? This unique number is not stable. An
unwitting change to the DT could cause its value to change. Do we need
to make it stable?

   Andrew
