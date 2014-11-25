From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon, 24 Nov 2014 16:02:18 -0800
Subject: [RFC 0/2] Qualcomm RPM sleep states
In-Reply-To: <20141124215921.GA2872@sonymobile.com>
References: <1415659966-16200-1-git-send-email-bjorn.andersson@sonymobile.com>
 <546FC674.1070005@codeaurora.org>
 <CAJAp7OiLwMQEYFr9xdLg=S=cAPtN+hKZq3j5iSe0oL_Qz3URwg@mail.gmail.com>
 <5473A0F7.10308@codeaurora.org> <20141124215921.GA2872@sonymobile.com>
Message-ID: <5473C70A.7040705@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/24/2014 01:59 PM, Bjorn Andersson wrote:
> On Mon 24 Nov 13:19 PST 2014, Stephen Boyd wrote:
>
> [..]
>> What exactly are we circumventing? I can only guess that we're talking
>> about the aggregation logic?
>>
> We're circumventing the fact that the regulator core doesn't have knowledge
> about our multiple presented views of the same resource.

Sorry I don't follow here. Why would the regulator framework care about
the different views of a resource? Each regulator we make for the
different views will reflect the request made by Linux for a particular
set of that RPM resource. So all consumers who are using the S3 active +
sleep set regulator will aggregate into one request. Likewise, all the
consumers for the S3 active set regulator will aggregate into another
request. The only thing that isn't visible is the aggregation between
the active only and active + sleep regulators, but that can be
determined by doing a max() of the regulators. Even then, if we consider
that there are other masters also requesting voltages or enable/disable
for these resources we quickly discover there are other things the
regulator core doesn't have knowledge about, like what the actual
voltage is or if the regulator is really off vs. Linux requesting for it
to be off.

>
> As the downstream driver shows, if we just implement the right pieces it should
> work, i.e. give us the correct end result, but it will not be future proof nor
> pretty. That's why I think we need to discuss how to solve it either in the
> regulator driver or in the framework.
>
> And based on your feedback, it looks like we would have to do something about
> this in the framework.

I don't see any problems with making multiple regulators for one RPM
resource that represent the active set or active + sleep set. Everything
could be handled in the RPM regulator driver by looking for the other
regulators that are acting on the same RPM resource and aggregating.
Maybe you can elaborate on what you think isn't future proof nor pretty
about this design?

As a thought experiment, what if there really was two physical
independent controllable regulators and a pin from the CPU to the PMIC
toggled a mux to select between the two. Such a pin would only be
asserted when the CPU turned off. Would you still want to expose this as
one regulator to the kernel given that only one supply goes to the CPU
at any given time?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
