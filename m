From: olof@lixom.net (Olof Johansson)
Date: Tue, 11 Mar 2014 12:58:45 -0700
Subject: [PATCH 1/4] ARM: dts: keystone: update for supporting K2L/K2E EVMs
In-Reply-To: <531CC888.1080100@ti.com>
References: <1393365035-20083-1-git-send-email-santosh.shilimkar@ti.com>
 <1393365035-20083-2-git-send-email-santosh.shilimkar@ti.com>
 <20140309053924.GD12854@quad.lixom.net> <531CC888.1080100@ti.com>
Message-ID: <CAOesGMjzPyVxX29nMrWKRh4rXeQPA1ofwVD5Sb9Vjda5c4o+Jw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Mar 9, 2014 at 1:01 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On Sunday 09 March 2014 01:39 PM, Olof Johansson wrote:
>> On Tue, Feb 25, 2014 at 04:50:32PM -0500, Santosh Shilimkar wrote:
>>> From: Murali Karicheri <m-karicheri2@ti.com>
>>>
>>> This patch add compatibility strings for k2hk, k2l and k2e EVMs
>>>
>>> Cc: Olof Johansson <olof@lixom.net>
>>> Cc: Arnd Bergmann <arnd@arndb.de>
>>> Cc: Rob Herring <robh+dt@kernel.org>
>>> Cc: Kumar Gala <galak@codeaurora.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>
>>> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>> ---
>>>  .../devicetree/bindings/arm/keystone/keystone.txt  |   10 ++++++++++
>>>  arch/arm/mach-keystone/keystone.c                  |    3 +++
>>>  2 files changed, 13 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/keystone/keystone.txt b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
>>> index 63c0e6a..ad16e7a 100644
>>> --- a/Documentation/devicetree/bindings/arm/keystone/keystone.txt
>>> +++ b/Documentation/devicetree/bindings/arm/keystone/keystone.txt
>>> @@ -8,3 +8,13 @@ Required properties:
>>>   - compatible: All TI specific devices present in Keystone SOC should be in
>>>     the form "ti,keystone-*". Generic devices like gic, arch_timers, ns16550
>>>     type UART should use the specified compatible for those devices.
>>> +
>>> +Boards:
>>> +-  Keystone 2 Hawking/Kepler EVM
>>> +   compatible = "ti,k2hk-evm"
>>> +
>>> +-  Keystone 2 Lamarr EVM
>>> +   compatible = "ti,k2l-evm"
>>
>> Your previous email said Lammar. One, or maybe both, are wrong, but which one?
>>
> My email had a typo then. The one here is right.
>
>>> +
>>> +-  Keystone 2 Edison EVM
>>> +   compatible = "ti,k2e-evm"
>>> diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
>>> index 6e6bb7d..aa0d212 100644
>>> --- a/arch/arm/mach-keystone/keystone.c
>>> +++ b/arch/arm/mach-keystone/keystone.c
>>> @@ -47,6 +47,9 @@ static void __init keystone_init(void)
>>>
>>>  static const char *keystone_match[] __initconst = {
>>>      "ti,keystone-evm",
>>> +    "ti,k2hk-evm",
>>> +    "ti,k2l-evm",
>>> +    "ti,k2e-evm",
>>
>> -evm indicate board-level compat fields. We'd be better off just keeping a
>> "ti,keystone" top-level compatible here and just using that to probe. That
>> way you don't have to touch the file for new boards in the future.
>>
> So far keystone-evm was k2hk(Keystone2 Hawking EVM) but with additional two
> SOC's and board's, separate compatible was needed to differentiate. These
> boards do have significant differences though current mainline code.
> This mainly because the boards are build for those specific SOC families.
>
> I would like to keep the organisation that way so that we cab support any
> future boards like below.
> "ti,k2hk-evm" --> All the Keystone2 Hawking/Kepler boards
> "ti,k2l-evm" --> All the Keystone2 Lamarr boards
> "ti,k2e-evm" --> All the Keystone2 Edision boards
>
> I don't expect to touch this file till new SOC gets added with its
> EVM.

Right, but today they all need to be enumerated in your C file -- if
you do a "ti,keystone" compatible field that you use on all of them
then there will be no need for any code changes for these different
boards, which is the whole point behind device-tree...


-Olof
