From: peter.maydell@linaro.org (Peter Maydell)
Date: Fri, 24 Nov 2017 15:03:17 +0000
Subject: [RFC] KVM API extensions for SVE
In-Reply-To: <20171124144538.GG28855@cbox>
References: <20171121134913.GI22781@e103592.cambridge.arm.com>
 <20171122195230.GT28855@cbox>
 <20171123184050.GM22781@e103592.cambridge.arm.com>
 <20171124144538.GG28855@cbox>
Message-ID: <CAFEAcA_czAp1=n+BENZNiyn7k6bjRXOk3dYBQHgddDZXUP2osg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24 November 2017 at 14:45, Christoffer Dall <cdall@linaro.org> wrote:
> On Thu, Nov 23, 2017 at 06:40:50PM +0000, Dave Martin wrote:
>> This creates another issue: if SVE is supported by the host kernel
>> but not enabled for the guest, do I need to hist the SVE regs from
>> KVM_GET_REG_LIST?
>
> I don't think so.  We should check with QEMU and kvmtool, but I think
> the way it works is that userspace matches the KVM list with its own
> internal list, and matches up anything it knows about, and discards the
> rest.  Certainly in the past we haven't been afraid of adding registers
> to KVM_GET_REG_LIST.

QEMU userspace doesn't discard things it doesn't knows about, it
just blindly passes them along in the migration stream to the
destination.

The awkward bit for SVE is that its registers for KVM_GET_REG_LIST
will be bigger than 64 bits. If you do that for existing QEMU
binaries they'll assert because of the check in kvm_arm_init_cpreg_list()
that the register size is something it can handle. So we mustn't
list the SVE regs in GET_REG_LIST unless userspace has told us it
can handle them (by setting a feature bit in the arguments to
KVM_ARM_VCPU_INIT, presumably).

thanks
-- PMM
