From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 16 Dec 2013 19:29:12 +0800
Subject: [PATCH 2/2] ASoC: sgtl5000: clean up sgtl5000_enable_regulators()
In-Reply-To: <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
References: <1386916983-27832-1-git-send-email-shawn.guo@linaro.org>
 <1386916983-27832-2-git-send-email-shawn.guo@linaro.org>
 <00a7a941be434caf829f9fd246879c6d@BY2PR03MB505.namprd03.prod.outlook.com>
 <20131213125129.GV18380@S2101-09.ap.freescale.net>
 <892cbb07bd064f44b2af45f106aeb479@BY2PR03MB505.namprd03.prod.outlook.com>
Message-ID: <20131216112910.GB30671@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 16, 2013 at 03:31:29AM +0000, Li.Xiubo at freescale.com wrote:
> Well, the regulator_get_optional() is still needed to improve.
> For instance, if dts is not used for one platform and the external VDDD supply is
> absent. The regulator_get_optional() will return -EPROBE_DEFER, so the SGTL5000's
> probe, and then the SGTL5000 will do the deferral probe, and this time the same
> -EPROBE_DEFER error will return again. 

Yea, it seems in non-DT that regulator core can not figure out the
-ENODEV case like it does in DT, so it simply returns -EPROBE_DEFER no
matter whether the regulator is absent or it's present but just not
registered yet.  IOW, it can not distinguish between these two cases in
non-DT case.

Neither am I aware of any non-DT SGTL5000 users in the tree, nor I care.
I'm not concerned by this issue.

> Where should this special handling be dealt with ? Is here or regulator_get_optional()
> will be better ?

Anyway, this is another issue which should be addressed in regulator
core, IMO.

Shawn
