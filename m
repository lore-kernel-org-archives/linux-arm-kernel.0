From: Jose.Abreu@synopsys.com (Jose Abreu)
Date: Fri, 2 Jun 2017 06:02:28 +0100
Subject: [PATCH 4/4] drm/bridge: dw-hdmi: add cec driver
In-Reply-To: <20170601223054.GH22219@n2100.armlinux.org.uk>
References: <20170530142218.GS22219@n2100.armlinux.org.uk>
 <E1dFi3P-0004lv-2K@rmk-PC.armlinux.org.uk>
 <e254fcf9-79bc-4ffc-284f-e52c80069fe3@synopsys.com>
 <20170601223054.GH22219@n2100.armlinux.org.uk>
Message-ID: <b1540ab1-8343-81c6-689f-fa85831680a8@synopsys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 01-06-2017 23:30, Russell King - ARM Linux wrote:
> On Thu, Jun 01, 2017 at 01:53:21AM +0100, Jose Abreu wrote:
>> Hi Russell,
>>
>>
>> On 30-05-2017 15:23, Russell King wrote:
>>> +static int dw_hdmi_cec_transmit(struct cec_adapter *adap, u8 attempts,
>>> +				u32 signal_free_time, struct cec_msg *msg)
>>> +{
>>> +	struct dw_hdmi_cec *cec = adap->priv;
>>> +	unsigned i;
>>> +
>>> +	cec->retries = attempts;
>> I think you should check first if CEC engine is in normal
>> operation mode, as a safety measure.
> I'm not sure what you mean there, because the iMX6 manuals don't mention
> anything about that.  The only "modes" it talks about is initiator mode
> and follower mode.  Moreover, there's nothing in what was FSL's driver
> that hints at that either.
>
> Maybe you could provide some further technical information on this
> point?
>

You should check that CEC is: not in standy, acknowledges
broadcast messages, signal free time is 5bit period, and not lost
arbitration, which basically means CEC_CTRL must be 0x2 and
IH_CEC_STAT0 must not have ARB_LOST set. I do know you set 0x3 at
the end of this function but according to all the docs I have you
must first set 0x2 before writing message.

Best regards,
Jose Miguel Abreu
