From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Nov 2017 16:28:53 +0000
Subject: [PATCH] drm/bridge: dw-hdmi: fix EDID parsing
In-Reply-To: <878tffa434.fsf@intel.com>
References: <E1eC22L-0003sN-Dw@rmk-PC.armlinux.org.uk>
 <20171109082317.predibr5vv2d33i2@phenom.ffwll.local>
 <20171109093122.GA12318@n2100.armlinux.org.uk>
 <87inejaiij.fsf@intel.com>
 <CAEzXK1qHEcB6f_uGPJk9RxSd+tP5rNuiutBN1FAkEv-nU1k5Ug@mail.gmail.com>
 <CAEzXK1qx=frs=Py3FhUK2vCfEp3Uzt2Nt=hKyxOnaP-nj4z8HA@mail.gmail.com>
 <87efp7abwi.fsf@intel.com>
 <CAEzXK1odLNgPTG_cAEqg8d2r_WbnqnVcCvAYQCHkRr4DgAHvhQ@mail.gmail.com>
 <878tffa434.fsf@intel.com>
Message-ID: <20171109162853.GD12318@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 09, 2017 at 05:01:35PM +0200, Jani Nikula wrote:
> On Thu, 09 Nov 2017, Lu?s Mendes <luis.p.mendes@gmail.com> wrote:
> > Hi Jani,
> >
> > I tried:
> > git clone git://people.freedesktop.org/~airlied/linux -b drm-next
> > --depth=1 --single-branch
> >
> > I got this:
> > EDID isn't loaded from file
> >
> > # cat /proc/cmdline
> > console=ttymxc0,115200 root=/dev/sda2 rw video=HDMI-A-1:1920x1080M at 60
> > drm.edid_firmware=edid/ktc_edid.bin dw_hdmi.dyndbg=+pfl cma=128M
> 
> Please try adding D at the end of your video= parameter to force
> connector on. Otherwise it'll do a ddc probe which apparently fails with
> your display.

I do hope you're not converting dw-hdmi to use DDC probing and having it
ignore the hotplug signal.  dw-hdmi has to work with AV setups, which
include an AV receiver, and that includes the AV receiver modifying the
HDMI data when:

(a) the TV is turned off or on.
(b) the AV receiver is placed into or out of standby

and it informs sources by pulsing the HDMI HPD signal, as per the HDMI
specification.  Proving the presence of DDC as a means of detection
won't pick up on these changes, and will cause a regression in the
driver.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
