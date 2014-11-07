From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Fri, 07 Nov 2014 13:35:19 +0100
Subject: [PATCH 0/3] Add support for Tegra Activity Monitor
In-Reply-To: <545C8BCC.3090908@nvidia.com>
References: <1414594232-15684-1-git-send-email-tomeu.vizoso@collabora.com>
 <545C8BCC.3090908@nvidia.com>
Message-ID: <545CBC87.7050404@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/07/2014 10:07 AM, Alexandre Courbot wrote:
> On 10/29/2014 11:50 PM, Tomeu Vizoso wrote:
>> Hello,
>>
>> these patches implement support for setting the rate of the EMC clock based on
>> stats collected from the ACTMON, a piece of hw in the Tegra124 that counts
>> memory accesses (among others).
>>
>> It depends on the following in-flight patches:
>>
>> * MC driver: http://thread.gmane.org/gmane.linux.ports.tegra/19623
>> * EMC driver: http://thread.gmane.org/gmane.linux.ports.arm.kernel/365125
>> * CPUFreq driver: http://thread.gmane.org/gmane.linux.kernel/1812962
>>
>> I have pushed a branch here for testing:
> 
> I am not too familiar with DVFS, but after going through this series it 
> really seems to me that this could use devfreq. In its current form this 
> driver mixes control and policy and lacks flexibility, preventing e.g. 
> to switch to a performance or power-saving profile. Could you study the 
> feasibility of using devfreq for this?

Yeah, I started writing a devfreq driver, but then I looked in more
detail to the downstream driver and realized that most of the
functionality that devfreq provides overlaps with the hw.

The ACTMON can be configured to fire an interrupt when a set of
thresholds are crossed, similar to the simple-ondemand governor but a
bit more sophisticated. The only functionality of the governors that
isn't covered by the ACTMON hw is determining the new frequency after a
threshold has been crossed, but if we want to retain the flexibility of
the downstream solution, we would need to write a new governor anyway.

I realize that it would be cool to reuse the code in devfreq, but being
able to let the hw sample the counters, calculating averages and
checking if a threshold has been crossed without the cpu having to
intervene gives this SoC quite an edge when compared to its competitors.

Regards,

Tomeu
