From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 5 Oct 2018 16:33:48 +0800
Subject: [PATCH] ARM: dts: sun7i: Disable OOB IRQ for brcm wifi on
 Cubietruck and Banana Pro
In-Reply-To: <4b489dcb-e451-6f41-f583-5780bd25c800@redhat.com>
References: <20180930150927.12076-1-hdegoede@redhat.com>
 <20181001155704.dcqp637vsp2myyph@flea>
 <4b489dcb-e451-6f41-f583-5780bd25c800@redhat.com>
Message-ID: <CAGb2v65eGTBk_=q3cZcULqdZpn2A_61zwkir5oaUD0-mi9Bi3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hans,

On Tue, Oct 2, 2018 at 11:27 PM Hans de Goede <hdegoede@redhat.com> wrote:
>
> Hi Maxime,
>
> On 01-10-18 17:57, Maxime Ripard wrote:
> > Hi Hans,
> >
> > It's been a while :)
>
> Yes it has.
>
> > On Sun, Sep 30, 2018 at 05:09:27PM +0200, Hans de Goede wrote:
> >> While doing some brcmfmac driver work I needed to test this also on some
> >> devicetree based boards. So I fired up the good old Cubietruck and when
> >> that would not work a Banana Pro.
> >>
> >> With an unmodified 4.17 kernel both boards intermittently would come up
> >> with non working wifi with the following errors:
> >>
> >>   brcmfmac: brcmf_sdio_bus_rxctl: resumed on timeout
> >>   brcmfmac: brcmf_bus_started: failed: -110
> >>   brcmfmac: brcmf_attach: dongle is not responding: err=-110
> >>   brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
> >>
> >> They would come up this way more often then with actual working wifi,
> >> once this problem happens it seems to require a power-cycle to fix.
> >> Once things work one can safely reboot without hitting the issue.
> >>
> >> I've found that disabling OOB interrupts fixes this. This really is more
> >> of a workaround then a proper fix, but it makes the wifi reliable again
> >> and it does not have much of a downside.
> >>
> >> Using an OOB IRQ instead of the sdio-IRQ mechanism is mostly important to
> >> allow the MMC controller to go into runtime-suspend which is not really an
> >> issue on these boards since they are (usually) not battery powered.
> >>
> >> I've looked at recent brcmfmac and mmc-core changes which may explain this
> >> and I've not found anything. So the most likely culprit is the A20 external
> >> interrupt handling e.g. perhaps it is set to edge instead of level? Either
> >> way I do not have time to further investigate this.
> >>
> >> BugLink: https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=908438
> >> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
> >
> > Unfortunately, I'd really prefer if we were fixing this properly.
>
> I understand, but I really already have spend more time on this then
> I wanted to spend on it. If someone has an idea how to fix this I can
> *maybe* run some quick tests, but that is it.
>
> > You
> > were saying that the regression has been introduced between 4.17 and
> > 4.18, have you been able to bisect which commit was actually creating
> > this regression?
>
> Erm, no what I was trying to say is that I can reproduce the issue
> with 4.17, which is also the version mentioned in the Debian bug about
> the same problem. I've not tried older kernels then 4.17 so I do not
> know when this problem got introduced.
>
> > As you suggested, one reason could be the runtime_pm
> > introduction. This can be pretty easily tested by adding a
> > pm_runtime_get_sync call in the probe.
>
> I assume you mean the runtime pm support in the sunxi mmc controller
> driver, right ? When was that first introduced?
>
> I myself actually suspect the external irq handling code, but I
> guess that the runtime pm support code also is a likely cause
> of this.

I can confirm seeing this issue on the Bananapi M1+. On my Cubietruck
I'm seeing another issue. The OOB interrupt fires excessively, like
it was not properly acked. Dropping OOB and using SDIO interrupt
make it work normally. Disabling mmc runtime pm either by adding
pm_runtime_get_sync or by reverting all the related patches does not
help.

I don't quite remember when it was working properly though, since I
only noticed the issue this past week when I saw the LEDs lit up all
the time while rearranging things. Normally the LEDs are out of my
field of view.

On a separate topic, do you know of anyone that has gotten the serdev
bluetooth code to work with the AMPAK chips? Maxime tried when the
serdev code was first merged, and I tried last week. The bluetooth
part comes up with the hci interface looking normal and everything,
but it can't find any other devices. Scan commands give an error:

    Bluetooth: hci0: last event is not cmd complete (0x0f)

Thanks
ChenYu
