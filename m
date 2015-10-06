From: festevam@gmail.com (Fabio Estevam)
Date: Tue, 6 Oct 2015 15:03:20 -0300
Subject: [PATCH 12/12] drm: bridge/dw_hdmi: improve HDMI enable/disable
 handling
In-Reply-To: <E1ZO6bd-0002vx-DL@rmk-PC.arm.linux.org.uk>
References: <20150808160251.GM7557@n2100.arm.linux.org.uk>
 <E1ZO6bd-0002vx-DL@rmk-PC.arm.linux.org.uk>
Message-ID: <CAOMZO5BCs-O3iJnit0sFJES8hUMJic6hDcP96y-HB=Jf0JDOLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 8, 2015 at 1:04 PM, Russell King
<rmk+kernel@arm.linux.org.uk> wrote:
> HDMI sinks are permitted to de-assert and re-assert the HPD signal to
> indicate that their EDID has been updated, which may not involve a
> change of video information.
>
> An example of where such a situation can arise is when an AV receiver
> is connected between the source and the display device.  Events which
> can cause the HPD to be deasserted include:
>
>  * turning on or switching to standby the AV receiver.
>  * turning on or switching to standby the display device.
>
> Each of these can change the entire EDID data, or just a part of the
> EDID data - it's up to the connected HDMI sink to do what they desire
> here.  For example
>
>  - with the AV receiver and display device both in standby, a source
>    connected to the AV receiver may provide its own EDID to the source.
>  - turning on the display device causes the display device's EDID to be
>    made available in an unmodified form to the source.
>  - subsequently turning on the AV receiver then provides a modified
>    version of the display device's EDID.
>
> Moreover, HPD doesn't tell us whether something is actually listening
> on the HDMI TDMS signals.  The phy gives us a set of RXSENSE indications
> which tell us whether there is a sink connected to the TMDS signals.
>
> Currently, we use the HPD signal to enable or disable the HDMI block,
> which is questionable when HPD is used in this manner.  Using the
> RXSENSE would be more appropriate, but there is some bad behaviour
> which needs to be coped with.  The iMX6 implementation lets the TMDS
> signals float when the phy is "powered down", which cause spurious
> interrupts.  Rather than just using RXSENSE, use RXSENSE and HPD
> becoming both active to signal the presence of a device, but loss
> of RXSENSE to indicate that the device has been unplugged.
>
> The side effect of this change is that a sink deasserting the HPD
> signal to cause a re-read of the EDID data will not cause the bridge
> to immediately disable the video signal.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
