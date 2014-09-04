From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Sep 2014 19:31:02 +0200
Subject: [PATCH 07/11 v5] coresight-etm: add CoreSight ETM/PTM driver
In-Reply-To: <CANLsYkzAE1a8SmbEtGz5f14NfHX0R51RBAUkZZv==OkZBJzTFw@mail.gmail.com>
References: <1409159852-7249-1-git-send-email-mathieu.poirier@linaro.org>
 <1409159852-7249-8-git-send-email-mathieu.poirier@linaro.org>
 <CACRpkdZO7Mo_JaecjypR_kXKwaatgU+4oLLKheQ22OcNMG_-nQ@mail.gmail.com>
 <CANLsYkzAE1a8SmbEtGz5f14NfHX0R51RBAUkZZv==OkZBJzTFw@mail.gmail.com>
Message-ID: <CACRpkda6Rj0ZJ4NfKtqV=0p_OVEpjmSLNsUM7Z0MC3UMn43HGg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 4, 2014 at 7:19 PM, Mathieu Poirier
<mathieu.poirier@linaro.org> wrote:
> [Me]:
>> I would rewrite the last function like this:
>>
>> static inline unsigned int etm_readl(struct etm_drvdata *drvdata, u32 off)
>> {
>>        u32 val;
>>
>>        if (drvdata->use_cp14)
>>                asm_volatile()...
>>        else
>>                val = readl_relaxed(drvdata->base + off);
>>        return val;
>> }
>
> That unfortunately won't work.  "u32 off" is a numerical value and it
> works well in the case were CP14 accesses aren't needed.  On the flip
> side that numerical value isn't sufficient to deduce all 3 arguments
> (crn, crm, op2) required by instructions mcr/mrc for the right access
> to happen - there is simply no correlation between the offset of an
> APB bus memory mapped address and the corresponding CP14 access.

You're right, I oversimplified it in my head grossly...

Jens Wiklander pointed me to the macros used in OP-TEE for CP15
access with the same unpredictable patterns:
https://github.com/OP-TEE/optee_os/tree/master/core/arch/arm32/include

Yours,
Linus Walleij
