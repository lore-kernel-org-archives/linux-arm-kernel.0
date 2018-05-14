From: agraf@suse.de (Alexander Graf)
Date: Mon, 14 May 2018 09:37:15 +0200
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
 <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
Message-ID: <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/14/2018 12:01 AM, Linus Walleij wrote:
> On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
>> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
>>> Can you please name platform that has enough support for Alexander to
>>> care about backwards and forwards compatibility but lacks a pinctrl
>>> driver.
>> ZynqMP is one example that immediately comes to my mind. I'm sure there are
>> others too.
> Why isn't that using drivers/pinctrl/pinctrl-zynq.c?
>
> How is it so very different from (old) Zynq as it is already using
> the same GPIO driver?

That one is very simple: ZynqMP is usually an AMP system where Linux 
doesn't have full knowledge of the overall system. IIUC they have a tiny 
microblaze (PMU) that does the actual full system configuration for 
peripherals that may interfere with each other. This architecture also 
allows for safety critical code to run alongside a (less safe) Linux system.

I think we'll see architectures like this pop up more over time. TI 
Sitara has similar issues. I know that Jailhouse ran into exactly that 
problem before. I also know that during Linaro Connect Budapest even the 
OP-TEE people realized the current model is bad, because Linux may 
control pins/clocks/etc of devices that the secure world wants to use.

So I actually believe we will see more SoCs in the future that may even 
start with Linux controllable pinctrl or no pinctrl driver but then will 
move to firmware controlled drivers once it starts being necessary.


Alex
