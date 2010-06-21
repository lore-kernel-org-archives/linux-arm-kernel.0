From: viresh.kumar@st.com (Viresh KUMAR)
Date: Mon, 21 Jun 2010 12:14:28 +0530
Subject: [PATCH resend] GPIO PL061: Adding Clk framework support
In-Reply-To: <20100621063848.GA7582@n2100.arm.linux.org.uk>
References: <1277101943-6887-1-git-send-email-viresh.kumar@st.com>
	<20100621063848.GA7582@n2100.arm.linux.org.uk>
Message-ID: <4C1F0A4C.2070201@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/21/2010 12:08 PM, Russell King - ARM Linux wrote:
> On Mon, Jun 21, 2010 at 12:02:23PM +0530, Viresh KUMAR wrote:
>> @@ -56,8 +59,33 @@ struct pl061_gpio {
>>  	void __iomem		*base;
>>  	unsigned		irq_base;
>>  	struct gpio_chip	gc;
>> +	unsigned		usage_count;
>> +	struct clk		*clk;
>>  };
>>  
>> +static int pl061_request(struct gpio_chip *gc, unsigned offset)
>> +{
>> +	struct pl061_gpio *chip = container_of(gc, struct pl061_gpio, gc);
>> +
>> +	if (offset >= gc->ngpio)
>> +		return -EINVAL;
>> +
>> +	if (!chip->usage_count)
>> +		clk_enable(chip->clk);
> 
> Clocks are already use-counted.
> 

Yes. This is not required. Can simple call clk_enable and clk_disable.
