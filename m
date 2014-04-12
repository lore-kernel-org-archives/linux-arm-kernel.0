From: tharvey@gateworks.com (Tim Harvey)
Date: Sat, 12 Apr 2014 01:04:58 -0700
Subject: [PATCH] ARM: imx: propagate DI clock changes up the clock tree to
 PLL5
In-Reply-To: <1397224812.4577.10.camel@weser.hi.pengutronix.de>
References: <E1WXuag-0007Gs-Ku@rmk-PC.arm.linux.org.uk>
 <CAJ+vNU1uzKCZxjsr+inuOi_VJbs+iR14uqXKOCr_32ZS__HrZQ@mail.gmail.com>
 <CAJ+vNU0V_vXDOvergiQ2q00EFL46kGFJCvqCS=hdW5x=0rjN5Q@mail.gmail.com>
 <1397224812.4577.10.camel@weser.hi.pengutronix.de>
Message-ID: <CAJ+vNU1GmrR7L+H9gGPjEDzQdKeCsB5Z08T7Ex6TXT_qD_pgAQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 11, 2014 at 7:00 AM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Hi Tim,
>
> I think this is fallout from how we handle the EDID fetch on startup. We
> have patches lying around to fix this. Will post them in a minute.
>
> Regards,
> Lucas

Lucas,

I applied your 4 patches, but that didn't resolve my situation where
the display isn't enabled when connected on board powerup. It appears
that imx_hdmi_poweron() isn't called in this case.

It looks like the issue is that when drm_helper_hpd_irq_event is
called from the first imx_hdmi_irq polling is not yet enabled and thus
it doesn't call the other helpers which would end up calling
imx_hdmi_poweron. Polling gets enabled at the very end of
imx_drm_driver_load which is after the irq is requested, fired, and
serviced.

I'm not clear what the right solution is - should the poll be enabled
earlier, or should imx_hdmi_encoder_dpms(...) be called someplace at
registration?

Tim
