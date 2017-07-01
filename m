From: liuwei@actions-semi.com (=?utf-8?B?5YiY54Kc?=)
Date: Sat, 1 Jul 2017 12:42:56 +0800
Subject: =?utf-8?B?562U5aSNOiBbUEFUQ0ggdjQgMjAvMjhdIEFSTTogb3dsOiBJ?=
 =?utf-8?B?bXBsZW1lbnQgQ1BVIGVuYWJsZS1tZXRob2QgZm9yIFM=?=
 =?utf-8?B?NTAw?=
In-Reply-To: <6d9d0d63-113e-b050-a54e-62746ebc6013@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-21-afaerber@suse.de>
 <CAK8P3a1fLABzSc7kej6uw751uoZma1Qvpm7c3mkLB45rcBNQTA@mail.gmail.com>
 <CAK8P3a3Pg2rm8nSPUm_E61F7+zSr3gWV6sNqhC0Et3Zh2xPtmA@mail.gmail.com>
 <6d9d0d63-113e-b050-a54e-62746ebc6013@suse.de>
Message-ID: <DC4E6E803E914F4B8AFE57F1456019F1035B7C89@srv-mail-02.actions.com.cn>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Andrea

OWL_CPUx_ADDR is the physical address of CPUx wakeup function.
OWL_CPUx_FLAG is a valid flag of OWL_CPUx_ADDR. 

After CPUxs are wakeuped by SEV instruction, they will check their own OWL_CPUx_FLAG register. If the register vlaue is 0x55aa, CPUx will jump to OWL_CPUx_ADDR to boot up, otherwize go to sleep by WFE.

So the pen release staff is not necessary, you can remove these code safely.

BTW: CPU2/3 must exit the power gate state before wakeup, and CPU1 is always power on and has no power gate control.

Best Regards,
David Liu

-----????-----
???: Andreas F?rber [mailto:afaerber at suse.de] 
????: 2017?6?29? 23:22
???: Arnd Bergmann; Thomas Liau
??: Linux ARM; mp-cs; ???; ??; ???; 96boards at ucrobotics.com; support at lemaker.org; Linux Kernel Mailing List; Russell King
??: Re: [PATCH v4 20/28] ARM: owl: Implement CPU enable-method for S500

Am 29.06.2017 um 17:07 schrieb Arnd Bergmann:
>>> +static int s500_smp_boot_secondary(unsigned int cpu, struct 
>>> +task_struct *idle) {
>>> +       unsigned long timeout;
>>> +       int ret;
>>> +
>>> +       ret = s500_wakeup_secondary(cpu);
>>> +       if (ret)
>>> +               return ret;
>>> +
>>> +       udelay(10);
>>> +
>>> +       spin_lock(&boot_lock);
>>> +
>>> +       /*
>>> +        * The secondary processor is waiting to be released from
>>> +        * the holding pen - release it, then wait for it to flag
>>> +        * that it has been released by resetting pen_release.
>>> +        */
>>> +       write_pen_release(cpu_logical_map(cpu));
>>> +       smp_send_reschedule(cpu);
>>> +
>>> +       timeout = jiffies + (1 * HZ);
>>> +       while (time_before(jiffies, timeout)) {
>>> +               if (pen_release == -1)
>>> +                       break;
>>> +       }
>>> +
>>> +       writel(0, timer_base_addr + OWL_CPU1_ADDR + (cpu - 1) * 4);
>>> +       writel(0, timer_base_addr + OWL_CPU1_FLAG + (cpu - 1) * 4);
>>> +
>>> +       spin_unlock(&boot_lock);
>>> +
>>> +       return pen_release != -1 ? -ENOSYS : 0; }
>>
>> This looks more complicated than necessary. Why do you need the 
>> holding pen when you have a register to start up the CPU?
>>
> 
> It seems you missed my question here. Can you please follow up, and if 
> possible send a patch to remove the pen_release logic that appears to 
> be unnecessary here?

I do not have any documentation on these registers, only the downstream code that I forward-ported here. If you tell me what you mean exactly, I can do some testing and if it still works submit a patch to simplify it.

Comments from the so far quiet Actions Semi side would help, too.

Regards,
Andreas

--
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton HRB 21284 (AG N?rnberg)
