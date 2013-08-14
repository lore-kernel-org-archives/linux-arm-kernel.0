From: andre.przywara@calxeda.com (Andre Przywara)
Date: Thu, 15 Aug 2013 00:05:01 +0200
Subject: [PATCH] KVM: ARM: ignore guest L2 cache control SMCs on Highbank
 and OMAP
In-Reply-To: <20130814204302.GA8837@cbox>
References: <1376472125-23350-1-git-send-email-andre.przywara@calxeda.com>
 <CAL_Jsq+vGd7+pw6YX0YNHO5rVSoiHCHbtXXdZ-3grnEcAOc38Q@mail.gmail.com>
 <520BE673.9010801@calxeda.com> <20130814204302.GA8837@cbox>
Message-ID: <520BFF0D.9050303@calxeda.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/14/2013 10:43 PM, Christoffer Dall wrote:
> On Wed, Aug 14, 2013 at 10:20:03PM +0200, Andre Przywara wrote:
>> On 08/14/2013 08:54 PM, Rob Herring wrote:
>>> On Wed, Aug 14, 2013 at 4:22 AM, Andre Przywara
>>> <andre.przywara@calxeda.com> wrote:
>>>> Guest kernels with CONFIG_L2X0 set (for instance Highbank or OMAP4)
>>>> will trigger SMCs to handle the L2 cache controller (PL310).
>>>> This will currently inject #UNDEFs and eventually stop the guest.
>>>>
>>>> We don't need explicit L2 cache controller handling on A15s anymore,
>>>> so it is safe to simply ignore these calls and proceed with the next
>>>> instruction.
>>>>
>>>> Signed-off-by: Andre Przywara <andre.przywara@calxeda.com>
>>>> ---
>>>>   arch/arm/kvm/handle_exit.c | 20 ++++++++++++++++++++
>>>>   1 file changed, 20 insertions(+)
>>>
>>> At least for highbank, we can fix this in the kernel:
>>
>> Yes, and we should do. But that won't fix older guest kernels, say
>> Ubuntu 12.10 or the like. And I think this is a use case for
>> virtualization, so we need both, guest and host fix.
>>
> Agreed, but we need a more generic solution for the secure call
> handling.  I've created a backlog item in Linaro's JIRA (CARD-801) for
> this work, let's see how quickly we can get it approved and put on the
> roadmap.

So I did some research already, I am not sure we can wait until Jira is 
ready ;-)
I'd opt for something like this:
1. Allow userland to let the kernel ignore all smc's. That's low 
overhead, easy to implement and would cover Highbank and Broadcom, which 
do only L2 cache controller handling via smc.
2. Think about how to handle TI Keystone and Qualcomm MSM, which do 
secondary cores bringup via smc's. Do we need to support this or can we 
demand PSCI support? If I got this correctly, a PSCI node in the DTB 
overrides any platform smp_ops, so injecting PSCI should avoid those 
smc's on those two platforms.
3. Agree on whether we support PSCI via smc. I think we abandoned this 
with 24a7f67 (ARM: KVM: Don't handle PSCI calls via SMC), so do we 
really want to re-introduce it?
4. Dig through all this OMAP smc code to decide what we really want to 
emulate and whether we need to: Maybe we can safely ignore this since it 
is for OMAP4 with A9s or lower only.
If there is a need to emulate, fold this into one ioctl which also 
enables the ignore-all case.

I am not sure whether it is a wise decision to pull _all_ SMC handling 
unconditionally into userland, since that would separate the source of 
the SMCs (the kernel) and their emulation.

Regards,
Andre.
