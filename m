From: carlv@codeaurora.org (Carl Vanderlip)
Date: Tue, 25 Jan 2011 10:12:16 -0800
Subject: [PATCH v2 02/11] msm: Generalize timer register mappings
In-Reply-To: <1295468747-22796-3-git-send-email-davidb@codeaurora.org>
References: <1292384961-8851-1-git-send-email-stepanm@codeaurora.org>
	<1295468747-22796-1-git-send-email-davidb@codeaurora.org>
	<1295468747-22796-3-git-send-email-davidb@codeaurora.org>
Message-ID: <1295979136.16668.4.camel@carlv-linux.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2011-01-19 at 12:25 -0800, David Brown wrote:
> -#define MSM_GPT_PHYS          MSM_CSR_PHYS
> -#define MSM_GPT_BASE          MSM_CSR_BASE
> -#define MSM_GPT_SIZE          SZ_4K
...
> +#define MSM_CHIP_DEVICE(name, chip) {			      \
>  		.virtual = (unsigned long) MSM_##name##_BASE, \
> -		.pfn = __phys_to_pfn(MSM_##name##_PHYS), \
> -		.length = MSM_##name##_SIZE, \
> +		.pfn = __phys_to_pfn(chip##_##name##_PHYS), \
> +		.length = chip##_##name##_SIZE, \
>  		.type = MT_DEVICE_NONSHARED, \
>  	 }
>  
> +#define MSM_DEVICE(name) MSM_CHIP_DEVICE(name, MSM)
> +
>  #if defined(CONFIG_ARCH_MSM7X00A) || defined(CONFIG_ARCH_MSM7X27) \
>  	|| defined(CONFIG_ARCH_MSM7X25)
>  static struct map_desc msm_io_desc[] __initdata = {
>  	MSM_DEVICE(VIC),
> -	MSM_DEVICE(CSR),
> +	MSM_CHIP_DEVICE(CSR, MSM7X00),
>  	MSM_DEVICE(GPT),
>  	MSM_DEVICE(DMOV),
>  	MSM_DEVICE(GPIO1),

MSM_DEVICE(GPT) still references MSM_GPT_PHYS, MSM_GPT_SIZE and
MSM_GPT_BASE on the 7x00a though they are being removed.

---
Sent by an consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora
Forum.
