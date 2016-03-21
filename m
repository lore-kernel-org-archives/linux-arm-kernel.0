From: agustinv@codeaurora.org (agustinv at codeaurora.org)
Date: Mon, 21 Mar 2016 11:56:59 -0400
Subject: [PATCH V1] perf: qcom: Add L3 cache PMU driver
In-Reply-To: <20160321090400.GQ6344@twins.programming.kicks-ass.net>
References: <1458333422-8963-1-git-send-email-agustinv@codeaurora.org>
 <20160321090400.GQ6344@twins.programming.kicks-ass.net>
Message-ID: <a3abed24d82e0a90a5b782219fa24d84@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016-03-21 05:04, Peter Zijlstra wrote:
> On Fri, Mar 18, 2016 at 04:37:02PM -0400, Agustin Vega-Frias wrote:
>> This adds a new dynamic PMU to the Perf Events framework to program
>> and control the L3 cache PMUs in some Qualcomm Technologies SOCs.
>> 
>> The driver supports a distributed cache architecture where the overall
>> cache is comprised of multiple slices each with its own PMU. The 
>> driver
>> aggregates counts across the whole system to provide a global picture
>> of the metrics selected by the user.
> 
> So is there never a situation where you want to profile just a single
> slice?

No, access to each individual slice is determined by hashing based on 
the target address.

> 
> It userspace at all aware of these slices through other means?

Userspace is not aware of the actual topology.

> 
> That is; typically we do not aggregate in-kernel like this but simply
> expose each slice as a separate PMU and let userspace sort things.

My decision of single vs. multiple PMUs was based on reducing the 
overhead required of retrieving the system-wide counts, which would 
require multiple system calls in the multiple-PMU case.
