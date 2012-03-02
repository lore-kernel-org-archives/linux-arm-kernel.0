From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 2 Mar 2012 20:24:19 +0000
Subject: [PATCH 6/6] ARM: at91: add Shutdown Controller (SHDWC) DT support
In-Reply-To: <1330718048-9314-6-git-send-email-plagnioj@jcrosoft.com>
References: <20120302192844.GB21255@game.jcrosoft.org>
 <1330718048-9314-6-git-send-email-plagnioj@jcrosoft.com>
Message-ID: <201203022024.19488.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 02 March 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:
> +       }
> +
> +       if (of_device_is_compatible(np, "atmel,at91sam9x5-shdwc")) {
> +               have_rtt = false;
> +               have_rtc = true;
> +       } else if (of_device_is_compatible(np, "atmel,at91sam9rl-shdwc")) {
> +               have_rtt = true;
> +               have_rtc = true;
> +       } else {
> +               have_rtt = true;
> +               have_rtc = false;
> +       }
> +
> +       if (have_rtc && of_property_read_bool(np, "atmel,wakeup-rtc-timer"))
> +                       mode |= AT91_SHDW_RTCWKEN;
> +
> +       if (have_rtt && of_property_read_bool(np, "atmel,wakeup-rtt-timer"))
> +                       mode |= AT91_SHDW_RTTWKEN;
> +
> +       at91_shdwc_write(AT91_SHDW_MR, wakeup_mode | mode);
> +

Hi Jean-Christophe,

I don't understand why you check the specific part here. Isn't it enough to
check the property when you already mandate that they can only be present
on devices that support the specific wakeup?

If there is a good explanation for that, maybe add a code comment why it's
required.

	Arnd
