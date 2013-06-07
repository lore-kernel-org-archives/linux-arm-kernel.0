From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 07 Jun 2013 10:33:10 -0600
Subject: [PATCH] ARM: tegra: add basic SecureOS support
In-Reply-To: <CAAVeFu+by44HnOzv_85kwgeCx5b9TxiMhr27x69QcUj9GRbk8A@mail.gmail.com>
References: <1370503687-17767-1-git-send-email-acourbot@nvidia.com>
 <51B0BC80.9040007@wwwdotorg.org>
 <CAAVeFu+by44HnOzv_85kwgeCx5b9TxiMhr27x69QcUj9GRbk8A@mail.gmail.com>
Message-ID: <51B20B46.4030501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/07/2013 02:11 AM, Alexandre Courbot wrote:
> On Fri, Jun 7, 2013 at 1:44 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/06/2013 01:28 AM, Alexandre Courbot wrote:
>>> Boot loaders on some Tegra devices can be unlocked but do not let the
>>> system operate without SecureOS. SecureOS prevents access to some
>>> registers and requires the operating system to perform certain
>>> operations through Secure Monitor Calls instead of directly accessing
>>> the hardware.
>>>
>>> This patch introduces basic SecureOS support for Tegra. SecureOS support
>>> can be enabled by adding a "nvidia,secure-os" property to the "chosen"
>>> node of the device tree.
>>
>> I suspect "SecureOS" here is the name of a specific implementation of a
>> secure monitor, right? It's certainly a very unfortunate name, since it
>> sounds like a generic concept rather than a specific implementation:-(
> 
> Right. Using the actual name (Trusted Foundations) is probably better.
> I don't think the SecureOS denomination is used by anyone else but
> NVIDIA.
> 
>> There certainly could be (and I believe are in practice?) multiple
>> implementation of a secure monitor for Tegra. Presumably, each of those
>> implementations has (or could have) a different definition for what SVC
>> calls it supports, their parameters, etc.
>>
>> I think we need to separate the concept of support for *a* secure
>> monitor, from support for a *particular* secure monitor.
> 
> Agreed. In this case, can we assume that support for a specific secure
> monitor is not arch-specific, and that this patch should be moved
> outside of arch-tegra and down to arch/arm? In other words, the ABI of
> a particular secure monitor should be the same no matter the chip,
> shouldn't it?

I would like to believe that the Trusted Foundations monitor had the
same ABI irrespective of which Soc it was running on. However, I have
absolutely no idea at all if that's true. Even if there's some common
subset of the ABI that is identical across all SoCs, I wouldn't be too
surprised if there were custom extensions for each different SoC, or
just perhaps even each product.

Can you research this and find out the answer?

What we can always do is make a compatible property that lists
everything[1], and have the driver match on the most specific value for
now, but relax the driver's matching later if it turns out that the ABI
is indeed common.

[1] That'd need to be at least secure OS name, and secure OS version.
Perhaps the SoC and board data can be deduced from the DT's top-level
compatible properties; nvidia,tegra114-shield, nvidia,tegra114?
