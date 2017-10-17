From: liuwenliang@huawei.com (Liuwenliang (Lamb))
Date: Tue, 17 Oct 2017 13:28:25 +0000
Subject: [PATCH 01/11] Initialize the mapping of KASan shadow memory
In-Reply-To: <20171011214131.GV20805@n2100.armlinux.org.uk>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
 <20171011082227.20546-2-liuwenliang@huawei.com>
 <b53b3281-5eef-7cbd-c7d3-5417d764667b@gmail.com>
 <20171011214131.GV20805@n2100.armlinux.org.uk>
Message-ID: <B8AC3E80E903784988AB3003E3E97330C005CB25@dggemm510-mbx.china.huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2017.10.12  05:42 AM  Russell King - ARM Linux [mailto:linux at armlinux.org.uk] wrote:

>> Please don't make this "exclusive" just conditionally call 
>> kasan_early_init(), remove the call to start_kernel from 
>> kasan_early_init and keep the call to start_kernel here.
>iow:
>
>#ifdef CONFIG_KASAN
>	bl	kasan_early_init
>#endif
>	b	start_kernel
>
>This has the advantage that we don't leave any stack frame from
>kasan_early_init() on the init task stack.

Thanks for your review.  I tested your opinion and it work well.
I agree with you that it is better to use follow code
#ifdef CONFIG_KASAN
	bl	kasan_early_init
#endif
	b	start_kernel

than :
#ifdef CONFIG_KASAN
	bl	kasan_early_init
#else
	b	start_kernel
#endif
