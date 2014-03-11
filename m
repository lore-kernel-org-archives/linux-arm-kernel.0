From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 11:13:26 +0000
Subject: [PATCH v3 2/5] pinctrl: st: Enhance the controller to manage
 unavailable registers
In-Reply-To: <531EEBB9.1050405@st.com>
References: <1394203251-25361-1-git-send-email-maxime.coquelin@st.com>
 <1394203251-25361-3-git-send-email-maxime.coquelin@st.com>
 <20140310091707.GD14976@lee--X1> <531EC6C0.4080202@st.com>
 <531EEBB9.1050405@st.com>
Message-ID: <20140311111326.GB21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >>>From: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> >>>
> >>>This patch adds a new logic inside the st pinctrl to manage
> >>>an unsupported scenario: some sysconfig are not available!
> >>>
> >>>This is the case of STiH407 where, although documented, the
> >>>following registers from SYSCFG_FLASH have been removed from the SoC.
> >>>
> >>>SYSTEM_CONFIG3040
> >>>    Output Enable pad control for all PIO Alternate Functions
> >>>and
> >>>SYSTEM_ CONFIG3050
> >>>    Pull Up pad control for all PIO Alternate Functions
> >>>
> >>>Without managing this condition an imprecise external abort
> >>>will be detect.
> >>>
> >>>To do this the patch also reviews the st_parse_syscfgs
> >>>and other routines to manipulate the registers only if
> >>>actually available.
> >>>In any case, for example the st_parse_syscfgs detected
> >>>an error condition but no action was made in the
> >>>st_pctl_probe_dt.
> >>>
> >>>Signed-off-by: Maxime Coquelin <maxime.coquelin@st.com>
> >>>Signed-off-by: Giuseppe Cavallaro <peppe.cavallaro@st.com>
> >>>+
> >>>+static struct regmap_field *st_pc_get_value(struct device *dev,
> >>>+                        struct regmap *regmap, int bank,
> >>>+                        int data, int lsb, int msb)
> >>>+{
> >>>+    struct reg_field reg = REG_FIELD((data + bank) * 4, lsb, msb);
> >>>+
> >>>+    if (data < 0)
> >>>+        return NULL;
> >>
> >>What happens is data < 0 and it's used in REG_FIELD?
> >Nothing bad, but I agree this is not crystal clear.
> >
> >>Would it make more sense to make this check before calling REG_FIELD?
> >Yes, it will be done in the v4.
> 
> Finally, I have to keep it as it was if I want this patch to compile.

Ah, why's that?

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
