From: victor.kamensky@linaro.org (Victor Kamensky)
Date: Wed, 15 Oct 2014 16:54:43 -0700
Subject: [RFC PATCH] arm/arm64: KVM: Fix BE accesses to GICv2 EISR and
 ELRSR regs
In-Reply-To: <CAA3XUr3Xv7nKnc-aBmwC+GKwcJA4FFUdcF=vpYJmWVzZqp+8Yw@mail.gmail.com>
References: <1411913066-3787-1-git-send-email-christoffer.dall@linaro.org>
 <86k343geyx.fsf@arm.com>
 <CAA3XUr3Xv7nKnc-aBmwC+GKwcJA4FFUdcF=vpYJmWVzZqp+8Yw@mail.gmail.com>
Message-ID: <CAA3XUr2-SUHX0Q2cSw0gnRA_jX3QbrhuTmsW0vuu1Lt+-VMsFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2014 08:21, Victor Kamensky <victor.kamensky@linaro.org> wrote:
> On 14 October 2014 02:47, Marc Zyngier <marc.zyngier@arm.com> wrote:
>> On Sun, Sep 28 2014 at 03:04:26 PM, Christoffer Dall <christoffer.dall@linaro.org> wrote:
>>> The EIRSR and ELRSR registers are 32-bit registers on GICv2, and we
>>> store these as an array of two such registers on the vgic vcpu struct.
>>> However, we access them as a single 64-bit value or as a bitmap pointer
>>> in the generic vgic code, which breaks BE support.
>>>
>>> Instead, store them as u64 values on the vgic structure and do the
>>> word-swapping in the assembly code, which already handles the byte order
>>> for BE systems.
>>>
>>> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
>>
>> (still going through my email backlog, hence the delay).
>>
>> This looks like a valuable fix. Haven't had a chance to try it (no BE
>> setup at hand) but maybe Victor can help reproducing this?.
>
> I'll give it a spin.

Tested-by: Victor Kamensky <victor.kamensky@linaro.org>

Tested on v3.17 + this fix on TC2 (V7) and Mustang (V8) with BE
kvm host, tried different combination of guests BE/LE V7/V8. All looks
good.

Only with latest qemu in BE V8 mode in v3.17 without this
fix I was able to reproduce the issue that Will spotted. With kvmtool,
and older qemu V8 BE code never hit vgic_v2_set_lr function so
that is why we did not run into it before. I guess fix in qemu in
pl011 mentioned by 1f2bb4acc125, uncovered vgic_v2_set_lr
code path and this BE issue. With this patch it works fine now.

Thanks,
Victor

> Thanks,
> Victor
>
>> Acked-by: Marc Zyngier <marc.zyngier@arm.com>
>>
>>         M.
>> --
>> Jazz is not dead. It just smells funny.
>> _______________________________________________
>> kvmarm mailing list
>> kvmarm at lists.cs.columbia.edu
>> https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
