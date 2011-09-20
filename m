From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Tue, 20 Sep 2011 21:07:46 +0200
Subject: [PATCH v2 0/3] ARM: imx: Add cpuidle for imx platforms
In-Reply-To: <CAMXH7KHKhMSY6zW_Dyu1QWq-Q4siqBm5Epz8C_Pqc=UjJWHVPQ@mail.gmail.com>
References: <1316194070-21889-1-git-send-email-rob.lee@linaro.org>
	<20110920071633.GR31404@pengutronix.de>
	<CAMXH7KHKhMSY6zW_Dyu1QWq-Q4siqBm5Epz8C_Pqc=UjJWHVPQ@mail.gmail.com>
Message-ID: <20110920190746.GY31404@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 10:40:49AM -0500, Rob Lee wrote:
> Hello Sascha,
> 
> On 20 September 2011 02:16, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > Hi Robert,
> >
> > On Fri, Sep 16, 2011 at 12:27:47PM -0500, Robert Lee wrote:
> >> This patch series adds a common imx cpuidle driver, some common
> >> mach-mx5 level cpuidle functionality, and an i.MX51 instance of
> >> using this driver.
> >>
> >> The patch series is based on v3.1-rc2.
> >>
> >> Changes since v1:
> >> * To address all the problems found during review of v1, a complete
> >> re-write was needed.
> >
> > Much better than the last version, thanks.
> >
> 
> Thanks to Shawn Guo for thoroughly reviewing and providing
> feedback on this version and Jason Hui contributed to the reviewing
> as well despite both of them being very busy with there own
> submissions.
> 
> >>
> >> Robert Lee (3):
> >> ? ARM: imx: Add imx cpuidle driver
> >> ? ARM: imx: Add cpuidle for mach-mx5
> >> ? ARM: imx: Add cpuidle for i.MX51
> >>
> >> ?arch/arm/mach-mx5/Makefile ? ? ? ? ? ? ? | ? ?3 +-
> >> ?arch/arm/mach-mx5/cpu_op-mx51.c ? ? ? ? ?| ? 35 +++++++-
> >
> > Your additions to this file...
> >
> >> ?arch/arm/mach-mx5/cpu_op-mx51.h ? ? ? ? ?| ? ?1 +
> >> ?arch/arm/mach-mx5/mm.c ? ? ? ? ? ? ? ? ? | ? ?4 +
> >> ?arch/arm/mach-mx5/system.c ? ? ? ? ? ? ? | ? 35 +++++++
> >
> > And this one should go to arch/arm/mach-mx5/cpuidle.c, then we have
> > all i.MX5 specific cpuidle stuff together without ifdeffing the code.
> > I assume that cpuidle support for i.MX53 will look identically, right?
> >
> 
> After considering it further after the first patch, there can be differences
> between the i.MX51 and i.MX53 state data as i.MX51 supports an
> additional idle state that i.MX53 does not.  This state was not added
> to this version of the patch because it's additional power savings is very
> small and there is fairly time consuming characterization needed to
> come up with accurate cpuidle state data.  But to allow for the
> possibility that this state could be added in the future, it seemed the
> choice was to add this init data to the an i.MX51 specific file such as
> cpu_op-mx51.c/h and add ifdefs for cpuidle and cpufreq.  Or, make
> a cpuidle.c file as you suggest and add ifdefs for the different mx5
> SoCs.  Just let me know which way you think is better given this
> information.

Just put it in cpuidle.c for now. Better to have the cpuidle stuff
together in one file. We can still decide to move it to another place
should the need arise.

> 
> For the call to imx_cpuidle_init from imx51_soc_init in mm.c, this
> seems like a good location to initialize for all imx51_soc.  If I don't
> call the init from here, can you recommend another location that I
> should call it from?

Calling it from mm.c is fine.

Sascha


-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
