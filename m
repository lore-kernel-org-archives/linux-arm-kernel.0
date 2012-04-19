From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 19 Apr 2012 11:49:31 +0530
Subject: [PATCH 02/40] clk: add a fixed factor clock
In-Reply-To: <20120419061620.GA2790@glitch>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-3-git-send-email-s.hauer@pengutronix.de>
 <4F8F8AF1.3070802@st.com> <20120419061620.GA2790@glitch>
Message-ID: <4F8FAE73.9040900@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/19/2012 11:46 AM, Domenico Andreoli wrote:
> On Thu, Apr 19, 2012 at 09:18:01AM +0530, Viresh Kumar wrote:
>> On 4/10/2012 7:15 PM, Sascha Hauer wrote:
>> diff --git a/drivers/clk/clk-fixed-factor.c b/drivers/clk/clk-fixed-factor.c
>> @@ -16,7 +16,6 @@ struct clk_fixed_factor {
>>  	struct clk_hw	hw;
>>  	unsigned int	mult;
>>  	unsigned int	div;
>> -	char		*parent[1];
> 
> add const here
> 

I removed it. :)

>>  	clk = clk_register(dev, name,
>>  			&clk_fixed_factor_ops, &fix->hw,
>> -			fix->parent,
>> +			&parent_name,
> 
> &parent_name is a pointer to a stack variable, right? clk_register
> saves it in the clk struct for later use, when the stack is already gone.

Yes. It is on stack, but clk_register doesn't save it any more. Following is
part of clk_register that saves

	/* copy each string name in case parent_names is __initdata */
	for (i = 0; i < num_parents; i++) {
		clk->parent_names[i] = kstrdup(parent_names[i], GFP_KERNEL);
		if (!clk->parent_names[i]) {
			pr_err("%s: could not copy parent_names\n", __func__);
			goto fail_parent_names_copy;
		}
	}

This happened with following patch sent by Mike. This isn't pushed till now.

Author: Mike Turquette <mturquette@linaro.org>
Date:   Thu Apr 12 09:02:50 2012 +0800

    clk: core: copy parent_names & return error codes
    
    This patch cleans up clk_register and solves a few bugs by teaching
    clk_register and __clk_init to return error codes (instead of just NULL)
    to better align with the existing clk.h api.
    
    Along with that change this patch also introduces a new behavior whereby
    clk_register copies the parent_names array, thus allowing platforms to
    declare their parent_names arrays as __initdata.

--
Viresh
