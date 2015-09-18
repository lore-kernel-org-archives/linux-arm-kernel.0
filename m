From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Fri, 18 Sep 2015 06:12:56 -0700
Subject: [PATCH v2 2/3] soc: brcmstb: Add Bus Interface Unit control setup
In-Reply-To: <55FAFB7A.4010105@gmail.com>
References: <1442340900-15320-1-git-send-email-f.fainelli@gmail.com>
 <1442340900-15320-3-git-send-email-f.fainelli@gmail.com>
 <CADtm3G6SkczVkFK0n=fpMCkocj_ijGWtHkfipTZZfp8deC=6zg@mail.gmail.com>
 <55FAFB7A.4010105@gmail.com>
Message-ID: <CADtm3G4bhPd4Jd+wP-Fa1cZXpY-8su-OKBnPOU3dMN3Be8yx8A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 17, 2015 at 10:42 AM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> On 16/09/15 23:08, Gregory Fong wrote:
>>> [...]
>>> diff --git a/drivers/soc/brcmstb/biuctrl.c b/drivers/soc/brcmstb/biuctrl.c
>>> new file mode 100644
>>> index 000000000000..1d4deada1c4d
>>> --- /dev/null
>>> +++ b/drivers/soc/brcmstb/biuctrl.c
>>> @@ -0,0 +1,119 @@
>>> [...]
>>> +int __init brcmstb_biuctrl_init(void)
>>> +{
>>> +       int ret = 0;
>>> +
>>> +       ret = setup_hifcpubiuctrl_regs();
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       ret = mcp_write_pairing_set();
>>> +       if (ret) {
>>> +               pr_err("MCP: Unable to disable write pairing!\n");
>>> +               return ret;
>>
>> The return value isn't used in patch 3.  Is there a point to returning
>> an error from this function in either of the above two locations,
>> considering that?
>>
>> Looks good otherwise.
>>
>> Acked-by: Gregory Fong <gregory.0xf0@gmail.com>
>
> Not really, how about this:
>
> void __init brcmstb_biuctrl_init(void)
> {
>         int ret;
>
>         setup_hifcpubiuctrl_regs();
>
>         ret = mcp_write_pairing_set();
>         if (ret) {
>                 pr_err("MCP: Unable to disable write pairing!\n");
>                 return;
>         }
>
> #ifdef CONFIG_PM_SLEEP
>         register_syscore_ops(&brcmstb_cpu_credit_syscore_ops);
> #endif
> }
>
> and updating the function prototype accordingly in the header file?

Sure, that works.

Thanks,
Gregory
