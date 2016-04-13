From: akshay.bhat@timesys.com (Akshay Bhat)
Date: Wed, 13 Apr 2016 10:48:14 -0400
Subject: [PATCH v4 3/3] ARM: imx6: Fix procedure to switch the parent of
 LDB_DI_CLK
In-Reply-To: <1459353746.2505.86.camel@pengutronix.de>
References: <1456476714-11351-1-git-send-email-p.zabel@pengutronix.de>
 <1456476714-11351-4-git-send-email-p.zabel@pengutronix.de>
 <56D60C90.7080703@timesys.com> <1459353746.2505.86.camel@pengutronix.de>
Message-ID: <570E5C2E.7050402@timesys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On 03/30/2016 12:02 PM, Philipp Zabel wrote:
> Hi Akshay,
>
> Am Dienstag, den 01.03.2016, 16:41 -0500 schrieb Akshay Bhat:
> [...]
>>> +		/*
>>> +		 * It is unclear whether the procedure works for switching from
>>> +		 * pll3_usb_otg to any other parent than pll5_video_div
>>> +		 */
>>> +		if (sel[i][0] > 3 && sel[i][0] != (sel[i][3] | 4)) {
>>> +			pr_err("ccm: ldb_di%d_sel workaround only for top mux\n",
>>> +			       i);
>>> +			sel[i][3] = sel[i][2] = sel[i][1] = sel[i][0];
>>> +			continue;
>>> +		}
>>
>> EB821 doesn't mention the above restriction. My understanding was as
>> long as the clock source you are switching from/to is disabled it should
>> be ok to do so. Maybe someone from Freescale can comment?
>
> Maybe. If the only issue was that all input clocks have to be disabled,
> I don't understand why the intermediate steps 3 -> 7 -> 4 -> 0 are
> necessary though. See below for an explanation why I felt I have no idea
> how to properly switch from 4 to 1, for example. Maybe this is indeed
> not a problem at all and this condition can just be dropped. Do you have
> a way to test this?
>

I do not have a way of reliably recreating the issue (happens only on 
few boards and even on those boards it is highly intermittent and seems 
to depend on factors like temperature, timing etc.). So I am hesitant to 
rely on any collected test data to suggest if the intermediate steps are 
not required. I understand the errata is rather lacking on why the 
intermediate steps are required but I feel at this point it is best to 
follow the workaround suggested by Freescale/NXP.

Thanks,
Akshay
