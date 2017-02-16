From: eric.auger@redhat.com (Auger Eric)
Date: Thu, 16 Feb 2017 14:19:08 +0100
Subject: [RFC PATCH 03/33] irqchip/gic-v3-its: Refactor command encoding
In-Reply-To: <1484648454-21216-4-git-send-email-marc.zyngier@arm.com>
References: <1484648454-21216-1-git-send-email-marc.zyngier@arm.com>
 <1484648454-21216-4-git-send-email-marc.zyngier@arm.com>
Message-ID: <abcff5be-28fe-6bf5-76c1-2a65f86d05ee@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 17/01/2017 11:20, Marc Zyngier wrote:
> The way we encode the various ITS command fields is both tedious
> and error prone. Let's introduce a helper function that performs
> the encoding, and convert the existing encoders to use that
> helper.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
>  drivers/irqchip/irq-gic-v3-its.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 69b040f..49b681e 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -193,58 +193,56 @@ struct its_cmd_block {
>  typedef struct its_collection *(*its_cmd_builder_t)(struct its_cmd_block *,
>  						    struct its_cmd_desc *);
>  
> +static void its_mask_encode(u64 *raw_cmd, u64 val, int h, int l)
> +{
> +	u64 mask = GENMASK_ULL(h, l);
> +	*raw_cmd &= ~mask;
> +	*raw_cmd |= (val << l) & mask;
> +}
> +
>  static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
>  {
> -	cmd->raw_cmd[0] &= ~0xffULL;
> -	cmd->raw_cmd[0] |= cmd_nr;
> +	its_mask_encode(&cmd->raw_cmd[0], cmd_nr, 7, 0);
>  }
>  
>  static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
>  {
> -	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
> -	cmd->raw_cmd[0] |= ((u64)devid) << 32;
> +	its_mask_encode(&cmd->raw_cmd[0], devid, 63, 32);
>  }
>  
>  static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
>  {
> -	cmd->raw_cmd[1] &= ~0xffffffffULL;
> -	cmd->raw_cmd[1] |= id;
> +	its_mask_encode(&cmd->raw_cmd[1], id, 31, 0);
>  }
>  
>  static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id)
>  {
> -	cmd->raw_cmd[1] &= 0xffffffffULL;
> -	cmd->raw_cmd[1] |= ((u64)phys_id) << 32;
> +	its_mask_encode(&cmd->raw_cmd[1], phys_id, 63, 32);
>  }
>  
>  static void its_encode_size(struct its_cmd_block *cmd, u8 size)
>  {
> -	cmd->raw_cmd[1] &= ~0x1fULL;
> -	cmd->raw_cmd[1] |= size & 0x1f;
> +	its_mask_encode(&cmd->raw_cmd[1], size, 4, 0);
>  }
>  
>  static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
>  {
> -	cmd->raw_cmd[2] &= ~0xffffffffffffULL;
> -	cmd->raw_cmd[2] |= itt_addr & 0xffffffffff00ULL;
> +	its_mask_encode(&cmd->raw_cmd[2], itt_addr >> 8, 50, 8);
>  }
>  
>  static void its_encode_valid(struct its_cmd_block *cmd, int valid)
>  {
> -	cmd->raw_cmd[2] &= ~(1ULL << 63);
> -	cmd->raw_cmd[2] |= ((u64)!!valid) << 63;
> +	its_mask_encode(&cmd->raw_cmd[2], !!valid, 63, 63);
>  }
>  
>  static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
>  {
> -	cmd->raw_cmd[2] &= ~(0xffffffffULL << 16);
> -	cmd->raw_cmd[2] |= (target_addr & (0xffffffffULL << 16));
> +	its_mask_encode(&cmd->raw_cmd[2], target_addr >> 16, 50, 16);
Theoretically isn't it 16:51? In the previous code this was encoded as
16-47 I think.

Besides
Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric
>  }
>  
>  static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
>  {
> -	cmd->raw_cmd[2] &= ~0xffffULL;
> -	cmd->raw_cmd[2] |= col;
> +	its_mask_encode(&cmd->raw_cmd[2], col, 15, 0);
>  }
>  
>  static inline void its_fixup_cmd(struct its_cmd_block *cmd)
> 
