From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 12 May 2015 21:36:13 +0100
Subject: [PATCH v3 1/4] ARM: pxa: add memory resource to RTC device
In-Reply-To: <53644246.uSkhGz7C05@wuerfel>
References: <1431384089-28367-1-git-send-email-robh@kernel.org>
 <87lhgumi4b.fsf@belgarion.home> <878uctmtm6.fsf@belgarion.home>
 <53644246.uSkhGz7C05@wuerfel>
Message-ID: <20150512203613.GQ2067@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 12, 2015 at 10:30:12PM +0200, Arnd Bergmann wrote:
> On Tuesday 12 May 2015 22:24:49 Robert Jarzmik wrote:
> > 
> > I made the try, and Russell was right, this breaks the pxa architecture. The
> > relevant extract of kernel message is in [1].
> > 
> > The consequences with your patches :
> >  - pxa27x_init()
> >    - platform_add_devices()
> >      - the pxa_device_rtc fails (as resource is duplicated)
> >      - all the devices are unregistered (rollback)
> > And pxa27x fails.
> > 
> > Now I'm pondering about the right approach :
> >  - either remove sa1100_device_rtc from pxas
> >  - or remove pxa_device_rtc
> >  - or both
> >  - or something else
> > 
> > Let me think a bit about it.
> > 
> 
> To solve the problem with the duplicate registration of one resource,
> I'd suggest using platform_device_register_simple() for the registration,
> which will copy the resource. You can then mark the resource as __initconst
> and remove the device to save a little memory at runtime.

No, a better solution is to solve the problem which requires the
duplication in the first place, which is a broken driver structure.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
