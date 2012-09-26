From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Sep 2012 11:50:33 -0700
Subject: [PATCH 10/10] ARM: msm: Migrate to common clock framework
In-Reply-To: <CADTbHxpOJ+5xMQ8NkntQtFezwsryzvMDBx8eroNjzfp_5b0DfQ@mail.gmail.com>
References: <1348194419-11486-1-git-send-email-sboyd@codeaurora.org>
 <1348194419-11486-11-git-send-email-sboyd@codeaurora.org>
 <CADTbHxpOJ+5xMQ8NkntQtFezwsryzvMDBx8eroNjzfp_5b0DfQ@mail.gmail.com>
Message-ID: <50634E79.6060205@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/26/12 11:47, Pankaj Jangra wrote:
> Hi Stephen,
>
> On Fri, Sep 21, 2012 at 7:56 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
>
>> -static int pc_clk_set_rate(unsigned id, unsigned rate)
>> +static int pc_clk_set_rate(struct clk_hw *hw, unsigned long new_rate,
>> +                          unsigned long p_rate)
>>  {
>> -       /* The rate _might_ be rounded off to the nearest KHz value by the
>> +       struct clk_pcom *p = to_clk_pcom(hw);
>> +       unsigned id = p->id, rate = new_rate;
>> +       int rc;
>> +
>> +       /*
>> +        * The rate _might_ be rounded off to the nearest KHz value by the
>>          * remote function. So a return value of 0 doesn't necessarily mean
>>          * that the exact rate was set successfully.
>>          */
>> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
>> -       if (rc < 0)
>> -               return rc;
>> -       else
>> -               return (int)id < 0 ? -EINVAL : 0;
>> -}
>> -
>> -static int pc_clk_set_min_rate(unsigned id, unsigned rate)
>> -{
>> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
>> -       if (rc < 0)
>> -               return rc;
>> +       if (p->flags & CLKFLAG_MIN)
>> +               rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
> You are missing if condition here checking the rc ?
>
>>         else
>> -               return (int)id < 0 ? -EINVAL : 0;
>> -}
>> -
>> -static int pc_clk_set_max_rate(unsigned id, unsigned rate)
>> -{
>> -       int rc = msm_proc_comm(PCOM_CLKCTL_RPC_MAX_RATE, &id, &rate);
> and else here i think for the MIN_FLAG if check.
>
>> +               rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
>>         if (rc < 0)
>>                 return rc;
>>         else
>>                 return (int)id < 0 ? -EINVAL : 0;
>>  }

This is the resulting code:

        if (p->flags & CLKFLAG_MIN)
                rc = msm_proc_comm(PCOM_CLKCTL_RPC_MIN_RATE, &id, &rate);
        else
                rc = msm_proc_comm(PCOM_CLKCTL_RPC_SET_RATE, &id, &rate);
        if (rc < 0)
                return rc;
        else
                return (int)id < 0 ? -EINVAL : 0;

So we check the rc for both cases in the same if condition. Is there
anything wrong?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
