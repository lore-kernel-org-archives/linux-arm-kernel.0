From: tom.leiming@gmail.com (Ming Lei)
Date: Fri, 23 Dec 2011 16:30:42 +0800
Subject: [QUESTION] How to set static/dynamic dependency between clock
 domains
In-Reply-To: <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
References: <CACVXFVMe7T2WJiDwc9DFz9ifUPQG4pcYzFtx6O=gs7pFgrkNJg@mail.gmail.com>
 <CACVXFVPOaw7OG7owJw0h7DAe3pRH6nROsy13UeAWPWgLedKY1g@mail.gmail.com>
 <CAMQu2gwDth6OVTk3PkRCo05QF6WeQvMTJ-d5s33cT35GSVwT=w@mail.gmail.com>
 <CACVXFVNtaaxB-MRXKBgAZFEkf72nsgcOSHOFsYjspoL0Fv6VWA@mail.gmail.com>
 <CAMQu2gzs6op9C8jDJ5xEGs7A7ok_GXeD5OxnHiDoeHaKghCJ5g@mail.gmail.com>
Message-ID: <CACVXFVOOQVe8u5TFZDYrNqvga-=RJ1mueaaqkBNB-s4BwkhiOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shilimkar,

Sorry for the delay.

On Mon, Dec 19, 2011 at 2:17 PM, Shilimkar, Santosh
<santosh.shilimkar@ti.com> wrote:

> The patches are fine but I am surprised that 'dyndep.patch' is helping you.
> L3_2 dependency is always enabled with ISS or Camera and it
> should have worked.
> clkdm_add_wkdep(iss_clkdm, l3_2_clkdm), shoudn't do anything since
> the bit is read-only.

Yes, you are right. After some investigating, I found that
clkdm_add_wkdep(iss_clkdm, l3_2_clkdm) returns failure, so clkdms_setup
is bypassed and the issue is avoided.

>
> Can you check value of CM_CAM_STATICDEP [ 0x4A009004],

The value is 0x40 after and before the patch.

> after your patch. I am suspecting that for some reason l3_1 dep.
> is getting enabled which might be helping your case.

Seems no changes after adding clkdm_add_wkdep(iss_clkdm, l3_1_clkdm)
on the problem.

The only change on iss(CAM) clock domain setting in your commit[1] is to
configure CLKTRCTRL as HW_AUTO, instead of previous  SW_WKUP.
Once I change flags of iss to CLKDM_CAN_SWSUP [2], the issue can be
fixed, so I am wondering if something is wrong about HW_AUTO mode
of CAM clock domain.


--?Ming Lei

[1],  ARM: OMAP4: PM: Initialise all the clockdomains to supported states

[2],  diff --git a/arch/arm/mach-omap2/clockdomains44xx_data.c
b/arch/arm/mach-omap2/clockdomains44xx_data.c
index 9299ac2..1dfc7ce 100644
--- a/arch/arm/mach-omap2/clockdomains44xx_data.c
+++ b/arch/arm/mach-omap2/clockdomains44xx_data.c
@@ -359,7 +359,7 @@ static struct clockdomain iss_44xx_clkdm = {
        .clkdm_offs       = OMAP4430_CM2_CAM_CAM_CDOFFS,
        .wkdep_srcs       = iss_wkup_sleep_deps,
        .sleepdep_srcs    = iss_wkup_sleep_deps,
-       .flags            = CLKDM_CAN_HWSUP_SWSUP,
+       .flags            = CLKDM_CAN_SWSUP,
 };
