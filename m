From: rusty@rustcorp.com.au (Rusty Russell)
Date: Tue, 04 Dec 2012 11:44:11 +1030
Subject: [RFC PATCH 1/1] KVM: ARM: add vgic state save and restore support
In-Reply-To: <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
References: <1354531019-9335-1-git-send-email-b29396@freescale.com>
 <CAFEAcA-wopCCZrX2-eak-YAVpR2ZorGAyBVpcHUxjbxewVCFeg@mail.gmail.com>
Message-ID: <87boeaipp8.fsf@rustcorp.com.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Peter Maydell <peter.maydell@linaro.org> writes:
> On 3 December 2012 10:36, Dong Aisheng <b29396@freescale.com> wrote:
>> and via current ONE_REG interface we do not know which CPU
>> is performing the register access, so the banked registers are not
>> suppported well,
>
> Actually you do, because it's a vcpu ioctl. That does raise a
> different question, though. ONE_REG is currently aimed as a vcpu
> ioctl for CPU state save/restore -- how does it need to change
> to handle device state save/restore where the device is not per-cpu?

Good question.  I'd prefer to stretch the existing interface, than
create an identical one for non-per-cpu resources, but I could be swayed
if there were many other cases.

The simplest method is to give it a new type and mirror the non-per-cpu
regs on all vcpus.  Then a completely naive implementation save/restore
will Just Work, with redundant data.  Or we could pick a CPU, but that
means your discovery logic becomes more complex unless you know which
CPU it is (lowest number?).

Cheers,
Rusty.
