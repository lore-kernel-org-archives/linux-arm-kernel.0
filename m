From: collinsd@codeaurora.org (David Collins)
Date: Mon, 28 Mar 2011 11:18:06 -0700
Subject: [PATCH 2/2] regulator: Propagate uA_load requirements up supply
	chain
In-Reply-To: <20110328180255.GA28494@opensource.wolfsonmicro.com>
References: <1301326482-6547-1-git-send-email-collinsd@codeaurora.org>
	<1301326482-6547-3-git-send-email-collinsd@codeaurora.org>
	<20110328180255.GA28494@opensource.wolfsonmicro.com>
Message-ID: <4D90D0DE.7050709@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/28/2011 11:02 AM, Mark Brown wrote:
> On Mon, Mar 28, 2011 at 08:34:42AM -0700, David Collins wrote:
>> regulator_set_optimum_mode currently only determines the load
>> on the specified regulator.  Physically however, this current
>> must be provided by regulators further up the supply chain.
>> Add code to handle uA_load propagation up through the regulator
>> supply chain.
> 
> We can't do this - current doesn't map 1:1 through a regulator, the
> power consumption will map through but obviously there's a voltage
> change involved and the regulators will not be 100% efficient so there
> will also be some overhead from the chipld regulator.  The child
> regulator needs to do the mapping in a regulator specific fashion.

I am aware that input current of a regulator will not simply be the sum of
the output current loads required by consumers.  I have accounted for this
by adding a new callback function in struct regulator_ops (from the patch):

+	/* get supply current required for load */
+	int (*get_current_required) (struct regulator_dev *, int input_uV,
+				     int output_uV, int load_uA);

The intention is that all hardware specific characteristics of a given
regulator can captured with this callback function.  The two simple cases
would be a linear regulator:

current_required = load_uA / efficiency + ground_current;

and a switching regulator:

current_required = load_uA * output_uV / (input_uV * efficiency)

I have set up the usage of this callback in the core such that if it is
not defined for regulators in a system, then the overall system operation
is identical to how it would be without the current propagation patch.

Can you look through the patch to see if the new API is reasonable?

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
