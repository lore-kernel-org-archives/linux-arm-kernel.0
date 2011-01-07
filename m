From: stanley.miao@windriver.com (stanley.miao)
Date: Fri, 7 Jan 2011 17:38:11 +0800
Subject: [PATCH V3 42/63] ST SPEAr: replace readl, writel with	__raw_readl,
	__raw_writel in uncompress.h
In-Reply-To: <20110107091720.GM31708@n2100.arm.linux.org.uk>
References: <cover.1292833228.git.viresh.kumar@st.com>
	<73a77c388f8d151ce5bc70000832fbb518babe3b.1292833229.git.viresh.kumar@st.com>
	<4D2679D1.3080005@windriver.com>
	<20110107091720.GM31708@n2100.arm.linux.org.uk>
Message-ID: <4D26DF03.6050805@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> On Fri, Jan 07, 2011 at 10:26:25AM +0800, stanley.miao wrote:
>   
>> Viresh Kumar wrote:
>>     
>>> readl also calls outer cache maintainance operations 
>>>       
>> I use readl here on spear13xx. It works fine.
>> This is the definition of readl, could you tell me which code calls  
>> outer cache maintainance ?
>>
>> #define readl(c) ({ __u32 __v = le32_to_cpu((__force __le32) \
>>                                        __raw_readl(__mem_pci(c))); __v; })
>>     
>
> #define readl(c)                ({ u32 __v = readl_relaxed(c); __iormb(); __v; })
>
> is how it's now defined, and __iormb() is defined to be rmb() on ARMv7+,
> which translates to a dmb.
>
> writel() on the other hand is less straight forward.  It uses __iowmb()
> which translates to a wmb() on ARMv7+, which is a dsb and an outer cache
> sync operation.  This will fail in the decompressor code as there's no
> outer cache support there.
>
>   
Hi, Russell, Thanks for your patient explanation.

With this in mind, I think readl_relaxed() should be better here.

Stanley.

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110107/26ec7e42/attachment-0001.html>
