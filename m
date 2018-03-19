From: robin.murphy@arm.com (Robin Murphy)
Date: Mon, 19 Mar 2018 18:16:15 +0000
Subject: [PATCH v3 08/10] clk: qcom: Add ACD path to CPU clock driver for
 msm8996
In-Reply-To: <152147863176.242365.17292287330283256524@swboyd.mtv.corp.google.com>
References: <1518616792-29028-1-git-send-email-ilialin@codeaurora.org>
 <1518616792-29028-9-git-send-email-ilialin@codeaurora.org>
 <152147863176.242365.17292287330283256524@swboyd.mtv.corp.google.com>
Message-ID: <41f3b246-43f4-450d-5c6b-34cdad7b15dd@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/03/18 16:57, Stephen Boyd wrote:
[...]
>> +
>> +       if (PWRCL_CPU_REG_MASK == (hwid | PWRCL_CPU_REG_MASK)) {
>> +               /* Enable Soft Stop/Start */
> 
> Sigh.
> 
>> +               if (vbases[APC_BASE])
> 
> When is this false?
> 
>> +                       writel_relaxed(SSSCTL_VAL, vbases[APC_BASE] +
>> +                                       PWRCL_REG_OFFSET + SSSCTL_OFFSET);
>> +               /* Ensure SSSCTL config goes through before enabling ACD. */
>> +               mb();
> 
> Use writel instead.

Note that writel() only gives an implicit wmb() *before* the store to 
ensure ordering against any previous writes. If this code really needs 
to ensure that the given write has definitely completed before any other 
accesses happen, then it still needs an explicit barrier *after* the 
write*(), unless perhaps the next access is always guaranteed to be a 
non-relaxed write (thus implicitly providing a suitable DSB).

Robin.
