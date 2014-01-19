From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 19 Jan 2014 19:47:06 +0100
Subject: [RFC v3 03/13] ahci-platform: Fix clk enable/disable unbalance
 on suspend/resume
In-Reply-To: <20140119111412.GA11123@htj.dyndns.org>
References: <1390088935-7193-1-git-send-email-hdegoede@redhat.com>
 <1390088935-7193-4-git-send-email-hdegoede@redhat.com>
 <20140119111412.GA11123@htj.dyndns.org>
Message-ID: <52DC1DAA.3010403@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/19/2014 12:14 PM, Tejun Heo wrote:
> On Sun, Jan 19, 2014 at 12:48:45AM +0100, Hans de Goede wrote:
>> For devices where ahci_platform_data provides suspend() there is an unbalance
>> in clk enable/disable calls. The suspend path does not disable the clk, but
>> the resume path enables it. This commit fixes it by always disabling the clk
>> in the suspend path independent of there being an ahci_platform_data suspend
>> method.
>>
>> On all drivers currently using a suspend method, the suspend method always
>> succeeds, so change its return type to void, to avoid having the introduce
>> somewhat complex error handling paths.
>>
>> The disabling of the clock on suspend is a functional change, to ensure this
>> is ok I've audited all drivers using ahci_platform_data:
>>
>> arch/arm/mach-davinci/devices-da8xx.c: Does not use a suspend method
>> arch/arm/mach-spear/spear1340.c: Does not use the clock framework
>> drivers/ata/ahci_imx.c: Does have suspend and resume pdata methods, these
>> disable / enable another clock, so likely it is ok to disable / enable the
>> clock at of-node index 0 as well, I've ordered a wandboard to be able to
>> test these changes.
>
> This isn't your fault but similarly to the previous patch, I'd much
> prefer if drivers which need custom ops just override the whole
> operation and are allowed to use the default platform from their
> custom implementations as they see fit.  Allowing partial overrides
> seems like an efficient thing to do at the beginning but if you
> continue to stack them, you eventually end up with giant pile of
> methods where figuring out which code paths are actually executed
> takes quite a bit of effort.  I'd really like to avoid that.

I disagree, if we were to follow this reasoning then the init and exit
overrides would have to logically also be all or nothing propositions,
currently ahci_probe and ahci_stop do all the clks, regulator and sata-core
setup / teardown needed with the init / exit pdata callbacks doing any
implementation specific register frobbing needed.

As I see it either doing clks, regulator and sata-core things in a common
place makes sense, and then it goes for suspend and resume too, or we
opt for always following the complete override model, and which point
it becomes more sensible to just do a separate platform driver per
ahci implementation.

After this patch, suspend / resume exactly follow init / stop in that
the ahci_platform.c bits take care of the common stuff, while calling
into a platform_data callback for implementation specific setup.

Also if you look at both the imx and sunxi implementations doing things
this way works well in practice.

Regards,

Hans
