From: arun.parameswaran@broadcom.com (Arun Parameswaran)
Date: Wed, 1 Aug 2018 14:45:22 -0700
Subject: [PATCH v3 7/8] net: phy: Add support to configure clock in
 Broadcom iProc mdio mux
In-Reply-To: <20180801203846.GE19257@lunn.ch>
References: <1533146186-8374-1-git-send-email-arun.parameswaran@broadcom.com>
 <1533146186-8374-8-git-send-email-arun.parameswaran@broadcom.com>
 <0cc6db4f-7008-0ad3-58d7-9e93060f152f@gmail.com>
 <20180801184659.GG30658@n2100.armlinux.org.uk>
 <9af7e7a3-54d4-8802-f64a-fc4f9c49c8b9@broadcom.com>
 <20180801200712.GD19257@lunn.ch>
 <20180801202313.GH30658@n2100.armlinux.org.uk>
 <20180801203846.GE19257@lunn.ch>
Message-ID: <8133c1f0-addc-5c48-7a6a-44b0d106c425@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Andrew, Russell,

On 18-08-01 01:38 PM, Andrew Lunn wrote:
> On Wed, Aug 01, 2018 at 09:23:14PM +0100, Russell King - ARM Linux wrote:
>> On Wed, Aug 01, 2018 at 10:07:12PM +0200, Andrew Lunn wrote:
>>> You might want to consider adding clk_optional_get() and
>>> devm_clk_optional_get().
>>
>> I think there's attempts to add such APIs but I don't think it's
>> trivial - it seems to require a _lot_ of discussion.
>>
>> I think part of that is because of the quirky use of error codes.
>> If you look at clk_get(), it calls __of_clk_get_by_name() which
>> returns:
>>
>>  -ENOENT if DT is disabled
>>  -ENOENT if the device has no DT node
>>  -EPROBE_DEFER if the lookup in DT succeeds but there's no registered
>>    clock
>>  -EINVAL if the device has a DT node but the lookup of the name
>>    failed (in otherwords, the optional clock was omitted)
>>  -ENOENT if the clocks = property has not enough clocks for the
>>     clock-names property
>>  -ENOMEM if we fail to allocate the clk
>>  -ENOENT if __clk_get() fails
> 
> That makes it hard. I added phy_optional_get() early on, when the
> error cases were simple. Hopefully they remain simple...
> 
>       Andrew
> 
I traced the devm_clk_get() and ran into various error codes, so I
figured I should return error on all the other errors (like ENOMEM, EINVAL
& EPROBE_DEFER) but 'ENOENT'.

But, looking at the errors from Russell's email, it looks like I
should look for both 'ENOENT' and 'EINVAL' and consider both these
errors as 'clock not specified' ?

Can I do something like this in the code for this patchset:

md->core_clk = devm_clk_get(&pdev->dev, NULL);
if (md->core_clk == ERR_PTR(-ENOENT) || md->core_clk == ERR_PTR(-EINVAL)) {
	/* clock is optional, without it the default
	 * rate divider register values will be used
	 */
	md->core_clk = NULL;
} else if (IS_ERR(md->core_clk)) {
	return PTR_ERR(md->core_clk);
} else {
	rc = clk_prepare_enable(md->core_clk);
	...
}

Thanks
Arun
