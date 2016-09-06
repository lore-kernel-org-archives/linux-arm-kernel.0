From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 6 Sep 2016 14:08:10 +0100
Subject: [PATCH v2 7/7] ARM: KVM: Unlock vgic-v3 support
In-Reply-To: <20160905112927.GL26366@cbox>
References: <1471344418-19568-1-git-send-email-vladimir.murzin@arm.com>
 <1471344418-19568-8-git-send-email-vladimir.murzin@arm.com>
 <20160905112927.GL26366@cbox>
Message-ID: <57CEBFBA.6060109@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/16 12:29, Christoffer Dall wrote:
> On Tue, Aug 16, 2016 at 11:46:58AM +0100, Vladimir Murzin wrote:
>> It is time to get access to common version of vgic-v3.
> 
> common version?
> 
>>
>> We basically would need to tell build system how to pick it up and
>> undo KVM_ARM_VGIC_V3 guarding introduced in 4f64cb6 ("arm/arm64: KVM:
>> Only allow 64bit hosts to build VGICv3") and remove stubs. However,
>> since vgic got ITS support KVM_ARM_VGIC_V3 tend to protect a little
>> bit more than just plain vgic-v3 - this guard is used for ITS too
>> which is not supported in 32-bit world yet.  So, along with removal of
>> KVM_ARM_VGIC_V3 guard introduce the new one - KVM_ARM_VGIC_V3_ITS to
>> protect ITS related code.
> 
> I don't find this paragraph particularly helpful, I'm afraid.
> 
>>
>> The only unpleasant part is how we decide which save/restore sequence to
>> use under __vgic_save_state() - we don't have patching framework in hand
>> like arm64, so have to check runtime on every invocation.
> 
> Do static keys work on 32-bit arm?

They do. It'd be interesting to see if we could move both architectures
to use static keys for selecting the GIC backend.

	M.
-- 
Jazz is not dead. It just smells funny...
