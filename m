From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Wed, 6 Mar 2013 14:27:44 +0100
Subject: [PATCH 6/9] rtc: stmp3xxx: add sysfs entries for persistent regs
In-Reply-To: <20130305080252.GA7042@pengutronix.de>
References: <1362405948-12992-1-git-send-email-s.trumtrar@pengutronix.de>
 <1362405948-12992-7-git-send-email-s.trumtrar@pengutronix.de>
 <CACxGe6swW-UDH1cUw1D8P+gyhDC8nDZur-A_m_NBfeRUxcg9Jw@mail.gmail.com>
 <20130305080252.GA7042@pengutronix.de>
Message-ID: <20130306132744.GC13810@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 05, 2013 at 09:02:52AM +0100, Steffen Trumtrar wrote:
> Hi Grant!
> 
> On Mon, Mar 04, 2013 at 11:14:54PM +0800, Grant Likely wrote:
> > On Mon, Mar 4, 2013 at 10:05 PM, Steffen Trumtrar
> > <s.trumtrar@pengutronix.de> wrote:
> > > The persistent registers 1-5 are completely software defined. To have access
> > > from userspace, export them via sysfs.
> > >
> > > Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> > 
> > Hi Steffen,
> > 
> > A few comments on this. First and foremost, any additions to the
> > kernel sysfs interface must be accompanied with documentation in
> > Documentation/ABI/. Second, adding attributes to an existing device
> 
> Okay. I forgot that and will add it in the next version.
> 
> > that has already been registered is almost guaranteed to be wrong. The
> > attributes need to be added all at the same time so they are available
> > immediately when the new device uevent is issued by the kernel.
> > 
> > Instead, the correct thing to do is add an attribute_group to the
> > child device before the device gets registered. See the 'attributes'
> > section of Documentation/driver-model/device.txt to see how to do
> > this.
> > 
> > (I also see that the rtc core code is doing the wrong thing here also.
> > rtc_sysfs_add_device(), rtc_sysfs_add_device() should also be replaced
> > with an attribute group so that the sysfs files get added
> > automatically; but that is outside the scope of this patch)
> > 
> 
> Hm, I modeled it after other rtcs and the rtc_sysfs. Seems that I have to
> rework this.

Okay. Wait. I looked at it again. What I want to do is adding the persistent
registers as a binary-attribute. Basically having nvram like other rtcs.
Is that even possible with attribute group? Would I add the attr inside the
bin_attribute to the group then?
Or is it wrong to add these regs as binary?

Thanks,
Steffen

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
