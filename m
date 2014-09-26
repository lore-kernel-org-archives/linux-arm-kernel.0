From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 26 Sep 2014 10:44:45 +0200
Subject: [PATCH] arm/arm64: KVM: Fix set_clear_sgi_pend_reg offset
In-Reply-To: <5425005A.6070709@huawei.com>
References: <1411667347-2989-1-git-send-email-christoffer.dall@linaro.org>
 <5425005A.6070709@huawei.com>
Message-ID: <20140926084445.GC15736@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shannon,

On Fri, Sep 26, 2014 at 01:57:46PM +0800, Shannon Zhao wrote:
> 
> On 2014/9/26 1:49, Christoffer Dall wrote:
> > The sgi values calculated in read_set_clear_sgi_pend_reg() and
> > write_set_clear_sgi_pend_reg() were horribly incorrectly multiplied by 4
> > with catastrophic results in that subfunctions ended up overwriting
> > memory not allocated for the expected purpose.
> > 
> > This showed up as bugs in kfree() and the kernel complaining a lot of
> > you turn on memory debugging.
> > 
> > This addresses: http://marc.info/?l=kvm&m=141164910007868&w=2
> > 
> > Reported-by: Shannon Zhao <zhaoshenglong@huawei.com>
> > Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
> > ---
> >  virt/kvm/arm/vgic.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/virt/kvm/arm/vgic.c b/virt/kvm/arm/vgic.c
> > index b6fab0f..8629678 100644
> > --- a/virt/kvm/arm/vgic.c
> > +++ b/virt/kvm/arm/vgic.c
> > @@ -816,7 +816,7 @@ static bool read_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
> >  {
> >  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >  	int sgi;
> > -	int min_sgi = (offset & ~0x3) * 4;
> > +	int min_sgi = (offset & ~0x3);
> >  	int max_sgi = min_sgi + 3;
> >  	int vcpu_id = vcpu->vcpu_id;
> >  	u32 reg = 0;
> > @@ -837,7 +837,7 @@ static bool write_set_clear_sgi_pend_reg(struct kvm_vcpu *vcpu,
> >  {
> >  	struct vgic_dist *dist = &vcpu->kvm->arch.vgic;
> >  	int sgi;
> > -	int min_sgi = (offset & ~0x3) * 4;
> > +	int min_sgi = (offset & ~0x3);
> >  	int max_sgi = min_sgi + 3;
> >  	int vcpu_id = vcpu->vcpu_id;
> >  	u32 reg;
> > 
> Hi Christoffer,
> 
> I have test this patch for a few hours. The kfree() bug doesn't appear again.
> But I come to another problem as followed.
> The test is that start 2 VMs, sleep 10 and do pkill qemu.
> 
> qemu-system-aar[1207]: unhandled level 1 permission fault (11) at 0xffffc01ed6c200, esr 0x9200000d
> pgd = ffffffc012986000
> [ffffc01ed6c200] *pgd=0000000000000000, *pud=0000000000000000
> 
> CPU: 1 PID: 1207 Comm: qemu-system-aar Not tainted 3.17.0-rc4+ #1
> task: ffffffc87b072900 ti: ffffffc0129e0000 task.ti: ffffffc0129e0000
> PC is at 0x4181a0
> LR is at 0x41826c
> pc : [<00000000004181a0>] lr : [<000000000041826c>] pstate: 80000000
> sp : 0000007fcd38ace0
> x29: 0000007fcd38ace0 x28: 0000000000000000
> x27: 0000000000000000 x26: 0000000000000000
> x25: 0000000000000000 x24: 0000000000000000
> x23: 0000000000000000 x22: 0000000000000000
> x21: 0000000000000000 x20: 0000000000000000
> x19: 0000007fcd38b070 x18: 0000007fcd38ab10
> x17: 0000007f9bb14480 x16: 00000000009f2370
> x15: ffffffffffffffff x14: 0000000000000000
> x13: 0000000000000000 x12: 0000000000000268
> x11: 00000000115e5520 x10: 0101010101010101
> x9 : 0000000000000004 x8 : 0000000000ac7a78
> x7 : 0000000000000000 x6 : 000000000000003f
> x5 : 0000000000000040 x4 : 0000000000000000
> x3 : 0000000000000030 x2 : 0000000000000001
> x1 : ffffffc01ed6c200 x0 : ffffffc01ed6c200
> 
Hmmm, I just ran a similar loop with a number of tests in the VM for a
few hours and I didn't see this error.

In any case, this patch should still be merged, but we should try to
reproduce your setup.

What is your command line, exact QEMU version, the file system you use,
and the guest kernel you are running?

Thanks,
-Christoffer
