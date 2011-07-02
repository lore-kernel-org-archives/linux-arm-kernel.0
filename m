From: simon@sequanux.org (Simon Guinot)
Date: Sat, 2 Jul 2011 12:23:44 +0000
Subject: plat-orion multi purpose pins problem for mv78200
In-Reply-To: <4E0E1CA8.7090200@drewtech.com>
References: <4E0E1CA8.7090200@drewtech.com>
Message-ID: <20110702122344.GJ31228@kw.sim.vm.gnt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joey,

On Fri, Jul 01, 2011 at 03:14:48PM -0400, Joey Oravec wrote:
> Nicola, Lennert -
> 
> There's a problem in 3.0-rc5 when calling mv78xx0_mpp_conf() on the
> MV78200 processor. This processor has 49 multi purpose pins but only
> 31 GPIOs. MPP[31:0] map directly to GPIO[31:0] but the next 17 are a
> little more complex:
> 
> MPP[39:32] = GPIO[7:0]
> MPP[46:40] = GPIO[23:17]
> MPP[47] = GPIO[16]
> MPP[48] = GPIO[8]
> MPP[49] = GPIO[9]

It doesn't seems the code was behaving differently before 3.0-rc. I mean
before the MPP and GPIO consolidation work. It was ?

> 
> See arch/arm/plat-orion/mpp.c. Inside orion_mpp_conf() the array
> gets processed by calling MPP_NUM() then calling
> orion_gpio_set_valid(). As demonstrated above, the MPP number and
> GPIO number are not interchangeable and on the MV78200 that's a
> problem when trying to setup any MPP > 31.
> 
> So we need to map each MPP to a given GPIO -- I don't know how the
> mapping will differ across processors. We also need to keep-clear
> which functions are called with an MPP number and which functions
> are called with a GPIO number.

As I don't have access to either a MV78200 device or his specification
document, let me ask you a few questions.

Does hardware allows a configuration like MPP0_GE0_COL and MPP32_GPIO
simultaneously ?

If not (and only if not), the problem is simply mapping a MPP number on
the correct GPIO number. Isn't it ?

In that case, what about using the MPPxx_GPIO definitions (found in
mach-mv78xx0/mpp.h) to map the right GPIO number ?

For example:

#define MPP32_GPIO        MPP(32, 0x1, 1, 1, 1)

could be replaced by:

#define MPP32_GPIO        MPP(0, 0x1, 1, 1, 1)

> 
> Followup question -- Marvell has several SoC families, but Linux
> uess plat-orion for everything. For example MV78200 isn't an Orion
> it's a Discovery Innovation series. Would it make more sense to have
> separate plat-* code for the separate families?

As far as possible, we have to share code between the SoCs families.

Regards,

Simon
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110702/c00680b4/attachment.sig>
