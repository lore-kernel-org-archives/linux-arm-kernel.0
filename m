From: agross@codeaurora.org (Andy Gross)
Date: Mon, 9 Mar 2015 17:04:42 -0500
Subject: [RFC PATCH v15 01/11] ARM: cpuidle: Register per cpuidle device
In-Reply-To: <20150309214006.GA3727@linaro.org>
References: <1425914206-22295-1-git-send-email-lina.iyer@linaro.org>
 <1425914206-22295-2-git-send-email-lina.iyer@linaro.org>
 <20150309212926.GB17839@qualcomm.com>
 <20150309214006.GA3727@linaro.org>
Message-ID: <20150309220442.GA25292@qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 09, 2015 at 03:40:06PM -0600, Lina Iyer wrote:
<snip>

> >> 	for_each_possible_cpu(cpu) {
> >>+
> >> 		ret = arm_cpuidle_init(cpu);
> >>+		/*
> >>+		 * This cpu does not support any idle states
> >>+		 */
> >>+		if (ret == -ENOSYS)
> >>+			continue;
> >>+
> >> 		if (ret) {
> >> 			pr_err("CPU %d failed to init idle CPU ops\n", cpu);
> >> 			return ret;
> >> 		}
> >>+
> >>+		dev = kzalloc(sizeof(*dev), GFP_KERNEL);
> >
> >devm_kzalloc?  Otherwise, failures could lead to lost memory.
> >
> I dont have a local device to work with for allocation. May be I can get
> the cpu device node and the device therefore for allocation. Thoughts?

Ah, well the cpu device node could be used.  My only concern is that dev cannot
be referenced after the cpu is removed.

> >>+		if (!dev)
> >>+			return -ENOMEM;
> >>+
> >>+		dev->cpu = cpu;
> >>+		ret = cpuidle_register_device(dev);
> >>+		if (ret) {
> >>+			pr_err("Failed to register cpuidle device for CPU %d\n",
> >>+			       cpu);

<snip>

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
