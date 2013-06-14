From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 09:28:31 -0600
Subject: [PATCH v2 1/3] ARM: tegra: basic support for Trusted Foundations
In-Reply-To: <CAAVeFuLufKSfeQzP-tX1JpX9qtHa2EdFA9J8qpKE4Pyyrc8UQg@mail.gmail.com>
References: <1371114745-24710-1-git-send-email-acourbot@nvidia.com>
 <1371114745-24710-2-git-send-email-acourbot@nvidia.com>
 <20130613143536.GA18021@localhost.localdomain>
 <CAAVeFuLufKSfeQzP-tX1JpX9qtHa2EdFA9J8qpKE4Pyyrc8UQg@mail.gmail.com>
Message-ID: <51BB369F.8000209@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/14/2013 02:43 AM, Alexandre Courbot wrote:
> On Thu, Jun 13, 2013 at 11:35 PM, Dave Martin <Dave.Martin@arm.com> wrote:
...
>>> +             compatible = "tl,trusted-foundations";
>>> +     };
>>
>> For now, it might make more sense to make this binding tegra-specific,
>> and to interpret the node is only implying the presence of the low-
>> level SoC functions you are using on Tegra, not TF as a whole.
> 
> Do you mean the vendor should be changed from "tl" to "nvidia" here?
> 
>> Otherwise, it feels too generic.  There is no description of exactly
>> what functionality will be available if this node it present: if
>> this is going to be a generic binding for TF, then it needs to work
>> for all deployments of TF, not just your specific case.  For example,
>> how to you find out what functionality is present?  Will there be
>> a standard probing ABI for all versions and deployments of TF, or
>> would extra information need to be described in the DT?
>>
>> Partly, this depends on whether the TF_SET_CPU_BOOT_ADDR_SMC call will
>> be present, working, and with compatible ABI and semantics, on every SoC
>> where an implementation of TF is present.  Someone from Trusted Logic, or
>> someone with visibility of the relevant ABI/API specs would need to
>> judge on that -- do you have that info?
> 
> I'm currently looking into that. This patch makes the assumption that
> all TF implementations have the same features and the same interface -
> if this is the case, do you agree this binding is ok as it is?
> 
> If indeed TF's functionality and ABI is the same no matter whether we
> are on Tegra on not, then its support should even be moved outside of
> mach-tegra.

I expect we at least need a version number in the compatible value, even
if we don't need a representation of the SoC or vendor for which the ABI
was built.

>>> +     node = of_find_compatible_node(NULL, NULL, "tl,trusted-foundations");
>>> +     if (node && !IS_ENABLED(CONFIG_TEGRA_TRUSTED_FOUNDATIONS))
>>> +             pr_warn("Trusted Foundations detected but support missing!\n");
>>
>> Should this be more than just a warning?
>>
>> It looks to me like tegra_cpu_reset_handler_set() might either silently
>> fail or trigger an external abort in this situation, depending on the
>> hardware and on how TF sets things up.
> 
> What will happen (from 3.10) is that tegra_cpu_reset_handler_set()
> will output a "CPUX: failed to come online" for each secondary CPU and
> boot will continue (albeit on one CPU). The system's features are
> degraded, but it is not fatal, so I think it is reasonable to continue
> here.
> 
>> There seems to be no way to signal an error when attempting to set a
>> CPU's reset address.
> 
> Indeed. But even if that fails the system can still survive, at least on Tegra.

One more thought: Setting the CPU reset address isn't the only operation
that'll be performed via firmware_ops; we'd also need to e.g. disable
CPU power-gating and perhaps other things. Can that all be done at
run-time? I guess it shouldn't be hard to fix that if we can't yet.
