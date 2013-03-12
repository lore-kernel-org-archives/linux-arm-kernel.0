From: davidb@codeaurora.org (David Brown)
Date: Mon, 11 Mar 2013 23:51:08 -0700
Subject: [PATCH 1/6] platform-drivers: msm: add single-wire serial bus
 interface (SSBI) driver
In-Reply-To: <20130307013008.GA2910@kroah.com> (Greg Kroah-Hartman's message
 of "Thu, 7 Mar 2013 09:30:08 +0800")
References: <1362616187-21089-1-git-send-email-davidb@codeaurora.org>
 <1362616187-21089-2-git-send-email-davidb@codeaurora.org>
 <20130307013008.GA2910@kroah.com>
Message-ID: <8yamwu9nmar.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:

>> +static int ssbi_wait_mask(struct msm_ssbi *ssbi, u32 set_mask, u32 clr_mask)
>> +{
>> +	u32 timeout = SSBI_TIMEOUT_US;
>> +	u32 val;
>> +
>> +	while (timeout--) {
>> +		val = ssbi_readl(ssbi, SSBI2_STATUS);
>> +		if (((val & set_mask) == set_mask) && ((val & clr_mask) == 0))
>> +			return 0;
>> +		udelay(1);
>
> Busy loop?  Really?

Finally was able to dig up some of the reason for this.  The
transactions typically take about 5us.  In the case of contention with
another CPU, it could take as much as 20us.

Would it be sufficient to just explain this in a comment?

David
