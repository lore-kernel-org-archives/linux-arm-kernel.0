From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Wed, 04 Mar 2015 12:31:00 +0200
Subject: [PATCH 0/3] Add initial DT support for Qualcomm SPMI PMIC devices
In-Reply-To: <20150303081958.GA6293@codeaurora.org>
References: <1422965880-11047-1-git-send-email-iivanov@mm-sol.com>
 <54E6848C.1090405@codeaurora.org> <1424967957.2340.30.camel@mm-sol.com>
 <20150303081958.GA6293@codeaurora.org>
Message-ID: <1425465060.5705.4.camel@mm-sol.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On Tue, 2015-03-03 at 00:19 -0800, Stephen Boyd wrote:
> On 02/26, Ivan T. Ivanov wrote:
> > Hi Stephen,
> > 
> > Sorry for delayed answer.
> > 
> > On Thu, 2015-02-19 at 16:49 -0800, Stephen Boyd wrote:
> > > On 02/03/15 04:17, Ivan T. Ivanov wrote:
> > > > Following set of patches add initial DT support for PMIC devices
> > > > found on recent Quqalcomm chipsets. Details for SPMI bus and PMIC arbiter
> > > > could be found here [1].
> > > 
> > > Can you please put the specific compatible strings for the pmic model
> > > into the nodes in addition to the generic "qcom,spmi-pmic"? We may want
> > > to have regmap config tables in the future that describe the
> > > cache/read/write abilities of the regsiters. If all we have is the
> > > generic binding then we don't have a way to populate these tables.
> > > Unless the plan there is to use the revid registers?
> > > 
> > 
> > I would really like that we can use "revid" registers, but I don't know...
> > 
> > From what I can see usually in one physical PMIC chip they
> > are 2 USID devices.
> > 
> > I can successfully discover following USID's on APQ8074 boards:
> > 
> > pmic-spmi 0-00: qcom,pm8941-v1.0 detected
> > pmic-spmi 0-01: qcom,pm8941-v1.0 detected
> > pmic-spmi 0-04: qcom,pm8841-v0.0 detected
> > pmic-spmi 0-05: qcom,pm8841-v0.0 detected
> > 
> > Unfortunately on PM8916 only one device is detected, with USID 0.
> > But they should be two, judging by downstream DTS files, right?
> > 
> > pmic-spmi 0-00: qcom,pm8916-v0.0 detected
> > pmic-spmi 0-01: unknown device
> > 
> > For communication with PM8916 I am using recent patches from Gilad [1].
> > Maybe there are still some issues with these patches, which can cause
> > this behavior or PM8916 just didn't have these registers for USID 1?
> > 
> > Regards,
> > Ivan
> 
> Hmm... do you have 4 total rev-id nodes on apq8074? I only see
> one rev-id node per pmic (2 total), so I'm a little lost how the
> correct pmic version is detected on the 0-01 and 0-05 devices in
> your example above. 

Same confusion here. I am using this[1] patch to read revision info.

Address at offset 0x105 for USID 0,1 on PM8914 and USID 4,5 on PM8841
contains 0x51, which denotes them as PMIC's, so patch assumes that rest
of the registers have to contain valid version values.

Regards,
Ivan

[1] http://permalink.gmane.org/gmane.linux.kernel/1900135
