From: simon@sequanux.org (Simon Guinot)
Date: Wed, 13 Oct 2010 11:59:51 +0000
Subject: [PATCH 4/5] hwmon: DNS323 rev C1 fan support
In-Reply-To: <1274525694.1931.142.camel@pasglop>
References: <1274525694.1931.142.camel@pasglop>
Message-ID: <20101013115951.GA5649@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benjamin,

What is the status for the DNS323 fan support ?
Have this patch been merged yet ?

I am currently looking to add hwmon support for the GPIO fan found
on Network Space Max v2 boards. Obviously, some attributes are shared
with the DNS323 fan. Maybe there is some room for a generic GPIO fan
driver ?

Platform data could provide the board specific GPIO pinout and a speed
conversion array (rpm from/to GPIO value). Here is a proposal for this
platform data interface:

struct gpio_fan {
        const char      *name;
        unsigned        gpio;
        unsigned        active_low;
};

struct gpio_fan_speed {
        int value;
        int rpm;
};

struct gpio_fan_platform_data {
        struct gpio_fan         *alarm; /* fan alarm GPIO. */
        struct gpio_fan         *ctrl;  /* fan control GPIOs. */
        int                     num_ctrl;
        /*
         * Speed conversion array: rpm from/to GPIO bit field.
         * This array _must_ be sorted in ascending rpm order.
         */
        struct gpio_fan_speed   *speed;
        int                     num_speed;
};

Based on this informations the GPIO fan driver could perform the
speed conversions (pwm, rpm, GPIO value) and then provide a hwmon
interface.

Thanks for advice.

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101013/4327f1b5/attachment.sig>
