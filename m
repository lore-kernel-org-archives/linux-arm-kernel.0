From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Wed, 25 May 2016 12:00:58 -0700
Subject: [PATCH v2 4/9] remoteproc: Introduce Qualcomm WCNSS firmware
 loader
In-Reply-To: <574588E2.60506@linaro.org>
References: <1459222625-11440-1-git-send-email-bjorn.andersson@linaro.org>
 <1459222625-11440-5-git-send-email-bjorn.andersson@linaro.org>
 <574588E2.60506@linaro.org>
Message-ID: <20160525190058.GV1256@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 25 May 04:13 PDT 2016, Stanimir Varbanov wrote:

> On 03/29/2016 06:37 AM, Bjorn Andersson wrote:
> > From: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > 
> > This introduces the peripheral image loader, for loading WCNSS firmware
> > and boot the core on e.g. MSM8974. The firmware is verified and booted
> > with the help of the Peripheral Authentication System (PAS) in
> > TrustZone.
> > 
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@sonymobile.com>
> > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > ---
> > 
> > Changes since v1:
> > - Split iris definition into separate driver/dt-node
> > - Move constants from DT to code
> > - Make stop-state and some of interrupts optional to properly work on 8064
> > - Cleaned up and made mdt loader support relocation, which is needed on 8016.
> > 
> >  drivers/remoteproc/Kconfig           |  12 +
> >  drivers/remoteproc/Makefile          |   2 +
> >  drivers/remoteproc/qcom_mdt_loader.c | 172 +++++++++++
> >  drivers/remoteproc/qcom_mdt_loader.h |   7 +
> >  drivers/remoteproc/qcom_wcnss.c      | 579 +++++++++++++++++++++++++++++++++++
> >  drivers/remoteproc/qcom_wcnss.h      |  22 ++
> >  drivers/remoteproc/qcom_wcnss_iris.c | 185 +++++++++++
> >  7 files changed, 979 insertions(+)
> >  create mode 100644 drivers/remoteproc/qcom_mdt_loader.c
> >  create mode 100644 drivers/remoteproc/qcom_mdt_loader.h
> >  create mode 100644 drivers/remoteproc/qcom_wcnss.c
> >  create mode 100644 drivers/remoteproc/qcom_wcnss.h
> >  create mode 100644 drivers/remoteproc/qcom_wcnss_iris.c
> > 
> 
> <cut>
> 
> > +
> > +static int wcnss_remove(struct platform_device *pdev)
> > +{
> > +	struct qcom_wcnss *wcnss = platform_get_drvdata(pdev);
> > +
> > +	of_platform_depopulate(&pdev->dev);
> > +
> > +	qcom_smem_state_put(wcnss->state);
> > +	rproc_put(wcnss->rproc);
> 
> might be need to call rproc_del() too ?
> 

You're correct. Thanks for having a look!

Regards,
Bjorn
