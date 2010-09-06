From: viresh.kumar@st.com (viresh kumar)
Date: Mon, 6 Sep 2010 16:56:55 +0530
Subject: [PATCH 35/74] ST SPEAr: Enabling clocks before amba
	device	registeration
In-Reply-To: <20100902100247.GL26319@n2100.arm.linux.org.uk>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<96b4972a92cab5025a89bd71a4e23fa29aa41cba.1283161023.git.viresh.kumar@st.com>
	<20100902100247.GL26319@n2100.arm.linux.org.uk>
Message-ID: <4C84CFFF.9080107@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 9/2/2010 3:32 PM, Russell King - ARM Linux wrote:
> On Mon, Aug 30, 2010 at 04:08:59PM +0530, Viresh KUMAR wrote:
> 
> No description, so I'm going to have to guess about this.

Sorry!!

> 
>> +static inline void
>> +spear_amba_device_register(struct amba_device **devices, u32 count)
>> +{
>> +	u32 i;
>> +
>> +	for (i = 0; i < count; i++) {
>> +		struct clk *clk = clk_get_sys(devices[i]->dev.init_name, NULL);
>> +		if (IS_ERR(clk))
>> +			continue;
>> +
>> +		clk_enable(clk);
>> +		amba_device_register(devices[i], &iomem_resource);
>> +		clk_disable(clk);
> 
> My guess is that you're doing this to work around the fact that your
> SoC enables/disables both the bus clock and the functional clock to
> each primecell, and so you're finding that you need to enable the
> clock to access the device registers.
> 
> We've fixed this in the generic code by introducing an 'apb_pclk' clock
> which the core bus code controls (and eventually drivers.)  See discussion
> earlier this month/last month on this list about this.
> 
> That makes this patch redundant.
> .

Yes this patch is not required.
