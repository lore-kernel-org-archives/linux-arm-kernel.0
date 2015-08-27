From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Thu, 27 Aug 2015 11:36:16 -0700
Subject: [PATCH] soc: ti: reset irq affinity before freeing irq
In-Reply-To: <55DF581A.2090300@mentor.com>
References: <1440690671-1029-1-git-send-email-m-karicheri2@ti.com>
 <55DF3E3F.6030506@mentor.com> <55DF5589.6050802@ti.com>
 <55DF581A.2090300@mentor.com>
Message-ID: <55DF58A0.8090105@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8/27/15 11:34 AM, Nathan Lynch wrote:
> On 08/27/2015 01:23 PM, Murali Karicheri wrote:
>> On 08/27/2015 12:43 PM, Nathan Lynch wrote:
>>> On 08/27/2015 10:51 AM, Murali Karicheri wrote:
>>>> When using accumulator queue for rx side for network driver, following
>>>> warning is seen when doing a reboot command from Linux console. This
>>>> is because, affinity value is not reset before calling free_irq(). This
>>>> patch fixes this.
>>>>
>>>> Deconfiguring network interfaces...
>>>> [   55.176589] ------------[ cut here ]-----------
>>>> [   55.181232] WARNING: CPU: 0 PID: 2081 at kernel/irq/manage.c:1370
>>>> __free_irq+0x208/0x214
>>>
>>> The full content of the warning should be included in the commit
>>> message; __free_irq has several potential sources of warning messages,
>>> and line 1370 doesn't correspond to any of them in 4.2-rc8.
>>
>> The log corresponds to 4.1.x kernel. Corresponding WARN_ONCE is
>>
>> #ifdef CONFIG_SMP
>>          /* make sure affinity_hint is cleaned up */
>>          if (WARN_ON_ONCE(desc->affinity_hint))
>>                  desc->affinity_hint = NULL;
>> #endif
>>
>> Which is line 1922. I can edit to make it 1922. Does that work?
>
> Eh, I guess I wasn't thinking clearly about this clearly when I wrote
> that.  (I somehow had the notion that WARN_ON... maybe printed more than
> just the file and line number, but that is clearly mistaken.)  I think
> your message is fine as is, sorry for the noise.
>
> I don't think changing the line number will make it any easier on future
> readers.
>
Right. Just leave the full call in the commit so that the context
is captured.
