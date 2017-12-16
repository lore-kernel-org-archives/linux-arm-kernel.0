From: gengdongjiu@huawei.com (gengdongjiu)
Date: Sat, 16 Dec 2017 10:53:51 +0800
Subject: [PATCH v5 04/13] arm64: kernel: Survive corrected RAS errors
 notified by SError
In-Reply-To: <20171215155101.23505-5-james.morse@arm.com>
References: <20171215155101.23505-1-james.morse@arm.com>
 <20171215155101.23505-5-james.morse@arm.com>
Message-ID: <43942acd-f6ff-ec58-aafb-a6f3ba40fab9@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 2017/12/15 23:50, James Morse wrote:
> +asmlinkage void do_serror(struct pt_regs *regs, unsigned int esr)
> +{
> +	nmi_enter();

        How about firstly let APEI kernel driver to handle it by adding patch[1]? if the handling is successful, do_serror() direct return;
        Otherwise continue check the ESR value, for example:
	if (!ghes_notify_sei())
		return;

	[1] https://patchwork.kernel.org/patch/10053027/
> +
> +	/* non-RAS errors are not containable */
> +	if (!arm64_is_ras_serror(esr) || arm64_is_fatal_ras_serror(regs, esr))
> +		arm64_serror_panic(regs, esr);
>  
> -	panic("Asynchronous SError Interrupt");
> +	nmi_exit();
>  }
>  
