From: agraf@suse.de (Alexander Graf)
Date: Wed, 12 Feb 2014 08:07:20 +0100
Subject: [PATCH v2 5/7] ARM: KVM: one_reg coproc set and get BE fixes
In-Reply-To: <1392183693-21238-6-git-send-email-victor.kamensky@linaro.org>
References: <1392183693-21238-1-git-send-email-victor.kamensky@linaro.org>
 <1392183693-21238-6-git-send-email-victor.kamensky@linaro.org>
Message-ID: <0F0D0769-415E-4946-9C8C-82534A927310@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 12.02.2014, at 06:41, Victor Kamensky <victor.kamensky@linaro.org> wrote:

> Fix code that handles KVM_SET_ONE_REG, KVM_GET_ONE_REG ioctls to work in BE
> image. Before this fix get/set_one_reg functions worked correctly only in
> LE case - reg_from_user was taking 'void *' kernel address that actually could
> be target/source memory of either 4 bytes size or 8 bytes size, and code copied
> from/to user memory that could hold either 4 bytes register, 8 byte register
> or pair of 4 bytes registers.
> 
> For example note that there was a case when 4 bytes register was read from
> user-land to kernel target address of 8 bytes value. Because it was working
> in LE, least significant word was memcpy(ied) and it just worked. In BE code
> with 'void *' as target/source 'val' type it is impossible to tell whether
> 4 bytes register from user-land should be copied to 'val' address itself
> (4 bytes target) or it should be copied to 'val' + 4 (least significant word
> of 8 bytes value). So first change was to introduce strongly typed
> functions, where type of target/source 'val' is strongly defined:
> 
> reg_from_user64 - reads register from user-land to kernel 'u64 *val'
>                  address; register size could be 4 or 8 bytes
> reg_from_user32 - reads register(s) from user-land to kernel 'u32 *val'
>                  address; note it could be one or two 4 bytes registers
> reg_to_user64 -   writes reigster from kernel 'u64 *val' address to
>                  user-land register memory; register size could be
>                  4 or 8 bytes
> ret_to_user32 -   writes register(s) from kernel 'u32 *val' address to
>                  user-land register(s) memory; note it could be
>                  one or two 4 bytes registers
> 
> All places where reg_from_user, reg_to_user functions were used, were changed
> to use either corresponding 64 or 32 bit variant of functions depending on
> type of source/target kernel memory variable.
> 
> In case of 'u64 *val' and register size equals 4 bytes, reg_from_user64
> and reg_to_user64 work only with least siginificant word of target/source
> kernel value.
> 
> Signed-off-by: Victor Kamensky <victor.kamensky@linaro.org>

Do you think it'd be possible to converge to a single solution across PPC and ARM? On PPC we currently have "get_reg_val" and "set_reg_val" helpers that encode/decode reg structs for us. The actual copy_from_user and copy_to_user can be generic because we know the size of the access from the ONE_REG constant.


Alex
