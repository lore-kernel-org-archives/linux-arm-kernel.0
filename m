From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 22 Jan 2014 16:11:53 +0000
Subject: [PATCH v7 5/6] misc: debug: remove compilation warnings
In-Reply-To: <1390401773-12100-6-git-send-email-vijay.kilari@gmail.com>
References: <1390401773-12100-1-git-send-email-vijay.kilari@gmail.com>
 <1390401773-12100-6-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20140122161152.GD8065@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 22, 2014 at 02:42:52PM +0000, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Resolve following compiler warnings
> warning: format '%lx' expects argument of type 'long unsigned int',
> but argument 2 has type 'u64' [-Wformat]
> 
> tested for warnings on arm32 & arm64
> 
> Signed-off-by: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> ---
>  drivers/misc/kgdbts.c |   12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/misc/kgdbts.c b/drivers/misc/kgdbts.c
> index 36f5d52..78e10b2 100644
> --- a/drivers/misc/kgdbts.c
> +++ b/drivers/misc/kgdbts.c
> @@ -350,8 +350,8 @@ static int check_single_step(char *put_str, char *arg)
>  	kgdb_hex2mem(&put_str[1], (char *)kgdbts_gdb_regs,
>  		 NUMREGBYTES);
>  	gdb_regs_to_pt_regs(kgdbts_gdb_regs, &kgdbts_regs);
> -	v2printk("Singlestep stopped at IP: %lx\n",
> -		   instruction_pointer(&kgdbts_regs));
> +	v2printk("Singlestep stopped at IP: %llx\n",
> +		   (unsigned long long)instruction_pointer(&kgdbts_regs));
>  
>  	if (sstep_thread_id != cont_thread_id) {
>  		/*
> @@ -376,8 +376,8 @@ static int check_single_step(char *put_str, char *arg)
>  continue_test:
>  	matched_id = 0;
>  	if (instruction_pointer(&kgdbts_regs) == addr) {
> -		eprintk("kgdbts: SingleStep failed at %lx\n",
> -			   instruction_pointer(&kgdbts_regs));
> +		eprintk("kgdbts: SingleStep failed at %llx\n",
> +			(unsigned long long)instruction_pointer(&kgdbts_regs));

I think we could simply add the cast to the definition of
instruction_pointer() on arm64. Even the generic instruction_pointer()
definition returns unsigned long.

-- 
Catalin
