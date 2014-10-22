From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Wed, 22 Oct 2014 18:22:09 +0200
Subject: [PATCH] ARM: supplementing IO accessors with 64 bit capability
In-Reply-To: <20141022161155.GB27405@n2100.arm.linux.org.uk>
References: <1413993983-17310-1-git-send-email-mathieu.poirier@linaro.org>
 <20141022161155.GB27405@n2100.arm.linux.org.uk>
Message-ID: <CANLsYkwGtB0=VDFa-p11AGFA1XLjgGQGLa-U4WYtSs7-pHtVdw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22 October 2014 18:11, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Wed, Oct 22, 2014 at 10:06:23AM -0600, mathieu.poirier at linaro.org wrote:
>> @@ -306,10 +324,13 @@ extern void _memset_io(volatile void __iomem *, int, size_t);
>>                                       __raw_readw(c)); __r; })
>>  #define readl_relaxed(c) ({ u32 __r = le32_to_cpu((__force __le32) \
>>                                       __raw_readl(c)); __r; })
>> +#define readq_relaxed(c) ({ u64 __r = le64_to_cpu((__force __le64) \
>> +                                     __raw_readq(c)); __r; })
>>
>>  #define writeb_relaxed(v,c)  __raw_writeb(v,c)
>>  #define writew_relaxed(v,c)  __raw_writew((__force u16) cpu_to_le16(v),c)
>>  #define writel_relaxed(v,c)  __raw_writel((__force u32) cpu_to_le32(v),c)
>> +#define writeq_relaxed(v,c)  __raw_writeq((__force u64) cpu_to_le64(v),c)
>
> You should only define these if we have the corresponding __raw_ versions
> too.

I had this conversation with a colleague who reviewed the work.  If
the architecture is < 5 the __raw_ versions aren't included and the
compiler won't complain until someone tries to use the macros.  We
achieve the same result - the macros aren't accessible when the
architecture doesn't support it - while saving an #if condition in the
file.

I'm not strongly opinionated on this - I can enclose the macros in an
#if statement.

>
> --
> FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
> according to speedtest.net.
