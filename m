From: balbi@ti.com (Felipe Balbi)
Date: Tue, 18 Feb 2014 10:24:16 -0600
Subject: [PATCH v2] usb: phy: msm: fix compilation errors when
 !CONFIG_PM_SLEEP
In-Reply-To: <20140117182650.GZ8153@joshc.qualcomm.com>
References: <87lhyemr3y.fsf@linaro.org>
 <1389981531-15539-1-git-send-email-joshc@codeaurora.org>
 <20140117182650.GZ8153@joshc.qualcomm.com>
Message-ID: <20140218162407.GF9878@saruman.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 12:26:50PM -0600, Josh Cartwright wrote:
> On Fri, Jan 17, 2014 at 11:58:51AM -0600, Josh Cartwright wrote:
> > Both the PM_RUNTIME and PM_SLEEP callbacks call into the common
> > msm_otg_{suspend,resume} routines, however these routines are only being
> > built when CONFIG_PM_SLEEP.  In addition, msm_otg_{suspend,resume} also
> > depends on msm_hsusb_config_vddcx(), which is only built when
> > CONFIG_PM_SLEEP.
> > 
> > Fix the CONFIG_PM_RUNTIME, !CONFIG_PM_SLEEP case by changing the
> > preprocessor conditional, and moving msm_hsusb_config_vddcx().
> > 
> > While we're here, eliminate the CONFIG_PM conditional for setting
> > up the dev_pm_ops.
> > 
> > This address the following errors Russell King has hit doing randconfig
> > builds:
> > 
> > drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_runtime_suspend':
> > drivers/usb/phy/phy-msm-usb.c:1691:2: error: implicit declaration of function 'msm_otg_suspend'
> > drivers/usb/phy/phy-msm-usb.c: In function 'msm_otg_runtime_resume':
> > drivers/usb/phy/phy-msm-usb.c:1699:2: error: implicit declaration of function 'msm_otg_resume'
> > 
> > Cc: Ivan T. Ivanov <iivanov@mm-sol.com>
> > Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
> > Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
> > ---
> > v1->v2: Change conditional to simply CONFIG_PM (thanks ccov and khilman!)
> > 
> >  drivers/usb/phy/phy-msm-usb.c | 57 ++++++++++++++++++++-----------------------
> >  1 file changed, 26 insertions(+), 31 deletions(-)
> > 
> > diff --git a/drivers/usb/phy/phy-msm-usb.c b/drivers/usb/phy/phy-msm-usb.c
> > index 8546c8d..5b169a7 100644
> > --- a/drivers/usb/phy/phy-msm-usb.c
> > +++ b/drivers/usb/phy/phy-msm-usb.c
> [..]
> > @@ -440,7 +414,32 @@ static int msm_otg_reset(struct usb_phy *phy)
> >  #define PHY_SUSPEND_TIMEOUT_USEC	(500 * 1000)
> >  #define PHY_RESUME_TIMEOUT_USEC	(100 * 1000)
> >  
> > -#ifdef CONFIG_PM_SLEEP
> > +#if CONFIG_PM
> 
> *sigh*.  This, of course, should have been #ifdef CONFIG_PM.  Fixed
> v3 below.

sorry, please git send-email it properly.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/3f152bfa/attachment.sig>
