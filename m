From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Mon, 14 Jan 2013 12:33:05 -0500
Subject: [PATCH v5 03/14] KVM: ARM: Initial skeleton to compile KVM support
In-Reply-To: <20130114162415.GF23505@n2100.arm.linux.org.uk>
References: <20130108183811.46302.58543.stgit@ubuntu>
 <20130108183855.46302.40539.stgit@ubuntu>
 <20130114162415.GF23505@n2100.arm.linux.org.uk>
Message-ID: <CANM98qLHao0dJU57MbAtopVpTJDOVdqNtw5JT-DXyQNa7iD_qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 14, 2013 at 11:24 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Jan 08, 2013 at 01:38:55PM -0500, Christoffer Dall wrote:
>> +     /* -ENOENT for unknown features, -EINVAL for invalid combinations. */
>> +     for (i = 0; i < sizeof(init->features)*8; i++) {
>> +             if (init->features[i / 32] & (1 << (i % 32))) {
>
> Isn't this an open-coded version of test_bit() ?

indeed, nicely spotted:

commit 608588674144e403ad0ea3c93066f3175bd5cf88
Author: Christoffer Dall <c.dall@virtualopensystems.com>
Date:   Mon Jan 14 12:30:07 2013 -0500

    KVM: ARM: Use test-bit instead of open-coded version

    Makes the code more readable, also adds spaces around the asterisk.

    Cc: Russell King <linux@arm.linux.org.uk>
    Signed-off-by: Christoffer Dall <c.dall@virtualopensystems.com>

diff --git a/arch/arm/kvm/guest.c b/arch/arm/kvm/guest.c
index 65ae563..2339d96 100644
--- a/arch/arm/kvm/guest.c
+++ b/arch/arm/kvm/guest.c
@@ -193,8 +193,8 @@ int kvm_vcpu_set_target(struct kvm_vcpu *vcpu,
 	bitmap_zero(vcpu->arch.features, KVM_VCPU_MAX_FEATURES);

 	/* -ENOENT for unknown features, -EINVAL for invalid combinations. */
-	for (i = 0; i < sizeof(init->features)*8; i++) {
-		if (init->features[i / 32] & (1 << (i % 32))) {
+	for (i = 0; i < sizeof(init->features) * 8; i++) {
+		if (test_bit(i, (void *)init->features)) {
 			if (i >= KVM_VCPU_MAX_FEATURES)
 				return -ENOENT;
 			set_bit(i, vcpu->arch.features);
--

Thanks,
-Christoffer
